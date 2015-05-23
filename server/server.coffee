Hapi = require "hapi"

options =
  views:
    path: "dist/app/views"
    engines: 
      html: require("handlebars")

server = Hapi.createServer "0.0.0.0", 3000, options

server.route
  method: "GET"
  path: "/{path*}"
  handler:
    directory: 
      path: "dist/app"

server.route
  method: "GET"
  path: "/" 
  handler: (request, reply) ->
    reply.view "index"

io = require("socket.io").listen 8080

counter = 1
connections = []
tempSocket = null

io.sockets.on "connection", (socket) ->
  if tempSocket
    connections.push [tempSocket, socket]
    tempSocket.emit "stopWaiting"
    tempSocket.emit "setPlayer", 1
    socket.emit "setPlayer", -1
    tempSocket = null
  else
    tempSocket = socket
    socket.emit "waiting"

  socket.on "addUser", (username) ->
    if username
      socket.username = username
      connectedSocket = findConnectedSocket socket
    else
      socket.username = "Guest#{counter}"
      counter++
      connectedSocket = findConnectedSocket socket

  socket.on "updateOpponent", (parentLocation, location) ->
    connectedSocket = findConnectedSocket socket
    if connectedSocket
      connectedSocket.emit "updateGame", parentLocation, location

  socket.on "disconnect", ->
    if tempSocket is socket
      tempSocket = null
    connectedSocket = removeConnectionSocket socket
    if tempSocket
      connections.push [tempSocket, connectedSocket]
      tempSocket.emit "resetPlayer", 1
      connectedSocket.emit "resetPlayer", -1
      tempSocket = null
    else
      tempSocket = connectedSocket
      tempSocket?.emit "waiting"

findConnectedSocket = (socket) ->
  for connection in connections
    if connection
      if connection[0] is socket
        return connection[1]
      if connection[1] is socket
        return connection[0]
  return null

removeConnectionSocket = (socket) ->
  connectedSocket = null 
  for i in [0..connections.length]
    if connections[i]
      if connections[i][0] is socket
        connectedSocket = connections[i][1]
        delete connections[i]
        break
      if connections[i][1] is socket
        connectedSocket = connections[i][0]
        delete connections[i]
        break
  return connectedSocket

server.start()

console.log "Server starts on port 3000..."