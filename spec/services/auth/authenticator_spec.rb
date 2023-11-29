# frozen_string_literal: true

require 'rails_helper'

describe Auth::Authenticator do
  describe '#call' do
    context 'access_key is valid' do
      let(:access_key) { double('access_key') }

      before do
        allow(access_key).to receive(:eql?).and_return(true)
      end

      subject(:context) do
        Auth::Authenticator.call(access_key:)
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'result contains all data' do
        expect(context.token).to be_present
      end
    end

    context 'access_key is invalid' do
      let(:access_key) { double('wrong_key') }
      let(:execption) { GeneralApiExceptions::UnauthorizedError }

      before do
        allow(access_key).to receive(:eql?).and_return(false)
      end

      subject(:context) do
        Auth::Authenticator.call(access_key:)
      end

      it 'fails' do
        expect { context }.to raise_error(execption)
      end
    end
  end
end
