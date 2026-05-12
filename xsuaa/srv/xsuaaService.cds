using {xsuaa.db as db} from '../db/xsuaaSchema';

service xsuaa{
    entity user @(restrict:[
        {
              grant:['CREATE','READ'],
              to:'Snega'
    }]) as projection on db.user;
}
