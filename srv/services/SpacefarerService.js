const nodemailer = require('nodemailer');
const cds = require('@sap/cds');
const handlebars = require('handlebars');
const fs = require('fs');
const path = require('path');

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
        return req.error({status: 400, message: "EMAIL_ALREADY_EXISTS"});
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

    const {name: spaceShipName} = await SELECT.one.columns("name").from('Spaceships').where({ID: spaceship_ID});

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
    const templatePath = path.join(process.env.BASE_PATH, 'welcome_mail.html');
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

module.exports = { sendWelcomeEmailOnCreate, fillVirtualFieldsAfterRead, extendQueryData, initializeFields };