const nodemailer = require('nodemailer');
const cds = require('@sap/cds');

async function validateUniqueEmail(email) {
    const db = await cds.connect.to('db');

    const existing = await db.run(
        SELECT.one.from('Spacefarers').where({ email: email })
    );

    return !existing;
}

async function initializeFields(req) {
    const isEmailUnique = await validateUniqueEmail(req.data.email);

    if (!isEmailUnique) {
        return req.error("EMAIL_ALREADY_EXISTS", 400);
    }


    if (!req.data.traveledDistance) {
        req.data.traveledDistance = 0;
    }
    if (!req.data.starDustCollection) {
        req.data.starDustCollection = 0;
    }
}

async function sendWelcomeEmailOnCreate(req) {

    const { email, firstName, lastName } = req;

    console.log(`New spacefarer created: ${firstName} ${lastName} (${email})`);

    if (!email) return; // skip if no email

    const sendMail = process.env.SEND_MAIL === "true";

    if (!sendMail) {
        console.log("E-mail sending disabled in .env")
        return;
    }

    // example using nodemailer
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
};

async function fillVirtualFieldsAfterRead(rawData, req) {

    const data = Array.isArray(rawData) ? rawData : [rawData];

    for (const sf of data) {
        sf.fullName = `${sf.lastName}, ${sf.firstName}`;
        sf.shipAndRank = `${sf.spaceship.name || ' - '} - ${sf.rank.i18n || ' - '}`;
        sf.spaceSuitColor = sf.spaceship?.uniform?.i18n || null;
    }
}

async function extendQueryData(req, next) {
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
}

module.exports = { sendWelcomeEmailOnCreate, fillVirtualFieldsAfterRead, extendQueryData, initializeFields };