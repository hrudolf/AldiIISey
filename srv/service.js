const cds = require('@sap/cds');
const SpaceshipService = require('./services/SpaceshipService');
const SpacefarerService = require('./services/SpacefarerService');
const AuthenticationService = require('./services/AuthenticationService');

module.exports = class GalaxyService extends cds.ApplicationService {
    init() {
        const { Spaceships, Spacefarers } = cds.entities('GalaxyService');

        this.on('travel', Spacefarers, async (req) => {
            // Travel to random distance between 1 and 1000 lightyears
            const distance = Math.floor(Math.random() * 1000) + 1;
            
            // Get space dust collected on this trip (between 0 and 10 per person)
            const starDust = Math.floor(Math.random() * 10) + 1;

            const captainId = req.params[0].ID;

            const captain = await SELECT.one.from('Spacefarers').where({ ID: captainId });

            await UPDATE(Spacefarers)
                .set({traveledDistance: {'+=': distance}, starDustCollection: {'+=': starDust}})
                .where({spaceship_ID: captain.spaceship_ID})

            req.reply(`The crew traveled ${distance} and collected ${starDust} per person`);
        });

        this.after('READ', Spaceships, SpaceshipService.fillCapacities);

        this.before('READ', Spacefarers, AuthenticationService.authenticateSpacefarerRead);
        this.on('READ', Spacefarers, SpacefarerService.extendQueryData);
        this.after('READ', Spacefarers, SpacefarerService.fillVirtualFieldsAfterRead);

        this.before('CREATE', Spacefarers, SpacefarerService.initializeFields);
        this.after('CREATE', Spacefarers, SpacefarerService.sendWelcomeEmailOnCreate);

        return super.init();
    }
};
