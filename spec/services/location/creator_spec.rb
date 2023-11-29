# frozen_string_literal: true

require 'rails_helper'

describe Location::Creator do
  describe '#call' do
    let(:api_client) { double('ApiClient') }
    context 'creator has valid parameters' do
      let(:address) { 'https://ipstack.com/' }
      let(:resolved_adress) { '172.67.73.233' }
      let(:geolocation) { {} }

      before do
        allow(api_client).to receive(:get_location).with(resolved_adress).and_return(geolocation)
      end

      subject(:context) do
        Location::Creator.call(address:, resolved_adress:, api_client:)
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'result contains all data' do
        expect(context.geolocation).to be_present
      end
    end

    context 'creator has invalid address' do
      let(:address) { 'invalid_address' }
      let(:resolved_adress) { '12345678' }

      before do
        allow(api_client).to receive(:get_location).with(resolved_adress).and_raise(Api::Ipstack::ApiExecptions::InvalidIpAddressError)
      end

      subject(:context) do
        Location::Creator.call(address:, resolved_adress:, api_client:)
      end

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure with errors' do
        expect(context.errors).to eq(['Given Ip address is not valid.'])
      end
    end
  end
end
