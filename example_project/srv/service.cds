using {example.db as db} from '../db/schema';

@path:'/Api'

@impl:'srv/exampleservice.js'
/*service exampleApi{
    entity customer as projection on db.customer{
        ID,
        customerName,
        phone,
        address.city,
        address.state,
        address.addressNumber,
        OrdersDetails
    } 
    entity orders as projection on db.orders;



    /*entity vies as projection on orders{
        *
    }where price >=500 and price <=1000;


    entity addressView as select from customer{
        ID,
        customerName,
        phone
    } where city = 'chennai' order by customerName asc;


    entity orderSum as select from orders{
        max(price) as totalSum
    } ;

    entity limitview as select from orders{
      *
    } limit 1 offset 1;

    entity joinView as select from orders{
        ID,
        orderItems,
        customerdetails.state,
        customerdetails.customerName,
        customerdetails.city
    

    }*/
//}
/*service manyApi{

    entity  student as projection on db.student
    {
    ID,
    Student,
    age,
    studentDetails.courseID.courseName,
    studentDetails.courseID.state
    }

    entity course as projection on db.course;

    entity studentCourse as projection on db.studentCourse;
}*/

service UserApi{
    entity user as projection on db.user;
}