controller = new Controller()
name = localStorage["name"]
socket = io.connect "192.168.1.103:8080"

socket.on "connect", ->
  socket.emit "addUser", name
  $("#connecting").hide()
  $("#container").show()

socket.on "updateChat", (username, data, color, connected, connectedFirst) ->
  if username is null
    $("#conversation").append "<span class='#{color}'>#{data}</span><br>"
    timer.startTimer() if connected is true
    startLoading() if connectedFirst is true
    controller.reset() if connected is false
  else
    $("#conversation").append "<span class='blue'><b class='#{color}'>#{username}:</b> #{data}</span><br>"
  $("#conversation")[0].scrollTop = $("#conversation")[0].scrollHeight;
$("#data-send").click ->
  message = $("#data").val()
  $("#data").val ""
  socket.emit "sendChat", message
  $("#data").focus()

socket.on "updateGame", (parentLocation, location) ->
  parentLocation = ".#{ parentLocation.split(" ").join(".") }"
  tempArr = location.split " "
  location = $("#{parentLocation} .#{ tempArr.slice(0, tempArr.length-1).join(".") }")
  controller.autoClicked = true
  location.focus().click()

socket.on "setPlayer", (num) ->
  controller.playerNum = num
  imageSrc = if num is 1 then "assets/images/smallX.png" else "assets/images/smallO.png"
  $("#player").html "<span>You are <img src='#{imageSrc}'></span>"
  $("#player").show()

socket.on "connect_failed", ->
  console.log "connect_failed"
  $("#connecting").hide()
  $("#container").hide()
  $("#connect-failed-msg").show()

$("#data").keypress (e) ->
  if e.which is 13
    $(this).blur()
    $("#data-send").focus().click()

$("a").click ->
  socket.disconnect() 
