# server entry point

port = process.env.PORT or 3030

express = require 'express'
bodyParser = require 'body-parser'

api = require './api-server'
Router = require './router'
routes = require './routes'

app = express()
router = new Router routes

app.use express.static 'www'
app.use router.middleware()

api app

app.listen port

console.log "Example app running on localhost:#{port}"
