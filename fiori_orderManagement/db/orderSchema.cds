namespace order.db;

entity  Order {
    key ID:Integer;
    orderNumber       : String;
    status            : String;
    @Measures.ISOCurrency : currency
    totalAmount       : Decimal(10,2);
    currency          : String ;
    billingAddress    : String;
    shippingAddress   : String; 
    adharID           : String(12) @Common :{Masked:true};
    criticality     : Integer;  
    myDate     : DateTime @UI.DateTimeStyle:'short';

    orderItemsDetails:Composition of many OrderItems on orderItemsDetails.OrderDetails=$self;


}

entity OrderItems{

    key ID : Integer;
    product : Association to Products;
    quantity      : Integer;
    price         : Decimal(10,2);
    OrderDetails:Association to Order;



}
entity Products {
    key ID        : Integer;
    productName   : String;
    price         : Decimal(10,2);
    imageUrl      : String;
    rating        : Integer;
    description    : LargeString @UI.MultiLineText;
    supportEmail    : String @Communication.IsEmailAddress;
    supportPhone    : String @Communication.IsPhoneNumber;
   
}

entity StatusVH {
    key status : String;
  
}