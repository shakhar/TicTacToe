@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.TwoPlayersController extends GameApp.GameController
    initialize: ->
      @mode = "two_players"
      super

    reset: ->
      super
      $("#log #smallX").css "display", "inline"
      $("#log span").text "Turn"

    getGameModel: ->
      new GameApp.TwoPlayersModel