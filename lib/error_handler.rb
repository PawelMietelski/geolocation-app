# frozen_string_literal: true

module ErrorHandler
  def self.included(clazz)
    clazz.class_eval do
      rescue_from GeneralApiExceptions::ResponseError do |e|
        respond(e.status, e.message)
      end
    end
  end

  private

  def respond(status, message)
    render json: { errors: [message] }, status:
  end
end
