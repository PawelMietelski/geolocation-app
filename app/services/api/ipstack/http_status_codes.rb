# frozen_string_literal: true

module Api
  module Ipstack
    module HttpStatusCodes
      CODES = {
        404 => 'NotFoundError',
        101 => 'AccessKeyError',
        102 => 'InactiveUserError',
        103 => 'InvalidApiFunctionError',
        104 => 'UsageLimitReachedError',
        105 => 'HttpsAccessRestrictedError',
        106 => 'InvalidIpAddressError',
        301 => 'InvalidFieldsError',
        302 => 'TooManyIpsError',
        303 => 'BatchNotSupportedOnPlanError'
      }.freeze
    end
  end
end
