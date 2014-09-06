@TicTacToe.module "InstructionsApp", (InstructionsApp, App, Backbone, Marionette, $, _) ->

  class InstructionsApp.Router extends Marionette.AppRouter
    appRoutes:
      "Instructions": "start" 

  API =
    start: ->
      new InstructionsApp.Controller
        region: App.mainRegion

  App.addInitializer ->
    new InstructionsApp.Router
      controller: API
 