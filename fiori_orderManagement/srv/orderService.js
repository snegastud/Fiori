const cds=require('@sap/cds');

module.exports=cds.service.impl(async function(){

    
    const {Order, OrderItems,product}=this.entities;

  

this.before('CREATE', Order, async (req) => {

    console.log(req.data);

    req.data.status = 'PENDING';
    req.data.criticality = 2;

    if(!req.data.orderNumber){
        req.error(400,'ordernumber is required')
    }
    if(!req.data.billingAddress ){
        req.error(400,'billingAddress is required')
    }

    if(!req.data.shippingAddress){
        req.error(400,'shippingAddress is required')
    }
    let total = 0;

    if (req.data.orderItemsDetails) {
         
       

        for (const item of req.data.orderItemsDetails) {
              
            item.price=0;

            if (!item.product_ID) {
                req.error(400, 'PRODUCT ID IS REQUIRED');
            }

            if (!item.quantity) {
                req.error(400, 'QUANTITY IS REQUIRED');
            }

            const productData = await SELECT.one
                .from(product)
                .where({ ID: item.product_ID });

            console.log(productData);

            if (!productData) {
                req.error(404, `Product ${item.product_ID} not found`);
            }

                     item.price=productData.price;

                total += productData.price * item.quantity;

        
        }
    }

    req.data.totalAmount = total;
});


    this.on('approveOrder',async(req)=>{
        const{ID}=req.params[0];

        const id= await SELECT.one.from(Order).where({ID:ID});
        if(!id){
            req.error(404,"ID not found");
        }

         await UPDATE(Order).set({status:'APPROVED',criticality:3}).where({ID:ID});

         req.notify(`Order ${ID} Approved Successfully`);
    });
  
    this.on('rejectOrder', async (req) => {

    const { ID } = req.params[0]; 

    const order = await SELECT.one.from(Order).where({ ID });

    if (!order) {
        req.error(404, "Order not found");
    }

    await UPDATE(Order)
        .set({ status: 'REJECTED',
            criticality:1})
        .where({ ID });

 
    req.notify(`Order ${ID} Rejected Successfully`);

});

this.on('calculateTotal', async (req) => {
    const id = req.params[0].ID;

    console.log("Order ID:", id);

    const data = await SELECT.from(OrderItems)
        .where({ OrderDetails_ID: id });

    console.log("Items:", data);

    if (!data.length) {
        return `No items found for Order ${id}`;
    }

    let total = 0;

    for (let items of data) {
        total += items.quantity * items.price;
    }

   
  req.info(`Total Amount for Order ${id} is: ${total}`);
});


this.before('CREATE', 'OrderItems', async (req) => {

    const { product_ID, quantity } = req.data;

    console.log(req.data);

    if (!product_ID || !quantity) return;

    const productData = await SELECT.one
        .from(product)
        .where({ ID: product_ID });

    if (!productData) {
        req.error(400, 'Product not found');
    }

    if (productData) {
        req.data.price = productData.price * quantity;
    }
});


this.on('createOrder',async(req)=>{
     
   const {ID,product_ID,quantity,price,OrderDetails_ID}=req.data;

   if(!ID){
    req.error(400,"ID NOT FOUND");
   }
   const data= await SELECT.one.from(product).where({ID:product_ID});

   if(!data){
    req.error(404,'PRODUCT ID NOT FOUND')

   }

   

   if(!quantity){
    req.error(400,"QUANTITY FIELD IS REQUIRED..! ");
   }

   if(price<0){
    req.reject(400,"price should be greather than values");
   }

   const value=await SELECT.one.from( Order).where({ID:OrderDetails_ID});

   if(!value){
    req.error(404,"ORDERITEMS ID NOT FOUND ");
   }

   

    const inserted=await INSERT.into(OrderItems).entries(req.data);

   req.notify(`orderItems values created ${ID}successfully`)

   return inserted;

});
})