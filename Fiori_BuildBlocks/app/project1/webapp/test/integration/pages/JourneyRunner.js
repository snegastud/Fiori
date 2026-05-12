sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project1/test/integration/pages/userList",
	"project1/test/integration/pages/userObjectPage"
], function (JourneyRunner, userList, userObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project1') + '/test/flp.html#app-preview',
        pages: {
			onTheuserList: userList,
			onTheuserObjectPage: userObjectPage
        },
        async: true
    });

    return runner;
});

