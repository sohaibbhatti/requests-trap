class RequestsStream
  constructor: ->
    @request_stream = $('.requests').data('trap')

    if @request_stream
      @request_stream_url = "/#{@request_stream}/stream"
      @createStream()

  createStream: ->
    @evtSource = new EventSource(@request_stream_url)

    @evtSource.onmessage = (e) =>
      $('.requests').prepend(e.data)

jQuery ->
  new RequestsStream
