/*const cds =require('@sap/cds');

//const axios = require('axios');

//require('dotenv').config();

module.exports=cds.service.impl(async function(){

    this.on('getStates',async(req)=>{ 

    const {countryCode}=req.data; 

    console.log(req.data); 

    if(!countryCode){ 

        return req.error(400,'countrycode is required'); 

    } 

    const response=await axios.get(`https://api.countrystatecity.in/v1/countries/${countryCode}/states`,{ 

          headers: { 'X-CSCAPI-KEY': process.env.API_KEY } 

    }) 

    console.log(response); 
  
     const value=response.data.map(x=>({
        name:x.name
        
     }))
 
    return value;

 

});
})*/

/*const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

  const countryApi = cds.connect.to('country');

  this.on('getStates', async (req) => {

    const { countryCode } = req.data;

    console.log(req.data);

    if (!countryCode) {
      return req.error(400, 'countrycode is required');
    }

    
      const response = await countryApi.request({
      method: 'GET',
      path: `/countries/${countryCode}/states`
    });

    console.log(response);

    const value = response.map(x => ({
      name: x.name
    }));

    return value;

  });

});*/
const cds = require('@sap/cds');

module.exports = cds.service.impl(function () {

    this.on('getStates', async (req) => {

        const { stateCode } = req.data;

        console.log(req.data);

        if (!stateCode) {
            return req.error("stateCode is required");
        }

        try {

            console.log('Calling external API...');

            const countrySrv = await cds.connect.to('country');

            const response = await countrySrv.send({
                method: 'GET',
                path: `/countries/${stateCode}/states`
            });

            const data = response;

            if (!data || data.length === 0) {
                return req.error(404, 'state not found');
            }

            const result = data.map(x => ({
                name: x.name
             
            }));

           

            return result;

        } catch (error) {
            console.log(error.message);
            return req.error(500, "internal server error");
        }
    });

});