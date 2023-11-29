# frozen_string_literal: true

require 'resolv'

module Location
  class AddressResolver
    include Interactor

    def call
      context.resolved_adress = resolve_address!
    end

    delegate :address, to: :context

    private

    def host
      uri = URI.parse(address)
      uri.host
    rescue URI::InvalidURIError => e
      context.fail!(errors: [e.message])
    end

    def resolve_address!
      return address if IPAddress.valid_ipv4?(address)

      begin
        host.present? ? Resolv.getaddress(host) : context.fail!(errors: ['Invalid URL or ip address'])
      rescue Resolv::ResolvError => e
        context.fail!(errors: [e.message])
      end
    end
  end
end
