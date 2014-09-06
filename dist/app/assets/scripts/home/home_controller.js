// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.TicTacToe.module("HomeApp", function(HomeApp, App, Backbone, Marionette, $, _) {
    return HomeApp.Controller = (function(_super) {
      __extends(Controller, _super);

      function Controller() {
        return Controller.__super__.constructor.apply(this, arguments);
      }

      Controller.prototype.initialize = function() {
        this.region = this.options.region;
        this.layout = this.getLayoutView();
        return this.region.show(this.layout);
      };

      Controller.prototype.getLayoutView = function() {
        return new HomeApp.Layout;
      };

      return Controller;

    })(Marionette.Controller);
  });

}).call(this);
