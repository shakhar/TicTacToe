@TicTacToe.module "HomeApp", (HomeApp, App, Backbone, Marionette, $, _) ->

  class HomeApp.Router extends Marionette.AppRouter
    appRoutes:
      "": "start" 

  API =
    start: ->
      new HomeApp.Controller
        region: App.mainRegion

  App.addInitializer ->
    new HomeApp.Router
      controller: API
 