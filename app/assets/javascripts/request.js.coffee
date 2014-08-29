class Request
  constructor: ->
    @toggleRawResponse()

  toggleRawResponse: ->
    $('.container').on 'click', '.request dt a',  ->
      $(this).parent().next().toggleClass 'hide'

jQuery ->
  new Request
