# frozen_string_literal: true

module Auth
  class Decoder
    include Interactor

    def call
      context.decoded_token = decoded_token
    end

    delegate :request, to: :context

    private

    def header
      header = request.headers['Authorization']
      header&.split(' ')&.last
    end

    def decoded_token
      @decoded_token ||= Auth::JsonWebToken.decode(header)
    rescue JWT::DecodeError => e
      context.fail!(errors: e.message)
    end
  end
end
