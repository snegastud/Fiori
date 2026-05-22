using orderApi as service from '../../srv/orderService';

annotate service.Order with @(
    Aggregation.ApplySupported: {
    
        Transformations : [
            'aggregate',
            'groupby',
            'filter',
            'search',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'expand'
        ],
    
        Rollup : #None,
    
        PropertyRestrictions : true,
    
        GroupableProperties : [
            status,
            currency,
            billingAddress,
            shippingAddress
        ],
    
        AggregatableProperties : [
            {
                Property : totalAmount
            }
        ]
    },
    Analytics.AggregatedProperty #totalAmount_sum : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'totalAmount_sum',
        AggregatableProperty : totalAmount,
        AggregationMethod : 'sum',
        @Common.Label : 'totalAmount (Sum)',
    },
    UI.Chart #alpChart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Pie,
        Dimensions : [
            status,
            currency,
            shippingAddress,
            billingAddress,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#totalAmount_sum',
            '@Analytics.AggregatedProperty#totalAmount_min',
        ],
        Title : 'Orders By Status',
    },
    Analytics.AggregatedProperty #totalAmount_min : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'totalAmount_min',
        AggregatableProperty : totalAmount,
        AggregationMethod : 'min',
        @Common.Label : 'totalAmount (Minimum)',
    },
);

annotate service.Order with @(

    UI.Chart #OrderStatusChart : {

        Title : 'Orders By Status',

        ChartType : #Line,

        Dimensions : [
            status
        ],

        DimensionAttributes : [
            {
                Dimension : status,
                Role : #Category
            }
        ],

        Measures : [
            totalAmount
        ],

        MeasureAttributes : [
            {
                Measure : totalAmount,
                Role : #Axis1
            }
        ]
    }

);

annotate service.Order with @(
    odata.draft.enabled,
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
                Label : 'orderNumber',
                Value : orderNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
                Criticality : criticality,
             
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalAmount',
                Value : totalAmount,
            },
          
            {
                $Type : 'UI.DataField',
                Label : 'billingAddress',
                Value : billingAddress,
            },
            {
                $Type : 'UI.DataField',
                Label : 'shippingAddress',
                Value : shippingAddress,
            },
            {
                $Type : 'UI.DataField',
                Label : 'adharID ',
                Value : adharID ,

            }
        ],
    },
    UI.SelectionFields:[
        status
   
    ],
        UI.PresentationVariant     : {
        MaxItems       : 3,
       
       
        Visualizations : [
            '@UI.Chart#alpChart','@UI.LineItem']
    },
 
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
             {
            $Type: 'UI.ReferenceFacet',
            Label: 'ORDERITEMS',
            Target: 'orderItemsDetails/@UI.LineItem'
        },
    ],
 
 
    UI.HeaderInfo: {
 
 
    Title: {
        $Type: 'UI.DataField',
        Value: orderNumber
    },
 
    Description: {
        $Type: 'UI.DataField',
        Value: status,
     
        }
   },
 
    UI.LineItem : [
        {
            $Type : 'UI.DataFieldWithUrl',
            Label : 'ID',
            Value : ID,
            Url  : 'https://v3.delhivery.com/tracking',
            @HTML5.CssDefaults: {width: '50px'}
        },
        {
            $Type : 'UI.DataField',
            Label : 'orderNumber',
            Value : orderNumber,
            @HTML5.CssDefaults: {width: '150px'}
        },
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
            Criticality : criticality,
            @HTML5.CssDefaults: {width: '150px'}
        },
        {
            $Type : 'UI.DataField',
            Label : 'totalAmount',
            Value : totalAmount,
            @HTML5.CssDefaults: {width: '150px'}
        },
        {
            $Type : 'UI.DataField',
            Label : 'myDate',
            Value :  myDate ,
            @HTML5.CssDefaults: {width: '150px'}
        },
     
        {
            $Type : 'UI.DataField',
            Label : 'adharID',
            Value :  adharID ,
            @HTML5.CssDefaults: {width: '150px'}
        },
        {
        $Type: 'UI.DataFieldForAction',
        Action: 'orderApi.approveOrder',
        Label: 'Approve',
     
        },
        {
        $Type: 'UI.DataFieldForAction',
        Action: 'orderApi.rejectOrder',
        Label: 'Reject',
   
       
        },
        {
        $Type: 'UI.DataFieldForAction',
        Action: 'orderApi.calculateTotal',
        Label: 'Calculate Total',
        Inline: true
       
       }
 
    ],
    Common.SideEffects #AfterActionApprove: {
    TargetEntities: ['Order']
    },
 
Common.SideEffects #AfterActionReject: {
    TargetEntities: ['Order']
    }
   
);
annotate service.Order with actions{
 approveOrder @Common.IsActionCritical: true;
 rejectOrder @Common.IsActionCritical: true
}
 
annotate service.OrderItems with @(
    UI.LineItem: [
        {
    $Type : 'UI.DataFieldWithNavigationPath',
    Label : 'Product',
    Value : product.productName,
    Target : 'product'
},
         {
            $Type: 'UI.DataField',
            Value: ID,
        },
       
        {
            $Type: 'UI.DataField',
            Value: quantity,
        },
        {
            $Type: 'UI.DataField',
            Value: price,
        },
        {     
            $Type: 'UI.DataField',
            Value: product.supportEmail
        },
        {
           $Type: 'UI.DataField',
           Value: product.supportPhone  
        },

        {
          $Type: 'UI.DataField',
          Value: OrderDetails_ID
        },
       {
    $Type: 'UI.DataFieldForAction',
    Action: 'orderApi.EntityContainer/createOrder',
    Label: 'createOrderItems',
    Inline: false
},
    ],
 
     UI.HeaderInfo: {
        TypeName: 'Order Item',
        TypeNamePlural: 'Order Items',
        Title: {
            $Type: 'UI.DataField',
            Value: product.productName
        },
        Description: {
            $Type: 'UI.DataField',
            Value: price
        },
        ImageUrl : product.imageUrl
    },
     UI.FieldGroup #BasicInfo: {
        $Type: 'UI.FieldGroupType',
        Data: [
             {
             $Type: 'UI.DataField',
             Label : 'ID',
             Value: ID
            },
            {
             $Type: 'UI.DataField',
             Label: 'Product',
             Value: product_ID
            },
            {
                $Type: 'UI.DataField',
                 Label : 'Quantity',
                Value: quantity
            },
            {
                $Type: 'UI.DataField',
                Label : 'price',
                Value: price
 
            },
             {     
            $Type: 'UI.DataField',
            Label:'supportEmail',
            Value: product.supportEmail
            },

            {
           $Type: 'UI.DataField',
           Label:'supportPhone  ',
           Value: product.supportPhone  
             },

            

            {
                $Type: 'UI.DataField',
                Label : ' OrderDetails_ID',
                Value:  OrderDetails_ID
 
            }
        ]
    },
    Communication.Contact : {

    fn : product.productName,

    tel : [
        {
            type : [ #work, #preferred ],
            uri : product.supportPhone
        }
    ],

    email : [
        {
            type : [ #work, #preferred ],
            address : product.supportEmail
        }
    ]
},

UI.FieldGroup #ContactCard : {

    $Type : 'UI.FieldGroupType',

    Data : [

        {
            $Type  : 'UI.DataFieldForAnnotation',
            Target : '@Communication.Contact'
        }

    ]
},
 
   
    UI.FieldGroup #ProductRatingInfo : {
        $Type: 'UI.FieldGroupType',
        Data: [
           
            {
            $Type : 'UI.DataFieldForAnnotation',
            Label:'User Rating',
            Target : '@UI.DataPoint#rating'
            }

        ]
    },

    
    UI.FieldGroup #Productdescription: {
        $Type: 'UI.FieldGroupType',
        Data: [
            {

                  
           $Type: 'UI.DataField',
           Label:'description',
           Value: product.description  
             

             }

          

        ]
    },

    UI.DataPoint #rating : {
    Value         : product.rating,
    TargetValue   : 5,
    Visualization : #Rating
},


    
     UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'ORDER ITEMS INFO',
            Target: '@UI.FieldGroup#BasicInfo'
        },
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'ProductRatingInfo',
            Target: '@UI.FieldGroup#ProductRatingInfo'
        },
         {
            $Type: 'UI.ReferenceFacet',
            Label: 'Product description',
            Target: '@UI.FieldGroup#Productdescription'
        },
        {
    $Type : 'UI.ReferenceFacet',
    Label : 'Product Contact',
    Target : '@UI.FieldGroup#ContactCard'
},
       
    ],
   
);
annotate service.OrderItems with {
 
    product @(
        Common.Text: product.productName,
        UI.TextArrangement: #TextOnly,
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'product',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: product_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'productName'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'price'
                }
            ]
        },
 
     
 
    );
 
}
 
annotate service.Order with {
    status @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'StatusVH',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: status,
                    ValueListProperty: 'status'
                }
            ]
        },
        Common.Label : 'Status',
    );
};
annotate service.Order with {
    currency @Common.Label : 'Currency'
};

annotate service.Order with {
    billingAddress @Common.Label : 'billingAddress'
};

annotate service.Order with {
    shippingAddress @Common.Label : 'ShippingAddress'
};

