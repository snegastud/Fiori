using fioriService as service from '../../srv/fioriService';
annotate service.user with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Value : userName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'userAge',
                Value : userAge,
            },
            {
                $Type : 'UI.DataField',
                Label : 'userAddress',
                Value : userAddress,
            },
            {
                $Type : 'UI.DataField',
                Label : 'userStateCode',
                Value : userStateCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'userStateName',
                Value : userStateName,
            },
            {
                $Type : 'UI.DataField',
                Value : Approved,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'ID',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Value : userName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'userAge',
            Value : userAge,
        },
        {
            $Type : 'UI.DataField',
            Label : 'userAddress',
            Value : userAddress,
        },
        {
            $Type : 'UI.DataField',
            Label : 'userStateCode',
            Value : userStateCode,
        },
    ],
);

