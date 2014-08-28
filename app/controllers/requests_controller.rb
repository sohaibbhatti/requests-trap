class RequestsController < ApplicationController

  #POST  /:trap_id
  #GET   /:trap_id
  #PUT   /:trap_id
  #LABEL /:trap_id
  # etc....
  def create
    render json: { ok: true }, status: 200
  end
end
