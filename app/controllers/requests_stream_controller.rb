class RequestsStreamController < ApplicationController
  include ActionController::Live

  # GET /:trap_id/stream
  def event
    response.headers["Content-Type"] = "text/event-stream"

    StreamHandler.new(Request.connection, params[:trap_id]).listen! do |request_id|
      r = Request.find request_id
      response.stream.write("data: #{render_to_string partial: 'requests/request.html.slim',  locals: { request: r }}\n\n")
    end
  rescue IOError
    logger.info 'client disconnected'
  ensure
    response.stream.close
  end
end

