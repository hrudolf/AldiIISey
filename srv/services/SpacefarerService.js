const nodemailer = require('nodemailer');
const cds = require('@sap/cds');
const handlebars = require('handlebars');
const fs = require('fs');
const path = require('path');

async function travel(req) {
    // Travel to random distance between 1 and 20000 lightyears
    const distance = Math.floor(Math.random() * 20000) + 1;

    // Get space dust collected on this trip (between 0 and 10 per person)
    const starDust = Math.floor(Math.random() * 10) + 1;

    const captainId = req.params[0].ID;

    const captain = await SELECT.one.from('Spacefarers').where({ ID: captainId });

    await UPDATE('Spacefarers')
        .set({ traveledDistance: { '+=': distance }, starDustCollection: { '+=': starDust } })
        .where({ spaceship_ID: captain.spaceship_ID })

    req.notify('TRAVEL_NOTIFICATION', [distance, starDust]);
}

async function collectStarDust(req) {
    console.log("Collect stardust, req is ", req.params)
    const spacefarerID = req.params[0].ID;
    const { starDustCollection, firstName, lastName } = 
        await SELECT.one
            .columns('starDustCollection', 'firstName', 'lastName')
            .from('Spacefarers').where({ ID: spacefarerID });

    await UPDATE('Spacefarers')
        .set({ starDustCollection: 0 })
        .where({ ID: spacefarerID });

    req.notify('STARDUST_COLLECTED', [starDustCollection, lastName, firstName])
}

async function userForEmail(email) {
    const db = await cds.connect.to('db');

    const existing = await db.run(
        SELECT.one.from('Spacefarers').where({ email: email })
    );

    return existing;
}

async function validateOnUpdate(req) {
    const user = await userForEmail(req.data.email);

    if (user) {
        if (req.data.ID !== user.ID) {
            return req.error({ status: 400, message: "EMAIL_ALREADY_EXISTS" });
        }
    }
}

async function initializeFields(req) {
    const existingUser = await userForEmail(req.data.email);

    if (!!existingUser) {
        return req.error({ status: 400, message: "EMAIL_ALREADY_EXISTS" });
    }

    if (!req.data.traveledDistance) {
        req.data.traveledDistance = 0;
    }
    if (!req.data.starDustCollection) {
        req.data.starDustCollection = 0;
    }
    if (!req.data.lang_code) {
        req.data.lang_code = "en"
    }
}

async function sendWelcomeEmailOnCreate(req) {

    const { email, firstName, lastName, lang_code, spaceship_ID } = req;

    const name = firstName + " " + lastName;
    const locale = lang_code ?? "en";

    const { name: spaceShipName } = await SELECT.one.columns("name").from('Spaceships').where({ ID: spaceship_ID });

    const subject = cds.i18n.labels.at('welcome_email_subject', locale)
    const header = cds.i18n.labels.at('welcome_email_header', locale)
    const greeting = cds.i18n.labels.at('welcome_email_greeting', locale, [name]);
    const message = cds.i18n.labels.at('welcome_email_message', locale, [spaceShipName]);
    const goodbye = cds.i18n.labels.at('welcome_email_goodbye', locale);

    if (!email) return; // skip if no email address

    const sendMail = process.env.SEND_MAIL === "true";

    if (!sendMail) {
        console.log("E-mail sending disabled in .env")
        return;
    }

    // 2. Load and Compile the HTML Template
    const templatePath = path.join(process.env.TEMPLATE_BASE_PATH, 'welcome_mail.html');
    const source = fs.readFileSync(templatePath, 'utf-8');
    const template = handlebars.compile(source);

    // 3. Generate HTML with localized data
    const htmlToSend = template({
        header,
        greeting,
        message,
        goodbye
    });

    // example using nodemailer
    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: process.env.GOOGLE_USER_EMAIL,
            pass: process.env.GOOGLE_APP_PASSWORD,
        },
    });

    // TODO: Create nice email template :), i18n as well
    await transporter.sendMail({
        from: '"Galaxy HQ" <no-reply@aldiiisey.com>',
        to: email,
        subject: subject,
        html: htmlToSend
    });
};

async function fillVirtualFieldsAfterRead(rawData, req) {

    const data = Array.isArray(rawData) ? rawData : [rawData];

    for (const sf of data) {
        sf.fullName = `${sf.lastName}, ${sf.firstName}`;
        sf.shipAndRank = `${sf.spaceship.name || ' - '} - ${sf.rank.i18n || ' - '}`;
        sf.spaceSuitColor = sf.spaceship?.uniform?.i18n || null;

        const isTravelerCaptain = sf.rank.code === 'captain';
        const isUserCaptainOrAdmin = ('rank-captain' in req.user.roles || 'Admin' in req.user.roles)
        sf.hideTravelAction = !(isTravelerCaptain && isUserCaptainOrAdmin);
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
            ref: ['lang'],
            expand: [
                { ref: ['code'] },
                { ref: ['name'] }
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

module.exports = {
    sendWelcomeEmailOnCreate,
    fillVirtualFieldsAfterRead,
    extendQueryData,
    initializeFields,
    validateOnUpdate,
    travel,
    collectStarDust
};