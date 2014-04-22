express = require "express"
app = express()

request = require "request"
$ = require "cheerio"
io = require "socket.io"

url = "http://fox.2ch.net/poverty/"
html = ""

settings =
  "url":"http://fox.2ch.net/poverty/"
  "encoding":"binary"

request settings,(err,res,body)->
  if !err and res.statusCode is 200
    console.log "success"
    console.log body
    html = body
  else console.log err


app.get("/",(req,res)->
  res.send html
)

app.listen(3000)

io = io.listen(3001)
io.sockets.on "connection",(socket)->
  console.log "connected"
