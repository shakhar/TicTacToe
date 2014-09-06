// Generated by CoffeeScript 1.7.1
(function() {
  var Hapi, options, server;

  Hapi = require("hapi");

  options = {
    views: {
      path: "dist/app/views",
      engines: {
        html: "handlebars"
      }
    }
  };

  server = Hapi.createServer("0.0.0.0", 3000, options);

  server.route({
    method: "GET",
    path: "/{path*}",
    handler: {
      directory: {
        path: "dist/app"
      }
    }
  });

  server.route({
    method: "GET",
    path: "/",
    handler: function(request, reply) {
      return reply.view("index");
    }
  });

  server.start();

  console.log("Server starts on port 3000...");

  exports.server = server;

}).call(this);
