@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.TwoPlayersController extends GameApp.GameController
    initialize: ->
      @mode = "two_players"
      super

    getGameModel: ->
      new GameApp.TwoPlayersModel