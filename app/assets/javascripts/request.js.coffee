class Request
  constructor: ->
    @toggleRawResponse()

  toggleRawResponse: ->
    $('.request dt a').on 'click', ->
      $(this).parent().next().toggleClass 'hide'

jQuery ->
  new Request
