const cds = require('@sap/cds');
const SpaceshipService = require('./services/SpaceshipService');
const SpacefarerService = require('./services/SpacefarerService');
const AuthenticationService = require('./services/AuthenticationService');

module.exports = class GalaxyService extends cds.ApplicationService {
    init() {
        const { Spaceships, Spacefarers } = cds.entities('GalaxyService');

        this.after('READ', Spaceships, SpaceshipService.fillCapacities);

        this.before('READ', Spacefarers, AuthenticationService.authenticateSpacefarerRead);
        this.on('READ', Spacefarers, SpacefarerService.extendQueryData);
        this.after('READ', Spacefarers, SpacefarerService.fillVirtualFieldsAfterRead);

        this.before('CREATE', Spacefarers, SpacefarerService.initializeFields);
        this.after('CREATE', Spacefarers, SpacefarerService.sendWelcomeEmailOnCreate);

        return super.init();
    }
};
