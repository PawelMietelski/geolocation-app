# frozen_string_literal: true

module Auth
  class Authenticator
    include Interactor

    def call
      context.token = token
    end

    delegate :access_key, to: :context

    private

    def token
      Auth::JsonWebToken.encode(access_key: access_key)
    end

    def authenticate!
      return if access_key.eql? ENV['APPLICATION_ACCESS_KEY']
      raise GeneralApiExceptions::UnauthorizedError
    end
  end
end
