#
# Module deps
#

express = require 'express'
routes = require './routes'
http = require 'http'

app = express()
auth = express.basicAuth process.env.PIVOTHUB_BASIC_USER, process.env.PIVOTHUB_BASIC_PASS

app.configure ->
  app.set 'port', process.env.PORT || 3000

  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler()

app.get '/issues/:user/:repo', auth, routes.issuesList
app.post '/issues', routes.issueClose

http.createServer(app).listen app.get('port'), ->
  console.log "Express server started on port #{app.get 'port'}"
