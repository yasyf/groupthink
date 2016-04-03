checkStatus = ->
  $.get("#{location.pathname}/status").then (response) ->
    location.reload() if response.ready

$(document).ready ->
  if $("#fakeloader").length > 0
    $("#fakeloader").fakeLoader
      timeToHide: Math.pow(10, 10)
      spinner: 'spinner1'
      bgColor: '#61b7ec'

    setInterval checkStatus, 1000
