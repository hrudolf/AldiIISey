const cds = require('@sap/cds');
const SpaceshipService = require('./services/SpaceshipService');

module.exports = class GalaxyService extends cds.ApplicationService {
    init() {
        const { Spaceships, Spacefarers } = cds.entities('GalaxyService');

        this.before('READ', Spacefarers, async (req) => {
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
        });

        this.on('READ', 'Spacefarers', async (req, next) => {
            req.query.SELECT.columns = [
                '*',
                {
                    ref: ['spaceship'],
                    expand: [
                        { ref: ['ID'] },
                        { ref: ['name'] },
                        {
                            ref: ['uniform'],
                            expand: [
                                { ref: ['i18n'] }
                            ]
                        }
                    ]
                },
                {
                    ref: ['rank'],
                    expand: [
                        { ref: ['code'] },
                        { ref: ['i18n'] }
                    ]
                },
                {
                    ref: ['originPlanet'],
                    expand: [
                        { ref: ['ID'] },
                        { ref: ['name'] }
                    ]
                }
            ];

            return next();
        });

        this.after('READ', Spacefarers, async (rawData, req) => {

            const data = Array.isArray(rawData) ? rawData : [rawData];

            for (const sf of data) {
                sf.fullName = `${sf.lastName}, ${sf.firstName}`;
                sf.shipAndRank = `${sf.spaceship.name || ' - '} - ${sf.rank.i18n || ' - '}`;
                sf.spaceSuitColor = sf.spaceship?.uniform?.i18n || null;
            }
        });

        this.after('READ', Spaceships, SpaceshipService.AFTER_READ);

        this.after('CREATE', Spacefarers, async (req) => {

            const { email, firstName, lastName } = req;

            console.log(`New spacefarer created: ${firstName} ${lastName} (${email})`);

            if (!email) return; // skip if no email

            // example using nodemailer
            const nodemailer = require('nodemailer');
            const transporter = nodemailer.createTransport({
                service: "gmail",
                auth: {
                    user: process.env.GOOGLE_USER_EMAIL,
                    pass: process.env.GOOGLE_APP_PASSWORD,
                },
            });

            await transporter.sendMail({
                from: '"Galaxy HQ" <no-reply@aldiiisey.com>',
                to: email,
                subject: "Welcome aboard!",
                text: `Hello ${firstName} ${lastName}, welcome to the crew!`
            });
        });

        return super.init();
    }
};
