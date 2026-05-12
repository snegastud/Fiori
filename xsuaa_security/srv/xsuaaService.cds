using {xsuaasecurity.db as db} from '../db/xsuaaSchema';


service xsuaaService {

entity Userprofile  @(restrict:[{
    grant:['CREATE','READ'],
    to:['UserAdminRole']
}]) as projection on db.Userprofile;
    

}