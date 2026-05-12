/* global QUnit */
QUnit.config.autostart = false;

sap.ui.require(["northwindv2/test/integration/AllJourneys"
], function () {
	QUnit.start();
});
