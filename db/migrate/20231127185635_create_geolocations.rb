# frozen_string_literal: true

class CreateGeolocations < ActiveRecord::Migration[7.1]
  def change
    create_table :geolocations do |t|
      t.string :address
      t.jsonb :geolocation, default: {}

      t.timestamps
    end
  end
end
