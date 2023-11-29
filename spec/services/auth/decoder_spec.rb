# frozen_string_literal: true

require 'rails_helper'

describe Auth::Decoder do
  describe '#call' do
    context 'token is valid' do
      let(:request) { double('request') }

      before do
        allow(request).to receive(:headers).and_return('token')
        allow(Auth::JsonWebToken).to receive(:decode).and_return('decoded_token')
      end

      subject(:context) do
        Auth::Decoder.call(request:)
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'result contains all data' do
        expect(context.decoded_token).to be_present
      end
    end

    context 'token is invalid' do
      let(:request) { double('request') }

      before do
        allow(request).to receive(:headers).and_return('invalid_token')
        allow(Auth::JsonWebToken).to receive(:decode).and_raise(JWT::DecodeError)
      end

      subject(:context) do
        Auth::Decoder.call(request:)
      end

      it 'fails' do
        expect(context.errors).to eq("JWT::DecodeError")
        expect(context).to be_a_failure
      end
    end
  end
end
