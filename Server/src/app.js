const express = require('express')
const https = require('https')
const path = require('path')
const fs = require('fs')
const { execFileSync } = require('child_process')
const settings = require('./info.json')
const app = express()

execFileSync(__dirname + "/cert/cmd.bat")
console.log('Certificat generated, Server starting');

app.route("/").get((req, res) => {
    res.sendFile(path.join(__dirname, "public/home/home.html"))
})

https.createServer({
    key: fs.readFileSync(__dirname + '/cert/server-key.pem'),
    cert: fs.readFileSync(__dirname + '/cert/server-cert.pem'),
    passphrase: fs.readFileSync(__dirname + '/cert/passwd.cnf').toString().slice(0, 73)
}, app)
.listen(settings.ports.https, settings.ips.server, () => {
    console.clear()
    console.log(`Server is running on https://${settings.ips.server}:${settings.ports.https}`)
})