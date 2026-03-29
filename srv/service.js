const cds = require('@sap/cds');
const SpaceshipService = require('./services/SpaceshipService');

module.exports = class GalaxyService extends cds.ApplicationService { init() {
    const { Spaceships } = cds.entities('GalaxyService');

    this.after('READ', Spaceships, SpaceshipService.READ);

    return super.init();
}};
