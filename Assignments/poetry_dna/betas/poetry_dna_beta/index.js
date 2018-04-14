// index.js
var express = require('express');
var app = express();
var server = require('http').createServer(app);
// var io = require('socket.io')(server);
var static = require('node-static'); // for serving static files (i.e. css)

//which folders to give access to the server

app.use(express.static(__dirname + '/node_modules'));
// app.use("/styles",express.static(__dirname + "/styles"));
app.use("/js",express.static(__dirname + "/js"));
app.use("/libraries",express.static(__dirname + "/libraries"));
app.get('/', function(req, res,next) {
    res.sendFile(__dirname + '/index.html');
});

//define port
server.listen(3000);
