# frozen_string_literal: true

require 'rails_helper'

describe Api::Ipstack::Client do
  let(:location) { build(:geolocation).location }

  describe '#get_location' do
    context 'address is correct' do
      let(:address) { '104.26.11.194' }
      let(:ipstack_client) { instance_double(Api::Ipstack::Client, get_location: location) }

      subject(:result) do
        ipstack_client.get_location(address)
      end

      it 'returns geolocation' do
        expect(result).to eq(location)
      end
    end

    context 'address is not correct' do
      let(:address) { '123456' }
      let(:execption) { Api::Ipstack::ApiExecptions::InvalidIpAddressError }
      let(:ipstack_client) { instance_double(Api::Ipstack::Client) }

      before do
        allow(ipstack_client).to receive(:get_location).and_raise(execption)
      end

      subject(:result) do
        ipstack_client.get_location(address)
      end

      it 'raises error' do
        expect { result }.to raise_error(execption)
      end
    end
  end
end
