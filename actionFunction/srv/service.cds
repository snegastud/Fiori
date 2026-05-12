using {function.db as db  } from '../db/schema';

service functionService {

    entity order as projection on db.order;

    entity customer as projection on db.customer;


     // bound function
    function getOrderByID(ID:Integer)  returns Integer;


    entity  totalOrderView as select from customer;
    

}