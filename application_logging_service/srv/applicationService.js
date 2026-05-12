const cds = require("@sap/cds")
module.exports =cds.service.impl(function(){
const {Customer}=this.entities;
const LOG = cds.log('customer-service'); 
this.on('CREATE', Customer, async (req) => {
LOG.info('Request received', { data: req.data });
try {
      if (!req.data.name) {
        LOG.warn('Validation failed: Name missing', { data: req.data });
        return req.error(400, "Name is required");
      }
      if(!req.data.email){
        LOG.warn('Validation failed:Email missing',{data:req.data});
        return req.error(400, "Email is required");
      }
    LOG.info('Customer created successfully', {
        id: req.data.ID
      });
    return req.data;
} catch (err) {

      LOG.error('Error while creating customer', {
        message: err.message
       
      });

      throw err;
    }
  });
})