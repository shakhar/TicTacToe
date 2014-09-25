@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.OnePlayerController extends GameApp.GameController
    initialize: ->
      @mode = "one_player" 
      super

    move: (parentLocation, location, status) ->  
      @makeMove parentLocation, location 
      # @printBoard @gameModel.board
      @changeValidLocation location
      
      setTimeout =>
        isWin = @gameModel.checkBoard @player
        isTie = @gameModel.isFull()
        if isWin or isTie
          lines = @gameModel.getWinningLines()
          @boardView.drawWinningLines lines
          @gameOverMessage isWin
        else
          @changePlayer()
        setTimeout =>
          unless status? or @gameover
            startLoading()
            @makeComputerMove parentLocation, location
          else
            stopLoading()
        , 100
      , 500

    makeMove: (parentLocation, location) ->
      @boardView.changeBoard location, @player, false
      if @gameModel.changeBoard parentLocation, location, @player
        @boardView.changeBoard parentLocation, @player, true

    changeValidLocation: (location) ->
      $("td.in").removeClass "active"
      $("." + @validLocation.split(" ").join(".") + " td").addClass "full"  if @validLocation isnt true and @gameModel.isFull(@validLocation)
      @validLocation = @nextLocation location
      if @gameModel.isFull(@validLocation) and not @gameModel.isFull()
        @showValidationError()
      else
        $("." + @validLocation.split(" ").join(".") + " td").addClass "active"

    showValidationError: ->
      $("td.in").addClass "active"
      $("." + @validLocation.split(" ").join(".") + " td").addClass "full"
      $("td.full").removeClass "active"
      @validLocation = true
      $("#Full-Modal").modal "show" unless localStorage["disableFullModal"]
      
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

    # printBoard: (board) ->
    #   str = ""
    #   for i in [0..2]
    #     for j in [0..2]
    #       str += "\n"
    #       for k in [0..2]
    #         str += " "
    #         for l in [0..2]
    #           val = board.table[i][k].table[j][l].val
    #           str += "X" if val is 1
    #           str += "Y" if val is -1
    #           str += "-" if val is 0
    #   console.log str

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
            $("#Invalid-Modal").modal "show"  if @gameModel.checkLocation(parentLocation, location) and not localStorage["disableInvalidModal"]

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