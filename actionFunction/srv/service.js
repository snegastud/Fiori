//const cds = require("@sap/cds");

module.exports=(srv)=>{

    srv.on('getOrderByID',async(req)=>{
        const {ID}=req.data;

        console.log(req.data);

        const data=await SELECT.from('function.db.order').where({orderDetails_ID:ID});

        console.log(data);

        if(!data){
            req.error(404,'Id is not found');

        }
        return data.reduce((sum,x)=>sum+x.amount,0);

    
      
    })


}