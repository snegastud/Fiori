/*const cds =require('@sap/cds');

module.exports=cds.service.impl(function() {

    const {customer,orders}=this.entities;


   this.before('CREATE',orders,async(req)=>{

        console.log(req.data);
        const {ID,orderItems,status,price,customerdetails_ID}=req.data;

        
        const datas= await INSERT.into(orders).entries(req.data);

        console.log(datas);


        const value=await SELECT.one.from(orders).where({ID:ID});

        console.log(value);

        return value;

       if(price>500){
        req.data.status='SUCCESS';

       }
       else{
        req.data.status="PENDING";
       } 

       const value=await SELECT.one.from(customer).where({ID:customerdetails_ID});

       if(!value){
        req.error(404,"ID not found")
       }

       console.log(value);

       



    })


    this.on('READ',customer,async(req)=>{

        const data=await SELECT.from(customer).columns('customerName','ID').where(`ID =102`).orderBy(`customerName desc`).limit(1);
        return data;


        
        
    })

  

})*/


const cds =require('@sap/cds');
const { SELECT, DELETE } = require('@sap/cds/lib/ql/cds-ql');

module.exports=cds.service.impl(function(){

    const {user} =this.entities;
    this.on('UPDATE',user,async(req)=>{
        
        const id=req.params[0].ID;

        const {userName,age}=req.data;

        console.log(req.data);
       
        const data=await SELECT.one.from(user).where({ID:id});

        console.log(data);
        
        if(!data){
            req.error(404,"id not found error here");
        }


        await UPDATE(user).set(req.data).where({ID:id});

        const values=await SELECT.one.from(user).where({ID:id});
        
        console.log(values);

        return values;

    })

    this.on('DELETE',user,async(req)=>{
        
        const id=req.params[0].ID;

        console.log(id);

        const data=await SELECT.one.from(user).where({ID:id});

        console.log(data);

        if(!data){
            req.error(404,"id is not found");
        }

         return await DELETE.from(user).where({ID:id});
         
         




    })
})


