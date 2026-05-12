namespace crestore.db;

using {cuid} from '@sap/cds/common';
entity stateDetails:cuid{
  
   api_id: Integer;
    name:String;
    country_id:Integer;
    country_code:String;
    iso2: String;
    latitude: String;
    longitude: String;
    timezone: String; 

}