# frozen_string_literal: true

require 'resolv'

module Location
  class AddressResolver
    include Interactor

    SCHEMES = %w[http https].freeze

    def call
      context.resolved_adress = resolved_address
    end

    delegate :address, to: :context

    private

    def parsed_url
      URI.parse(address)
    rescue URI::InvalidURIError
      context.fail!(errors: ['Invalid URL or ip address'])
    end

    def valid_url?
      SCHEMES.include?(parsed_url.scheme) && parsed_url.host.present?
    end

    def resolve_address!
      Resolv.getaddress(parsed_url.host)
    rescue Resolv::ResolvError, ArgumentError
      context.fail!(errors: ['Invalid URL or ip address'])
    end

    def resolved_address
      return address if IPAddress.valid_ipv4?(address)
      return resolve_address! if valid_url?

      context.fail!(errors: ['Invalid URL or ip address'])
    end
  end
end
