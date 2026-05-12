namespace example.db;

/*type phonenumber:String;

entity customer{
    key ID:Integer;
    customerName:String default 'unknow' not null;
    phone:phonenumber;
    @cd.api.ignore
    address:addressDetails;
    value=count(ID);
   
    OrdersDetails:Composition of many orders on  OrdersDetails.customerdetails=$self;
}

entity orders{
    key ID:Integer;
    orderItems:String;
     @assert.enum
    status:statusDetails;
    @assert.range: [1,1000]
     price:Integer;
    //@assert.target
    customerdetails:Association to customer;
    
}

type statusDetails:String enum{
    PENDING;
    ORDER;
    SUCCESS;

}
type addressDetails{
    city:String;
    addressNumber:String;
    state:String;
}
/*aspect address{
    city:String;
    state:String;
}

entity student: address{
    key ID:Integer;
    Student:String;
    age:Integer;
    studentDetails:Association to many studentCourse on studentDetails.studentID=$self;
}

entity course: address{
    key ID:Integer;
    courseName:String;
    courseDetails:Association to many studentCourse on courseDetails.courseID=$self;
    
}

entity studentCourse{
    key studentID:Association to student;
    key courseID:Association to course;
}*/

entity user{
    key ID:Integer;
    userName:String;
    age:Integer;
    message:String;
    language:String
   
}
