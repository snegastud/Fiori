using {application.db as db} from '../db/applicationSchema';

service application {

    entity Customer as projection on db.Customer;

   }