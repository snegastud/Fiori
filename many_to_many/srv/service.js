const cds =require('@sap/cds');


module.exports=cds.service.impl(function(){


    const {orders} =this.entities;


    this.on('READ',orders,async(req)=>{
        
        const data=await SELECT.from(orders);

        console.log(data);

        const value=await SELECT.from(orders).where(`amount > 1000`);

        console.log(value);

        return value;
    })
})

// api status and as well as 

