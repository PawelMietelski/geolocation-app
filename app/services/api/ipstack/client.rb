# frozen_string_literal: true

module Api
  module Ipstack
    class Client
      include HTTParty
      include HttpStatusCodes
      include ApiExecptions
      base_uri 'http://api.ipstack.com/'
      default_timeout 1

      def get_location(adress)
        handle_timeouts do
          request(
            http_method: :get,
            endpoint: "/#{adress}",
            params: { query: { access_key: } }
          )
        end
      end

      private

      def access_key
        ENV['IPSTACK_ACCESS_KEY']
      end

      def handle_timeouts
        yield
      rescue Net::OpenTimeout, Net::ReadTimeout
        raise GeneralApiExceptions::RequestTimeoutError
      end

      def request(http_method:, endpoint:, params: {})
        response = self.class.public_send(http_method, endpoint, params)

        return response if response_successful?(response)

        raise error_class(response)
      end

      def response_successful?(response)
        response['error'].nil?
      end

      def error_code(response)
        response['error']['code']
      end

      def api_error(response)
        CODES[error_code(response)]
      end

      def error_class(response)
        ApiExecptions.const_get(api_error(response)).new
      end
    end
  end
end
