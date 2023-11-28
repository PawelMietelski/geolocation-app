# frozen_string_literal: true

module Location
  class Creator
    include Interactor

    def call
      geolocation = Geolocation.new(address:, geolocation: get_geolocation)
      if geolocation.save
        context.geolocation = geolocation
      else
        context.fail!(errors: geolocation.errors.full_messages)
      end
    end

    delegate :address, :resolved_adress, to: :context

    private

    def get_geolocation
      api_client.get_location(resolved_adress)
    rescue GeneralApiExceptions::ResponseError => e
      context.fail!(errors: [e.message])
    end

    def api_client
      @api_client ||= Api::Ipstack::Client.new
    end
  end
end
