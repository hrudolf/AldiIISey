const cds = require('@sap/cds');

async function SpacefarerReadRestriction(req) {
    if ('Admin' in req.user.roles) {
        return;
    }

    const db = await cds.connect.to('db');

    const spaceFarerId = req.user.attr?.spacefarer_ID;

    if (spaceFarerId) {
        const spaceFarer = await db.run(
            SELECT.one.from('Spacefarers').where({ ID: spaceFarerId })
        );

        if (spaceFarer) {
            req.query.where({ spaceship_ID: spaceFarer.spaceship_ID });
            return;
        }
    }

    return req.error('SPACEFARER_NOT_FOUND');
}

async function SpacefarerOnRead(req, next) {
    const tx = cds.tx(req);

    // if reading a single entity, req.data has the key
    const filter = req.data ? { ID: req.data.ID } : undefined;
    const spacefarers = await tx.run(SELECT.from("Spacefarers").where(filter));

    const spaceshipIds = spacefarers.map(s => s.spaceship_ID);
    const spaceships = await tx.run(SELECT.from("Spaceships").where({ ID: spaceshipIds }));
    const spaceshipMap = Object.fromEntries(spaceships.map(s => [s.ID, s]));

    for (const sf of spacefarers) {
        sf.fullName = `${sf.lastName}, ${sf.firstName}`;
        sf.shipAndRank = `${spaceshipMap[sf.spaceship_ID]?.name || ' - '} - ${sf.rank_code || ' - '}`;
        sf.spaceSuitColor = spaceshipMap[sf.spaceship_ID]?.uniform || null;
    }

    return next();
};

module.exports = {
    BEFORE_READ: SpacefarerReadRestriction,
    ON_READ: SpacefarerOnRead
};