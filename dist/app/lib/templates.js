(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/game/templates/board'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<canvas width='590' height='590'></canvas>\n<table class='main'>\n  <tr>\n    <td class='left out up'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'>    </td>\n        </tr>\n      </table>\n    </td>\n    <td class='center out up'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'>    </td>\n        </tr>\n      </table>\n    </td>\n    <td class='out right up'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'>    </td>\n        </tr>\n      </table>\n    </td>\n  </tr>\n  <tr>\n    <td class='center left out'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'>    </td>\n        </tr>\n      </table>\n    </td>\n    <td class='center centers out'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'>    </td>\n        </tr>\n      </table>\n    </td>\n    <td class='center out right'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'>    </td>\n        </tr>\n      </table>\n    </td>\n  </tr>\n  <tr>\n    <td class='down left out'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'>    </td>\n        </tr>\n      </table>\n    </td>\n    <td class='center down out'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'>    </td>\n        </tr>\n      </table>\n    </td>\n    <td class='down out right'>\n      <table>\n        <tr>\n          <td class='in left up'></td>\n          <td class='center in up'></td>\n          <td class='in right up'></td>\n        </tr>\n        <tr>\n          <td class='center in left'></td>\n          <td class='center centers in'></td>\n          <td class='center in right'></td>\n        </tr>\n        <tr>\n          <td class='down in left'></td>\n          <td class='center down in'></td>\n          <td class='down in right'></td>\n        </tr>\n      </table>\n    </td>\n  </tr>\n</table>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/game/templates/game_layout'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div id='left-page-region'></div>\n<div id='right-page-region'></div>\n<div id='board-region'></div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/game/templates/one_player/left_page'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<img id='x-tie' style='display: none' src='assets/images/smallX.png'>\n<img id='o-tie' style='display: none' src='assets/images/smallO.png'>\n<img id='smallX' src='assets/images/smallX.png'>\n<img id='smallO' style='display: none' src='assets/images/smallO.png'>\n<span>Turn</span>\n<button class='btn' id='new-game-btn'>New Game</button>\n<div class='btn-group' id='level-btn-group' data-toggle='buttons'>\n  <label class='active btn btn-primary'>\n    <input id='easy' type='radio' name='options'>Easy</input>\n  </label>\n  <label class='btn btn-primary'>\n    <input id='medium' type='radio' name='options'>Medium</input>\n  </label>\n  <label class='btn btn-primary'>\n    <input id='hard' type='radio' name='options'>Hard</input>\n  </label>\n</div>\n<div>\n  <select class='form-control' id='level-select'>\n    <option value='1'>Level 1</option>\n    <option value='2'>Level 2</option>\n    <option value='3'>Level 3</option>\n    <option value='4'>Level 4</option>\n    <option value='5'>Level 5</option>\n    <option value='6'>Level 6</option>\n    <option value='7'>Level 7</option>\n  </select>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/game/templates/one_player/right_page'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      return $o.join("\n");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/game/templates/two_players/left_page'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<img id='x-tie' style='display: none' src='assets/images/smallX.png'>\n<img id='o-tie' style='display: none' src='assets/images/smallO.png'>\n<img id='smallX' src='assets/images/smallX.png'>\n<img id='smallO' style='display: none' src='assets/images/smallO.png'>\n<span>Turn</span>\n<button class='btn' id='new-game-btn'>New Game</button>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/game/templates/two_players/right_page'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      return $o.join("\n");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/game/templates/two_players_online/left_page'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<img id='x-tie' style='display: none' src='assets/images/smallX.png'>\n<img id='o-tie' style='display: none' src='assets/images/smallO.png'>\n<img id='smallX' src='assets/images/smallX.png'>\n<img id='smallO' style='display: none' src='assets/images/smallO.png'>\n<span>Turn</span>\n<button class='btn' id='new-game-btn'>New Game</button>\n<div id='connecting'>Connecting...</div>\n<div id='connect-failed-msg'>The server is down, Try again later</div>\n<div id='container'>\n  <div id='chat-log'>\n    <h4 id='log-heading'>Chat</h4>\n    <div id='conversation'></div>\n    <input id='data'>\n    <button class='btn btn-primary' id='data-send'>Send</button>\n  </div>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/game/templates/two_players_online/right_page'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div id='player'></div>\n<div id='timer'></div>\n<div id='loaderImage'></div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/home/templates/home_layout'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<div class='jumbotron'>\n  <img id='home-logo' src='assets/images/logo.png'>\n  <h1>Welcome to (TicTacToe)&sup2;</h1>\n  <p>The best TicTacToe game in the Universe!</p>\n  <p>\n    <a class='btn btn-lg btn-primary' role='button' href='About'>About</a>\n  </p>\n</div>");
      return $o.join("\n").replace(/\s(?:id|class)=(['"])(\1)/mg, "");
    }).call(context);
  };

}).call(this);
(function() {
  if (window.HAML == null) {
    window.HAML = {};
  }

  window.HAML['app/assets/scripts/instructions/templates/instructions_layout'] = function(context) {
    return (function() {
      var $o;
      $o = [];
      $o.push("<article>\n  <h1>Instructions</h1>\n  <section>\n    <span>1. Each turn, you mark one of the small squares.</span>\n  </section>\n  <section>\n    <span>2. When you get three in a row on a small board, you have won that board.</span>\n    <br>\n    <img src='assets/images/instructions2.png'>\n  </section>\n  <section>\n    <span>3. To win the game, you need to win three small boards in a row.</span>\n    <br>\n    <img src='assets/images/instructions3.png'>\n  </section>\n  <section>\n    <span>4. Your opponent determined which of the nine boards you will play by choosing the board position in the small board.</span>\n    <br>\n    <img src='assets/images/instructions4.png'>\n  </section>\n  <section>\n    <span>5. The first player can choose any of the nine boards to play.</span>\n  </section>\n  <section>\n    <span>6. If your opponent send you to a board that already won, you can continue marking the empty spots in it.</span>\n    <br>\n    <img src='assets/images/instructions6.png'>\n  </section>\n  <section>\n    <span>7. If your opponent send you to a board that is full, you can choose any empty spot you like on any of the other boards.</span>\n    <br>\n    <img src='assets/images/instructions7.png'>\n  </section>\n</article>");
      return $o.join("\n");
    }).call(context);
  };

}).call(this);
