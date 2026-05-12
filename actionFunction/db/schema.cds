namespace function.db;

entity customer{
    key ID:Integer;
    customerName:String;
    Address:address ;
    customerDetails:Association to many order on customerDetails.orderDetails=$self;
}

entity order{
    key ID:Integer;
    orderName:String;
    amount:Integer;
   

    orderDetails:Association to customer;
}

type address{
    city:String;
    address:String;
}