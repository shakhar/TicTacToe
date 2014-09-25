class window.Timer
  constructor: ->
    @digit_to_name = "zero one two three four five six seven eight nine".split(" ")
    @digits = {}
    @start = moment()
    @stop = false

    _this = @
    positions = [ "s1", "s2" ]
    $.each positions, ->
      pos = $("<div>")
      for i in [0...8]
        pos.append "<span class='d" + i + "'>"
      _this.digits[@] = pos
      $("#timer").append pos

  startTimer: ->
    $("#timer").show()
    @stop = false
    @start = moment()
    setTimeout =>
      @updateTime()
    , 0

  stopTimer: ->
    @stop = true

  timeOut: ->
    $(window).trigger "time_out"
    @stopTimer()   
    @startTimer()

  updateTime: ->
    sec = 60 - ((moment() - @start) / 1000 | 0)
    @digits.s1.attr "class", @digit_to_name[sec / 10 | 0]
    @digits.s2.attr "class", @digit_to_name[sec % 10]
    @timeOut() if sec < 1
    unless @stop  
      setTimeout =>
        @updateTime()
      , 1000