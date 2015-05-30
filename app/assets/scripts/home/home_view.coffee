@TicTacToe.module "HomeApp", (HomeApp, App, Backbone, Marionette, $, _) ->

  class HomeApp.Layout extends Marionette.ItemView
    template: HAML["app/assets/scripts/home/templates/home_layout"]