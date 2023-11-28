# frozen_string_literal: true

module Api
  module Ipstack
    module ApiExecptions
      include GeneralApiExceptions
      class AccessKeyError < GeneralApiExceptions::ResponseError
        def initialize
          super(:missing_access_key, 101, 'No API Key was specified or an invalid API Key was specified.')
        end
      end

      class InactiveUserErorr < GeneralApiExceptions::ResponseError
        def initialize
          super(:inactive_user, 102, 'The current user account is not active.')
        end
      end

      class InvalidApiFunctionError < GeneralApiExceptions::ResponseError
        def initialize
          super(:inactive_user, 103, 'The requested API endpoint does not exist.')
        end
      end

      class UsageLimitReachedError < GeneralApiExceptions::ResponseError
        def initialize
          super(:usage_limit_reached, 104, 'The maximum allowed amount of monthly API requests has been reached.')
        end
      end

      class HttpsAccessRestrictedError < GeneralApiExceptions::ResponseError
        def initialize
          super(:https_access_restricted, 105, 'User current subscription plan does not support HTTPS Encryption.')
        end
      end

      class InvalidIpAddressError < GeneralApiExceptions::ResponseError
        def initialize
          super(:invalid_ip_address, 106, 'Given Ip address is not valid.')
        end
      end

      class InvalidFieldsError < GeneralApiExceptions::ResponseError
        def initialize
          super(:invalid_fields, 301, 'One or more invalid fields were specified using the fields parameter')
        end
      end

      class TooManyIpsError < GeneralApiExceptions::ResponseError
        def initialize
          super(:too_many_ips, 302, 'Too many IPs have been specified for the Bulk Lookup Endpoint. (max. 50)')
        end
      end

      class BatchNotSupportedOnPlanError < GeneralApiExceptions::ResponseError
        def initialize
          super(:batch_not_supported_on_plan, 303, 'The Bulk Lookup Endpoint is not supported on the current subscription plan')
        end
      end
    end
  end
end
