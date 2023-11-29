# frozen_string_literal: true

class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    result = Auth::Authenticator.call(access_key: login_params[:access_key])
    render json: { token: result.token }, status: :ok
  end

  private

  def login_params
    params.require(:authentication).permit(:access_key)
  end
end
