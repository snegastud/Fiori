service countryExternalApi {
 
    function getStates(stateCode :String) returns many stateDetails;
 
    type stateDetails{
      name : String;
     
   }
 
}