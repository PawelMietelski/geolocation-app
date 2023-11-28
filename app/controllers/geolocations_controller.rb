# frozen_string_literal: true

class GeolocationsController < ApplicationController
  before_action :authorize_request
  
  def create
    result = Location::LocationOrganizer.call(address: geolocation_params[:address])
    if result.success?
      render json: result.geolocation, status: :ok
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    geolocation.destroy
    head :no_content
  end

  def show
    render json: geolocation, status: :ok
  end

  private

  def geolocation
    geolocation = Geolocation.find_by(address: geolocation_params[:address])
    raise GeneralApiExceptions::NotFoundError if geolocation.nil?
    geolocation
  end

  def geolocation_params
    params.permit(:address)
  end
end
