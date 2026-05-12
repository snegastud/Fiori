sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project3/test/integration/pages/OrderList",
	"project3/test/integration/pages/OrderObjectPage",
	"project3/test/integration/pages/OrderItemsObjectPage"
], function (JourneyRunner, OrderList, OrderObjectPage, OrderItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project3') + '/test/flp.html#app-preview',
        pages: {
			onTheOrderList: OrderList,
			onTheOrderObjectPage: OrderObjectPage,
			onTheOrderItemsObjectPage: OrderItemsObjectPage
        },
        async: true
    });

    return runner;
});

