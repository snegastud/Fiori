namespace order.db;
entity Orders {
    key ID           : Integer;
        orderNumber  : String(20);
        customerName : String(100);
        productName  : String(100);
        quantity     : Integer;
        totalAmount  : Decimal(15,2);
        currency     : String(5);
        status       : String(20);
}
