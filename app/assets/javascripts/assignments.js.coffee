# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	$('.progress .progress-bar').progressbar({display_text: 'fill'})

$(document).ready(ready)
$('.progress .progress-bar').progressbar()
