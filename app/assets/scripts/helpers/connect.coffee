class window.Connect

  start: (controller) ->
    name = localStorage["name"]
    interval = undefined
    socket = io.connect "localhost:8080", 
      'force new connection': true

    socket.on "connect", ->
      socket.emit "addUser", name

    socket.on "updateGame", (parentLocation, location) ->
      parentLocation = ".#{ parentLocation.split(" ").join(".") }"
      tempArr = location.split " "
      index = tempArr.indexOf "active"
      tempArr.splice index, 1 if index isnt -1
      location = $("#{parentLocation} .#{ tempArr.join(".") }")
      controller.autoClicked = true
      location.focus().click()

    socket.on "waiting", ->
      controller.reset()
      i = 0
      interval = setInterval ->
          i = ++i % 4
          $("#log span").text "Waiting for opponent#{Array(i+1).join(".")}"
          $("#log").css "text-align", "left"
      , 500

    socket.on "stopWaiting", ->
      clearInterval interval
      $("#log").css "text-align", "center"

    socket.on "setPlayer", (num) ->
      $("#smallX").show()
      $("#log span").text "Turn"
      controller.playerNum = num
      $("#loaderImage").show() if num is -1
      controller.timer.startTimer()

    socket.on "resetPlayer", (num) ->
      socket.stopWaiting()
      controller.reset()
      controller.playerNum = num
      $("#smallX").show()
      $("#log span").text "Turn"
      $("#loaderImage").show() if num is -1
      controller.timer.startTimer()

    socket.on "connect_failed", ->
      console.log "connect_failed"

    socket.stopWaiting = ->  
      clearInterval interval
      $("#log").css "text-align", "center"
    
    socket
