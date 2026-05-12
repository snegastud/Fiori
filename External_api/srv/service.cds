using { external.db as db} from '../db/schema';

service coutryApi {

entity country as projection on db.Country;


type location{
        stateName: String;
        latitude: String;
        longitude: String;
        countryName: String;
}


function getDetails(State:String) returns location;

   type StateDetails {
        id           : String;
        name         : String;
        country_id   : String;
        country_code : String;
        iso2         : String;
        latitude     : String;
        longitude    : String;
        timezone     : String;
    }
function  getStates(CountryCode:String) returns many StateDetails;

    

}