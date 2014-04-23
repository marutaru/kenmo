express = require "express"
app = express()

request = require "request"
cheerio = require "cheerio"
io = require "socket.io"
iconv = require "iconv"

app.set "views", __dirname+"/views"
app.set "view engine","jade"


html = ""
settings =
  "url":"http://fox.2ch.net/poverty/subback.html"
  "encoding":null

request settings,(err,res,body)->
  if !err and res.statusCode is 200
    console.log "success"
    conv = iconv.Iconv "shift_JIS","UTF-8//TRANSLIT//IGNORE"
    html = conv.convert(body).toString()
    $ = cheerio.load html
    console.log $("a").text()
    html = $("a").text()
  else console.log err


app.get "/",(req,res)->
  res.send html

app.get "/kenmo",(req,res)->
  res.render "index",
    html:html

app.listen(3000)

io = io.listen(3001)
io.sockets.on "connection",(socket)->
  console.log "connected"
