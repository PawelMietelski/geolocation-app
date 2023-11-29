# frozen_string_literal: true

module Location
  class LocationOrganizer
    include Interactor::Organizer

    organize Location::AddressResolver, Location::Creator
  end
end
