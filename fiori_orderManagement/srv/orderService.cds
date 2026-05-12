using {order.db as db} from '../db/orderSchema';

service orderApi {
    
   
    entity   Order  as projection on db.Order
            actions {
            action approveOrder() returns Order;
            action rejectOrder() returns Order;
            action calculateTotal(sum:String) returns String;

        };

    

    entity OrderItems as projection on db.OrderItems;

    action createOrder( ID :Integer, product_ID:Integer,quantity:Integer,price: Decimal(10,2),OrderDetails_ID:Integer) returns OrderItems;
    
    entity product as projection on db.Products;
    
    entity StatusVH as projection on db.StatusVH;


   

}