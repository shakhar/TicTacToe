  $(window).resize ->
    width = $(window).width() - $("table#main").width()
    $("#chat").css "width", width / 5
    $("#log").css "width", width / 5
    
    minSize = Math.min $(window).height(), $(window).width()
    $("td.out").width minSize / 4
    $("td.out").height minSize / 4
    $("td.in").width minSize / 15
    $("td.in").height minSize / 15

    $("table.main").css "margin-top", "#{($(window).height() - $("table.main").height()) / 2 - $("nav").height()}px"

    $("canvas").width $("table.main").width()
    $("canvas").height $("table.main").height()
    offset = $("table.main").offset()
    if offset?
      $("canvas").offset 
        top: offset.top - 10 
        left: offset.left - 10
      $("canvas").css "z-index", 1