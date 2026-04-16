const cds = require('@sap/cds');
const handlebars = require('handlebars');
const fs = require('fs');
const path = require('path');

const SUBJECT_I18N = 'welcome_email_subject';
const HEADER_I18N = 'welcome_email_header';
const GREETING_I18N = 'welcome_email_greeting';
const MESSAGE_I18N = 'welcome_email_message';
const GOODBYE_I18N = 'welcome_email_goodbye';
const SENDER = '"Galaxy HQ" <no-reply@aldiiisey.com>';

function createMailHtml(name, locale, spaceShipName) {
    const header = cds.i18n.labels.at(HEADER_I18N, locale)
    const greeting = cds.i18n.labels.at(GREETING_I18N, locale, [name]);
    const message = cds.i18n.labels.at(MESSAGE_I18N, locale, [spaceShipName]);
    const goodbye = cds.i18n.labels.at(GOODBYE_I18N, locale);

    const templatePath = path.join(process.env.TEMPLATE_BASE_PATH, 'welcome_mail.html');
    const source = fs.readFileSync(templatePath, 'utf-8');
    const template = handlebars.compile(source);

    return template({
        header,
        greeting,
        message,
        goodbye
    });
}

module.exports = {
    constants: {
        SUBJECT_I18N,
        HEADER_I18N,
        GREETING_I18N,
        MESSAGE_I18N,
        GOODBYE_I18N,
        SENDER
    },
    createMailHtml
}