namespace schema.db;

entity user{
    key ID:Integer;
    userName:String;

    roledetails:Association to many userRole on roledetails.userID=$self;

}

entity role{
    key ID:Integer;
    roleName:String;
    userDetails:Association to many userRole on userDetails.roleID=$self;
}

entity userRole{
    key userID:Association to user;
    key  roleID:Association to role;
}

// id status amount orderBy

entity orders{
    key ID:Integer;
    status:String;
    amount:Integer;
    orderBy:String;
}