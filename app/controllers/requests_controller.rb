class RequestsController < ApplicationController

  #GET /:trap_id/requests
  def index
    @trap_requests = Request.by_trap_name params[:trap_id]
  end

  #GET /:trap_id/requests/:id
  def show
    @trap_request = Request.find_by_trap_name_and_id(params[:trap_id], params[:id])
  end

  #POST  /:trap_id
  #GET   /:trap_id
  #PUT   /:trap_id
  #LABEL /:trap_id
  # etc....
  def create
    trap_request = Request.new trap_name: params[:trap_id], data: request.env
    if trap_request.save
      render json: { ok: true }, status: 201
    else
      render json: { ok: false }, status: 400
    end
  rescue
    render json: { ok: false }, status: 500
  end
end
