# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery(document).ready ($) ->
  console.log("strna gtowa")
  $('.clickable-row').click ->
    window.location = $(this).data('href')
    return
  $('form').on 'click', '.remove_fields', (event) ->
    console.log($(this).closest('fieldset'))
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()
  return
