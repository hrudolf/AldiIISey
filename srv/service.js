const cds = require('@sap/cds');
const SpaceshipService = require('./services/SpaceshipService');
const SpacefarerService = require('./services/SpacefarerService');

module.exports = class GalaxyService extends cds.ApplicationService {
    init() {
        const { Spaceships, Spacefarers } = cds.entities('GalaxyService');

        this.before('READ', Spacefarers, SpacefarerService.READ);

        this.after('READ', Spaceships, SpaceshipService.READ);

        return super.init();
    }
};
