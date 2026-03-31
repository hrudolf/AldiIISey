const cds = require('@sap/cds');
const SpaceshipService = require('./services/SpaceshipService');
const SpacefarerService = require('./services/SpacefarerService');
const AuthenticationService = require('./services/AuthenticationService');

module.exports = class GalaxyService extends cds.ApplicationService {
    init() {
        const { Spaceships, Spacefarers } = cds.entities('GalaxyService');

        this.on('travel', Spacefarers, SpacefarerService.travel);
        this.on('collectStarDust', Spacefarers, SpacefarerService.collectStarDust);

        this.after('READ', Spaceships, SpaceshipService.fillCapacities);
        this.on('READ', 'UserContext', (req) => {
            return {
                ID: req.user.id,
                hideCollectAction: !('rank-captain' in req.user.roles || 'Admin' in req.user.roles)
            };
        });

        this.before('READ', Spacefarers, AuthenticationService.authenticateSpacefarerRead);
        this.on('READ', Spacefarers, SpacefarerService.extendQueryData);
        this.after('READ', Spacefarers, SpacefarerService.fillVirtualFieldsAfterRead);

        this.before('CREATE', Spacefarers, SpacefarerService.initializeFields);
        this.before('UPDATE', Spacefarers, SpacefarerService.validateOnUpdate);
        this.after('CREATE', Spacefarers, SpacefarerService.sendWelcomeEmailOnCreate);

        return super.init();
    }
};
