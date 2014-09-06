@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.TwoPlayersOnlineController extends GameApp.GameController
    initialize: ->
      @autoClicked = false
      @playerNum = 0
      @timer = new Timer()
      @mode = "two_players_online"
      super

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

    setEvents: ->
      super
      $(window).on "time_out", =>
        moves = @model.getMoves @validLocation
        index = Math.floor Math.random() * moves.length
        move = moves[index]
        parentLocation = @model.parseBackLocation move[0], move[1]
        location = @model.parseBackLocation move[2], move[3], parentLocation
        cell = ".#{parentLocation.className.split(" ").join(".")} .#{location.className.split(" ").join(".")}"
        $(cell).click()

    handleCellClick: (location) ->
      if @playerNum is @player or @autoClicked
        if super location, that
          socket.emit "updateOpponent", parentLocation.className, location.className if @player is @playerNum
          if @autoClicked
            stopLoading()
            @timer.stopTimer()
            @timer.startTimer() 
          else 
            startLoading()
            @timer.startTimer()
      @autoClicked = false if @autoClicked