using { xsuaa.db as db  } from '../db/xsuaaSchema';


service xsuaaApi {

entity UserProfile  @(restrict:[{
    grant:['CREATE','READ'],
    to:['UserOnly']
},
{
   grant:['READ'],
   to:['AdminOnly']
}])  as projection on db.UserProfile;

    
}
