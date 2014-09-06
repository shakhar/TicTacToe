@TicTacToe.module "HomeApp", (HomeApp, App, Backbone, Marionette, $, _) ->

  class HomeApp.Controller extends Marionette.Controller

    initialize: ->
      @region = @options.region
      @layout = @getLayoutView()
      @region.show @layout

    getLayoutView: ->
      new HomeApp.Layout