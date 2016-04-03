$(document).ready ->
  $('#submit').click ->
    return unless $('#username').val() and $('#name').val()
    window.location = "/list/#{$('#username').val()}/#{$('#name').val()}"
