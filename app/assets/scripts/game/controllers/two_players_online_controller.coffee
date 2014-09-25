@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.TwoPlayersOnlineController extends GameApp.GameController
    initialize: ->
      @autoClicked = false
      @playerNum = 0
      @mode = "two_players_online"
      @socket = new Chat().start this
      super

    setTimer: ->
      @timer = new Timer()
      
    reset: ->
      super
      @playerNum = 0
      @autoClicked = false
      stopLoading()
      @timer.stopTimer()
      $("#timer").hide()
      $("#player").hide()

    gameOverMessage: (isWin) ->
      super isWin
      stopLoading()
      @timer.stopTimer()
      $("#timer").hide()
      $("#player").hide()

    setBoardEvents: ->
      super
      $(window).on "time_out", =>
        moves = @gameModel.getMoves @validLocation
        index = Math.floor Math.random() * moves.length
        move = moves[index]
        parentLocation = @gameModel.parseBackLocation move[0], move[1]
        location = @gameModel.parseBackLocation move[2], move[3], parentLocation
        cell = ".#{parentLocation.className.split(" ").join(".")} .#{location.className.split(" ").join(".")}"
        $(cell).click()

    handleCellClick: (location) ->
      if @playerNum is @player or @autoClicked
        if super location, this
          parentLocation = location.parentNode.parentNode.parentNode.parentNode
          @socket.emit "updateOpponent", parentLocation.className, location.className if @player is @playerNum
          if @autoClicked
            stopLoading()
            @timer.stopTimer()
            @timer.startTimer() 
          else 
            startLoading()
            @timer.startTimer()
      @autoClicked = false if @autoClicked

    getGameModel: ->
      new GameApp.TwoPlayersOnlineModel    