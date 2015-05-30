@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.TwoPlayersOnlineController extends GameApp.GameController
    initialize: ->
      @autoClicked = false
      @playerNum = 0
      @mode = "two_players_online"
      @socket = new Connect().start this
      super

    setTimer: ->
      @timer = new FlipClock $('#timer'), 61,
        clockFace: 'Counter'
        autoStart: true
        countdown: true

      setInterval =>
        unless @timer.getTime().time
          moves = @gameModel.getMoves @validLocation
          index = Math.floor Math.random() * moves.length
          move = moves[index]
          parentLocation = @gameModel.parseBackLocation move[0], move[1]
          location = @gameModel.parseBackLocation move[2], move[3], parentLocation
          cell = ".#{parentLocation.className.split(" ").join(".")} .#{location.className.split(" ").join(".")}"
          $(cell).click()
      , 1000
    
    reset: ->
      super
      @playerNum = 0
      @autoClicked = false
      $("#loaderImage").hide()
      @timer.stop()
      $("#timer").hide()
      $("#player").hide()
      $("#log img").hide()

    gameOverMessage: (isWin) ->
      super isWin
      $("#loaderImage").hide()
      @timer.stop()
      $("#timer").hide()
      $("#player").hide()

    handleCellClick: (location) ->
      if @playerNum is @player or @autoClicked
        if super location, this
          parentLocation = location.parentNode.parentNode.parentNode.parentNode
          @socket.emit "updateOpponent", parentLocation.className, location.className if @player is @playerNum
          if @autoClicked
            $("#loaderImage").hide()
            @timer.stop()
            $("#timer").show()
            @timer.setTime 61
            @timer.start() 
          else 
            $("#loaderImage").show()
            $("#timer").show()
            @timer.setTime 61
            @timer.start()
      @autoClicked = false if @autoClicked

    getGameModel: ->
      new GameApp.TwoPlayersOnlineModel    