# frozen_string_literal: true

require 'rails_helper'

describe Location::LocationOrganizer do
  it 'calls the interactors' do
    expect(Location::AddressResolver).to receive(:call!).ordered
    expect(Location::Creator).to receive(:call!).ordered
    described_class.call
  end
end
