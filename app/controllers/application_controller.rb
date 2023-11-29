# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler

  def authorize_request
    result = Auth::Decoder.call(request:)
    return if result.success?

    raise GeneralApiExceptions::UnauthorizedError
  end
end
