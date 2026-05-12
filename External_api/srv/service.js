const cds=require('@sap/cds');

require('dotenv').config();

module.exports=cds.service.impl(function (){

const {country}= this.entities;

this.on('getDetails',async(req)=>{
    
    const {State}=req.data;

    if(!State){
        req.error(404,"state is required");
    }

    try{

        const response=await axios.get(`http://api.geonames.org/searchJSON?q=${State}&maxRows=1&featureCode=ADM1&username=geoapiss`);
        
        console.log("snega",response)

        console.log(response.data);

            if (response.data.geonames.length === 0) {
                return req.error(400, 'state not found');
            }

       const data=response.data.geonames.map(x=>{
             return {
        stateName: x.name,
        latitude: x.lat,
        longitude: x.lng,
        countryName: x.countryName,




                }
            })

        await INSERT.into(country).entries(data);

        return data;

   

     


    }
    catch(error){

        console.log(error.message);

        return req.error(500,"server error")

    }

});



this.on('getStates',async(req)=>{

    const {CountryCode}=req.data;

    console.log(req.data);

    if(!CountryCode){
        return req.error(400,'countrycode is required');
    }

    const response=await axios.get(`https://api.countrystatecity.in/v1/countries/${CountryCode}/states`,{
          headers: { 'X-CSCAPI-KEY': process.env.API_KEY }
    })

     console.log(response);

     return response.data;

})

})