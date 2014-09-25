$(window).resize ->
  width = $(window).width() - $("table#main").width()
  $("#chat").css "width", width / 5
  
  minSize = Math.min $(window).height(), $(window).width()
  $("td.out").width minSize / 4
  $("td.out").height minSize / 4
  $("td.in").width minSize / 15
  $("td.in").height minSize / 15

  $("table.main").css "margin-top", "#{($(window).height() - $("table.main").height()) / 2}px"

  # $("canvas").width $("table.main").width()
  # $("canvas").height $("table.main").height()
  # offset = $("table.main").offset()
  # if offset?
  #   $("canvas").offset 
  #     top: offset.top - 10 
  #     left: offset.left - 10

  properation = $(window).height() / $(window).width()
  if properation > 0.55 and properation < 1.3
    $("#left-page-region").hide()
    $("#right-page-region").hide()
  else
    $("#left-page-region").show()
    $("#right-page-region").show()
    if properation >= 1.3
      $("#left-page-region").addClass "top"
      $("#right-page-region").addClass "bottom"
    else
      $("#left-page-region").removeClass "top"
      $("#right-page-region").removeClass "bottom"
