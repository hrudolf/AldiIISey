const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: process.env.GOOGLE_USER_EMAIL,
        pass: process.env.GOOGLE_APP_PASSWORD,
    },
});

module.exports = { emailService: transporter };