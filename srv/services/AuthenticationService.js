const cds = require('@sap/cds');

async function authenticateSpacefarerRead(req) {
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
module.exports = { authenticateSpacefarerRead };