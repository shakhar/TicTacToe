@TicTacToe.module "InstructionsApp", (InstructionsApp, App, Backbone, Marionette, $, _) ->

  class InstructionsApp.Controller extends Marionette.Controller

    initialize: ->
      @region = @options.region
      @layout = @getLayoutView()
      @region.show @layout

    getLayoutView: ->
      new InstructionsApp.Layout