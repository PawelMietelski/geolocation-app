# frozen_string_literal: true

class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    result = Auth::Authenticator.call(access_key: login_params[:access_key])
    if result.success?
      render json: { token: result.token }, status: :ok
    else
      raise GeneralApiExceptions::UnauthorizedError
    end
  end

  private

  def login_params
    params.permit(:access_key)
  end
end
