# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :handle_db_down
  include ErrorHandler

  def authorize_request
    result = Auth::Decoder.call(request:)
    return if result.success?

    raise GeneralApiExceptions::UnauthorizedError
  end

  def handle_db_down
    render json: { errors: 'DB connection down'}, status: :service_unavailable
  end
end
