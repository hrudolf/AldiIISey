const cds = require('@sap/cds');
const SpaceshipService = require('./services/SpaceshipService');

module.exports = cds.service.impl(async function () {
    this.on('READ', 'Spaceships', SpaceshipService.READ);
});
