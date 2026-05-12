const cds = require('@sap/cds');
const xsenv = require('@sap/xsenv');
const axios = require('axios');
const https = require('https');

module.exports = cds.service.impl(async function () {


    const { stateDetails } = this.entities;
    
    const services = xsenv.getServices({
        credstore: {  name: 'credstore-service' }
    });


    if (!services.credstore) {
        throw new Error("Credential Store not found in VCAP_SERVICES");
    }

    const cred = services.credstore;

    console.log("Credstore URL:", cred.url);

    
    const agent = new https.Agent({
        cert: cred.certificate,
        key: cred.key
      
    });

  
    async function getApiKey() {
        try {
            const response = await axios.get(
                `${cred.url}/password?name=csc-api-key`,
                {
                    httpsAgent: agent
                }
            );

            return response.data.value;

        } catch (error) {
            console.error("Error fetching API key:", error.message);
            return null;
        }
    }

   
    this.on('fetchAndStoreStates', async (req) => {

        const apiKey = await getApiKey();

        if (!apiKey) {
            return req.error(500, 'API Key not found in Credential Store');
        }

        try {
          
            const response = await axios.get(
                `https://api.countrystatecity.in/v1/countries/IN/states`,
                {
                    headers: {
                        'X-CSCAPI-KEY': apiKey
                    }
                }
            );

            const states = response.data;

            const dataToInsert = states.map(state => ({
                api_id: state.id,
                name: state.name,
                country_id: state.country_id,
                country_code: state.country_code,
                iso2: state.iso2,
                latitude: state.latitude,
                longitude: state.longitude,
                timezone: state.timezone
            }));

          
            const tx = cds.tx(req);

            await tx.run(DELETE.from(stateDetails));

       
            await tx.run(INSERT.into(stateDetails).entries(dataToInsert));

            return dataToInsert;

        } catch (error) {
            console.error("External API Error:", error.message);
            return req.error(500, 'Failed to fetch states from API');
        }
    });

});