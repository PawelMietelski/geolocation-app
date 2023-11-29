# frozen_string_literal: true

require 'rails_helper'

describe Location::AddressResolver do
  describe '#call' do
    context 'resolver has valid parameters' do
      let(:address) { 'https://ipstack.com/' }

      subject(:context) do
        Location::AddressResolver.call(address:)
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'result contains all data' do
        expect(context.resolved_adress).to be_present
      end
    end
    context 'resolver has invalid parameters' do
      let(:address) { 'invalid_url' }

      subject(:context) do
        Location::AddressResolver.call(address:)
      end

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure with errors' do
        expect(context.errors).to eq(['Invalid URL or ip address'])
      end
    end
  end
end
