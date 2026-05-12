namespace fiori.db;

@cds.search: { userName, userState }
entity User{
    key ID:Integer;
    @UI.lineItem:[{ position: 10 }]
    @UI.identification: [{ position: 10 }]
   
    @Common.Label: 'User Name'
    userName:String;
    @UI.lineItem:[{ position: 20 }]
    @UI.identification: [{ position: 20 }]
    userAge:Integer;
    @UI.lineItem:[{ position: 30 }]
    @UI.identification: [{ position: 30 }]
    userAddress:String;
    @UI.lineItem:[{ position: 40 }]
    @UI.identification: [{ position: 40 }]
    @Common.Text: userStateName
    userStateCode:String;   
    @UI.lineItem:[{ position: 50 }]
    @UI.identification: [{ position: 50 }]
    userStateName:String;
   
    @UI.identification: [{ position: 60 }]
    @Common.Label: 'Approved'
    
    @UI.lineItem: [{ position: 60 }]
    Approved: Boolean default false;

   
}

/*extend entity with User{
    Status: String;
    StatusCriticality: Integer;
}*/
