@TicTacToe.module "GameApp", (GameApp, App, Backbone, Marionette, $, _) ->

  class GameApp.Router extends Marionette.AppRouter
    appRoutes:
      "OnePlayer": "onePlayer"
      "TwoPlayers": "twoPlayers"
      "TwoPlayersOnline": "twoPlayersOnline"   

  API =
    onePlayer: ->
      new GameApp.OnePlayerController
        region: App.mainRegion
    twoPlayers: ->
      new GameApp.TwoPlayersController
        region: App.mainRegion
    twoPlayersOnline: ->
      new GameApp.TwoPlayersOnlineController
        region: App.mainRegion

  App.addInitializer ->
    new GameApp.Router
      controller: API