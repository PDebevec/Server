const tmi = require('tmi.js')
const client = new tmi.Client( require('../info.json') )
const express = require('express')
const settings = require('./info.json')
const app = express()
client.connect()

app.listen(settings.ports.http, settings.ips.twitch, () => {
    console.log('Server running on 10.10.10.2:80');
})