# frozen_string_literal: true

require 'jwt'

module Auth
  class JsonWebToken
    SECRET_KEY = ENV['APPLICATION_SECRET_KEY']
    EXPIRATION_TIME = 24.hours.from_now

    def self.encode(payload)
      payload[:exp] = EXPIRATION_TIME.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end
end
