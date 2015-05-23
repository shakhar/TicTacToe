@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.GameController extends Marionette.Controller
    initialize: ->
      @player = 1
      @validLocation = true
      @gameover = false
      @location = document.location.hash
      @gameModel = @getGameModel()

      @region = @options.region
      @layout = @getLayoutView()

      @listenTo @layout, "show", =>
        @leftPageRegion()
        @rightPageRegion()
        @boardRegion()

      @region.show @layout

    leftPageRegion: ->
      @leftPageView = @getLeftPageView()

      @listenTo @leftPageView, "show", =>
        @setLeftPageEvents()

      @layout.leftPageRegion.show @leftPageView 

    rightPageRegion: ->
      @rightPageView = @getRightPageView()

      @listenTo @rightPageView, "show", =>
        @setTimer?()

      @layout.rightPageRegion.show @rightPageView 

    boardRegion: ->
      @boardView = @getBoardView()

      @listenTo @boardView, "show", =>
        @setBoardEvents()

      @layout.boardRegion.show @boardView

    getLeftPageView: ->
      new GameApp.LeftPageView
        template: HAML["app/assets/scripts/game/templates/#{@mode}/left_page"]

    getRightPageView: ->
      new GameApp.RightPageView
        template: HAML["app/assets/scripts/game/templates/#{@mode}/right_page"]

    getBoardView: ->
      new GameApp.BoardView

    getGameModel: ->
      new GameApp.GameModel

    getLayoutView: ->
      new GameApp.Layout

    move: (parentLocation, location) ->
      @boardView.changeBoard location, @player, false
      if @gameModel.changeBoard parentLocation, location, @player
        @boardView.changeBoard parentLocation, @player, true  
      setTimeout =>
        isWin = @gameModel.checkBoard @player
        isTie = @gameModel.isFull()
        if isWin or isTie
          @boardView.setCanvas()
          lines = @gameModel.getWinningLines()
          @boardView.drawWinningLines lines
          @gameOverMessage isWin
        else
          @player = if @player is 1 then -1 else 1
          image = if @player is 1 then "smallX" else "smallO"
          hideImage = if @player is 1 then "smallO" else "smallX"
          $('#log #' + hideImage).css 'display', 'none'
          $('#log #' + image).css 'display', 'inline'
      , 500

    reset: ->
      @gameModel.reset()
      @boardView.reset()
      @player = 1
      @gameover = false
      @validLocation = true
      $("td.in").removeClass "active"
      $("td.in").removeClass "full"
      $("#log #smallO").css "display", "none"

    gameOverMessage: (isWin) ->
      image = if @player is 1 then "smallX" else "smallO"
      hideImage = if @player is 1 then "smallO" else "smallX"
      @gameover = true
      $("td.in").removeClass "active"
      if isWin
        $("#log #" + hideImage).css "display", "none"
        $("#log #" + image).css "display", "inline"
        $("#log span").text "Wins"
      else
        $("#log #" + hideImage).css "display", "none"
        $("#log #" + image).css "display", "none"
        $("#log #tie").css "display", "inline"
        $("#log span").text "Tie"
    
    setBoardEvents: ->
      $("td.in").click (event) =>
        @handleCellClick event.target

      window.onpopstate = (e) =>
        unless document.location.hash or @gameover or @gameModel.isEmpty()
          unless confirm("Do you really want to quit in the middle of the game?")
            document.location.hash = @location
          else
            @gameover = true
            @socket?.emit "disconnect"
            @socket?.disconnect()
        else unless document.location.hash
          @socket.stopWaiting()
          @socket?.emit "disconnect"
          @socket?.disconnect()
          
    setLeftPageEvents: ->
      $("#new-game-btn").click =>
        @reset()

    handleCellClick: (location) ->
      unless @gameover
        parentLocation = location.parentNode.parentNode.parentNode.parentNode
        if (@validLocation is true or @sameClasses(@validLocation, parentLocation.className)) and @gameModel.checkLocation(parentLocation, location)
          $("td.in").removeClass "active"
          $("." + @validLocation.split(" ").join(".") + " td").addClass "full"  if @validLocation isnt true and @gameModel.isFull(@validLocation)
          @validLocation = @nextLocation location
          if @gameModel.isFull(@validLocation) and not @gameModel.isFull()
            $("td.in").addClass "active"
            $("." + @validLocation.split(" ").join(".") + " td").addClass "full"
            $("td.full").removeClass "active"
            @validLocation = true
          else
            $("." + @validLocation.split(" ").join(".") + " td").addClass "active"
          @boardView.stopAnimationTrigger = true
          @move parentLocation, location
          return true
        else
          @boardView.invalidAnimation @validLocation
      return false

    nextLocation: (location) ->
      locations = location.className.split " "
      parsedLocation = Array()

      for loc in locations
        switch loc
          when "up", "left", "down", "right", "center", "centers"
            parsedLocation.push loc
      parsedLocation.push "out"
      parsedLocation.join " "

    sameClasses: (str1, str2) ->
      array1 = str1.split " "
      array2 = str2.split " "
      for x in array1
        unless x in array2
          return false
      for x in array2
        unless x in array1
          return false
      return true