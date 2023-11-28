# frozen_string_literal: true

class Geolocation < ApplicationRecord
  validates :address, presence: true, uniqueness: true
end
