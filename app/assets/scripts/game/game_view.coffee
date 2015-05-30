@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.Layout extends Marionette.Layout
    template: HAML["app/assets/scripts/game/templates/game_layout"]

    regions:
      leftPageRegion: "#left-page-region"
      rightPageRegion: "#right-page-region"
      boardRegion:    "#board-region"
  
  class GameApp.LeftPageView extends Marionette.ItemView
  class GameApp.RightPageView extends Marionette.ItemView
  class GameApp.BoardView extends Marionette.ItemView
    template: HAML["app/assets/scripts/game/templates/board"]	
   
    initalize: ->
      @stopAnimationTrigger = false

    onShow: ->
      minSize = Math.min $(window).height(), $(window).width()
      $("td.out").width minSize / 4
      $("td.out").height minSize / 4
      $("td.in").width minSize / 15
      $("td.in").height minSize / 15
      $("table.main").css "margin-top", "#{($(window).height() - $("table.main").height()) / 2}px"

      properation = $(window).height() / $(window).width()
      if properation > 0.55 and properation < 1.3
        $("#left-page-region").hide()
        $("#right-page-region").hide()
      else
        $("#left-page-region").show()
        $("#right-page-region").show()
        if properation >= 1.3
          $("#left-page-region").addClass "top"
          $("#right-page-region").addClass "bottom"
        else
          $("#left-page-region").removeClass "top"
          $("#right-page-region").removeClass "bottom"
          
      $("#loaderImage").css "top", $(window).height()/2 - $("#loaderImage").height()/2
      $("#loaderImage").css "left", $(window).width()/2 - $("#loaderImage").width()/2

      $("#timer").css "width", "#{$(".flip").outerWidth()*14/3}px"

    reset: ->
      $("td").css "background", "none"
      $(".in img").remove()
      $("table div").remove()
      $("canvas").css "z-index", -1
      @context.clearRect 0, 0, 590, 590 if @context?

    changeBoard: (location, player, isBigBoard) ->
      if isBigBoard
        image = if player is 1 then "assets/images/bigX.png" else "assets/images/bigO.png"
        $(location).css "background", "url(" + image + ") round"
      else
        image = if player is 1 then "assets/images/smallX.png" else "assets/images/smallO.png"
        $(location).html "<img class='small-img' src='" + image + "'>"

    invalidAnimation: (location) ->
      @stopAnimationTrigger = false
      that = @
      animation = (num) ->
        $("." + location.split(" ").join(".") + " td").removeClass "active"
        clearTimeout timeout
        timeout = setTimeout ->
          if that.stopAnimationTrigger
            $("." + location.split(" ").join(".") + " td").removeClass "active"
            return
          $("." + location.split(" ").join(".") + " td").addClass "active"
          num--
          if num > 0
            clearTimeout timeout
            timeout = setTimeout ->
              animation num
            , 300
        , 300
      timeout = setTimeout ->
        animation(3)
      , 300

    drawWinningLines: (lines) ->
      for line in lines
        start = line.start
        end = line.end
        @drawLine start, end

    setCanvas: ->
      $("canvas").attr "width", $("table.main").width() + 10
      $("canvas").attr "height", $("table.main").height() + 10
      offset = $("table.main").offset()
      $("canvas").offset 
        top: offset.top - 10 
        left: offset.left - 10
      $("canvas").css "z-index", 1

    drawLine: (start, end) ->
      start.x -= $("canvas").position().left
      start.y -= $("canvas").position().top
      end.x -= $("canvas").position().left
      end.y -= $("canvas").position().top
      @context = $("canvas")[0].getContext "2d"
      @context.beginPath()
      @context.moveTo start.x, start.y
      @context.lineTo end.x, end.y
      @context.lineWidth = 15
      @context.lineCap = "round"
      @context.strokeStyle = "rgba(0, 255, 140, 0.5)"
      @context.stroke()