sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("northwindv2.controller.View1", {
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
        }

    });
});