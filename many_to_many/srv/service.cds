using {schema.db as db} from '../db/schema';

service userRoleApi {

entity user @(restirct:[
        {
              grant:['CREATE','READ'],
              to:'Snega'
    }]) as projection on db.user;

entity role as projection on db.role;

entity userRole as projection on db.userRole;

entity orders as projection on db.orders;

/*entity orderView as select from orders{
    ID,
    status,
    count(status) as totalstatus
} group by status*/
    

}