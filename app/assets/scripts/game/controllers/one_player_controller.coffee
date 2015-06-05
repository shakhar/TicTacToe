@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.OnePlayerController extends GameApp.GameController
    initialize: ->
      @mode = "one_player" 
      super

    move: (parentLocation, location, status) ->  
      @makeMove parentLocation, location 
      @changeValidLocation location
      $("#loaderImage").show() unless status?
      isWin = @gameModel.checkBoard @player
      isTie = @gameModel.isFull()
      if isWin or isTie
        @boardView.setCanvas()
        lines = @gameModel.getWinningLines()
        @boardView.drawWinningLines lines
        @gameOverMessage isWin
      else
        @changePlayer()
        if status? or @gameover
          $("#loaderImage").hide()
        else
          setTimeout =>
            @makeComputerMove parentLocation, location
          , 1000

    reset: ->
      super
      $("#log #smallX").css "display", "inline"
      $("#log span").text "Turn"

    makeMove: (parentLocation, location) ->
      @boardView.changeBoard location, @player, false
      if @gameModel.changeBoard parentLocation, location, @player
        @boardView.changeBoard parentLocation, @player, true

    changeValidLocation: (location) ->
      @validLocation = @nextLocation location
      validLocation = @validLocation 
      $("td.in").removeClass "active"
      $("." + validLocation.split(" ").join(".") + " td").addClass "full"  if @validLocation isnt true and @gameModel.isFull(@validLocation)
      if @gameModel.isFull(@validLocation) and not @gameModel.isFull()
        @showValidationError()
      else
        $("." + @validLocation.split(" ").join(".") + " td").addClass "active"

    showValidationError: ->
      $("td.in").addClass "active"
      $("." + @validLocation.split(" ").join(".") + " td").addClass "full"
      $("td.full").removeClass "active"
      @validLocation = true
            
    changePlayer: ->
      @player = if @player is 1 then -1 else 1
      image = if @player is 1 then "smallX" else "smallO"
      hideImage = if @player is 1 then "smallO" else "smallX"
      $('#log #' + hideImage).css 'display', 'none'
      $('#log #' + image).css 'display', 'inline'

    makeComputerMove: (parentLocation, location) ->
      bestMove = @gameModel.alphaBeta @validLocation
      parentLocation = @gameModel.parseBackLocation bestMove[0], bestMove[1]
      location = @gameModel.parseBackLocation bestMove[2], bestMove[3], parentLocation
      @move parentLocation, location, true

    setBoardEvents: ->
      super
      $("td.in").off "click"
      $("td.in").click (event) =>
        if @player is 1
          parentLocation = event.target.parentNode.parentNode.parentNode.parentNode
          if (@validLocation is true or @sameClasses(@validLocation, parentLocation.className)) and @gameModel.checkLocation(parentLocation, event.target)
            @boardView.stopAnimationTrigger = true
            @move parentLocation, event.target
          else
            @boardView.invalidAnimation @validLocation

    setLeftPageEvents: ->
      $("#level-btn-group").click =>
        @gameModel.difficulty = $("#level-btn-group .active input").attr "id"
        @reset()

      $("#level-select").click =>
        unless @gameModel.level is $("#level-select").val()
          @gameModel.level = $("#level-select").val()
          @reset()

    getGameModel: ->
      new GameApp.OnePlayerModel