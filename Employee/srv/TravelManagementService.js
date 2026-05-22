
const cds =require('@sap/cds');
const { SELECT, UPDATE } = require('@sap/cds/lib/ql/cds-ql');

const axios = require('axios');

module.exports=cds.service.impl(async function(){


    const {TravelRequest,TravelDocuments}=this.entities;

    const { Employees,Departments} = cds.entities('employee.db');

    this.on('READ','States',async()=>{

         const response = await axios.get(
            "https://81a21727trial-dev-countryexternalapi-srv.cfapps.us10-001.hana.ondemand.com/odata/v4/country-external-api/getStates(stateCode='IN')"
        );

        console.log(response);
       

        return response.data.value;

    })

    this.before('CREATE',TravelRequest,async(req)=>{

        const {employeeTravelRequest_ID,travelStartDate,travelEndDate,estimatedCost,travelPurpose_travel,travelDocument}=req.data;

        console.log("UserInput",req.data)

        if(!employeeTravelRequest_ID){

            return req.error(400,"EmployeeId is required");

        }
        if(!travelPurpose_travel){

            return req.error(400,"Please mention your travel purpose reason")
        }

        const empId=await SELECT.one.from(Employees).where({ID:employeeTravelRequest_ID});

        console.log("Employee details:",empId);

        if(!empId){

            return req.error(404,"EmployeeID not found");


        }

        if(!travelStartDate){

            return req.error(400,"Please select travelStartDate");
        }

        if(!travelEndDate){

            return req.error(400,"Please select travelEndDate");
        }

        const start=new Date(travelStartDate);

        const end=new Date(travelEndDate);


        if(start>end){

            return req.error(404,"Invalid date entry")
        }

        if(estimatedCost<=0){

            return req.error(400,"Please enter estimateCost");
        }
        
        const limit=await SELECT.one.from(Departments).where({ID:empId.department_ID})

        console.log("department details",limit);


        if(estimatedCost > limit.budgetLimit){

            return req.error(400,`Budget exceeded. Limit is ${limit.budgetLimit}`)
        }

        if (!travelDocument || travelDocument.length === 0) {
             
         return req.error(400, "At least one document is required");

        }

        req.data.travelStatus_status = 'PENDING';
        req.data.UploadedDate=new Date();
      

    });

    this.on('approve',async(req)=>{
        
        const travelID=req.params[0].ID;

        console.log("TravelID:",travelID);

        const travelReq=await SELECT.one.from(TravelRequest).where({ID:travelID});

        console.log(travelID)

        if(!travelReq){
            
            return req.error(404,"TravelRequest is not received for this ID");
        }


        if(travelReq.travelStatus_status==='APPROVED'){

            return req.error(409,"Travel request is alread approved")

        }

        if(travelReq.travelStatus_status==='REJECTED'){

            return req.error(409,"Travel request is already approved")
        }
       

        const employee = await SELECT.one.from(Employees).where({ ID: travelReq.employeeTravelRequest_ID });

        const approver = await SELECT.one.from(Employees) .where({ ID: employee.manager_ID });

        if (!approver) {

        return req.error(404, "Approver not found");

        }
        
        await UPDATE(TravelRequest) .set({travelStatus_status: 'APPROVED',approver_ID: approver.ID}) .where({ ID: travelID });

        const data=await SELECT.one.from(TravelRequest).where({ID:travelID})

        console.log("updated approver value:",data)

        return { message: "Travel Approved" };

    })

    this.on('reject',async(req)=>{

        console.log("ID details",req.params[0].ID);


        console.log(req.data);

        const rejectReason=req.data.rejectionReason;

        const travelId=req.params[0].ID;

        console.log("travelID details",travelId);

        const data=await SELECT.one.from(TravelRequest).where({ID:travelId});

        if(!data){

            return req.error(404,"Travel id not found");
        }

        if(data.travelStatus_status==='REJECED'){

            return req.error(409,"Already Rejected")
        }

       const empID=await SELECT.one.from(Employees).where({ID:data.employeeTravelRequest_ID});

       const manager= await SELECT.one.from(Employees).where({ID:empID.manager_ID});

       if(!manager){

        return req.error(404,"Manager not found");
       }

       await UPDATE(TravelRequest).set({travelStatus_status:'REJECTED',approver_ID:manager.ID,rejectionReason:rejectReason})

       const value=await SELECT.one.from(TravelRequest).where({ID:travelId})

       return value;

    })
    
})