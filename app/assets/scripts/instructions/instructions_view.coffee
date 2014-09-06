@TicTacToe.module "InstructionsApp", (InstructionsApp, App, Backbone, Marionette, $, _) ->

  class InstructionsApp.Layout extends Marionette.ItemView
    template: HAML["app/assets/scripts/instructions/templates/instructions_layout"]