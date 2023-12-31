# frozen_string_literal: true

module Location
  class Creator
    include Interactor

    def call
      geolocation = Geolocation.new(address:, location: get_location)
      if geolocation.save
        context.geolocation = geolocation
      else
        context.fail!(errors: geolocation.errors.full_messages)
      end
    end

    delegate :address, :resolved_adress, :api_client, to: :context

    private

    def get_location
      api_client.get_location(resolved_adress)
    rescue GeneralApiExceptions::ResponseError => e
      context.fail!(errors: [e.message])
    end
  end
end
