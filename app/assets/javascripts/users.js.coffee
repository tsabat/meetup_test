jQuery ($) ->
  $('#events').remove()

  $("a[data-type=html]").on "ajax:success", (event, data, status, xhr) ->
    $('#events').remove()
    $(this).parent().append(data)
    return
