@TicTacToe = new Marionette.Application

@TicTacToe.addRegions
  mainRegion: "#main-region"
  
@TicTacToe.start()

$ ->
  Backbone.history.start()