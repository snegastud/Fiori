sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("nw.nwproductdata.controller.View1", {
        // when you  run that code it will automatically invoke that funtion
        // lifecycle function
        /*onInit() {

           // sap.m.MessageToast.show("welcome to ui5 demo kit")
           // below code is call the odata northwind service
           var omodel=this.getOwnerComponent().getModel();
           debugger;
           omodel.read('/Products',{
            success:(odata)=>{

                 console.log("Response:", odata);
                 debugger;

                 var jmodel=new sap.ui.model.json.JSONModel();
                 jmodel.setData(odata.results);



            },
            error:(err)=>{
                 debugger;

            }
            
           })
        },*/
    onInit() {

    var oModel = this.getOwnerComponent().getModel();

    oModel.metadataLoaded().then(() => {

        oModel.read("/Products", {
            success: (oData) => {

                console.log("Response",oData);
                 console.log("Response[0]",oData.results[0]);
                // sap.ui.model.json.jsonmodel used to show all the data in a form of table 
                var oJsonModel = new sap.ui.model.json.JSONModel();
                oJsonModel.setData(oData.results);

                this.getView().setModel(oJsonModel, "products");
            },
            error: (oError) => {
                console.error(oError);
            }
        });

    });
},
        onAfterRendering:function(){

        },
        onBeforeRendering:function(){

        },
        onExit:function(){

        },
        _greetme:function(){
            sap.m.MessageToast.show("user define function") 
        },
        _toView2:function(){
            this.oRouter=this.getOwnerComponent().getRouter().navTo("RouteView2");
        }
    });
});