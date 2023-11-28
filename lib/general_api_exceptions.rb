# frozen_string_literal: true

module GeneralApiExceptions
  class ResponseError < StandardError
    attr_reader :status, :error, :message

    def initialize(error = nil, status = nil, message = nil)
      @error = error || 422
      @status = status || :unprocessable_entity
      @message = message || 'Something went wrong'
    end
  end

  class NotFoundError < ResponseError
    def initialize
      super(:not_found, 404, 'Record not found')
    end
  end

  class UnauthorizedError < ResponseError
    def initialize
      super(:not_found, 403, 'Unauthorized')
    end
  end
end
