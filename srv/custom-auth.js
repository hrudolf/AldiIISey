const cds = require('@sap/cds');

module.exports = async function (req, res, next) {
  const header = req.headers.authorization;
  if (!header) {
    res.status(401).set('WWW-Authenticate','Basic realm="CAP"').end();
    return;
  }
  const [type, token] = header.split(' ');
  if (type !== 'Basic') return res.status(401).end();
  const [user, pass] = Buffer.from(token, 'base64').toString().split(':');

  // check credentials
  if (user === 'admin' && pass === 'admin') {
    cds.context.user = new cds.User({ id: user, roles: ['Admin', 'authenticated-user'] });
    next();
  } else if (user) {
        const db = await cds.connect.to('db');
    
        const existing = await db.run(
            SELECT.one.from('Spacefarers').where({ email: user })
        );

        if (existing) {
            const roles = ['authenticated-user'];
            if (existing.rank_code) {
                roles.push(`rank-${existing.rank_code.toLowerCase()}`);
            }
            cds.context.user = new cds.User({ id: user, roles, attr: { spacefarer_ID: existing.ID } });
            next();
        } else {
            res.status(401).end();
        }

  } else {
    res.status(401).end();
  }
};