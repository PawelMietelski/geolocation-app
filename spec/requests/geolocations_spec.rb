# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Geolocations', type: :request do
  describe '#show' do
    let(:location) { build(:geolocation).location }

    let(:ipstack_client) do
      instance_double(Api::Ipstack::Client, get_location: location)
    end

    before(:each) do
      allow(Api::Ipstack::Client).to receive(:new).and_return(ipstack_client)
    end

    let(:access_token) { Auth::JsonWebToken.encode(access_key: ENV['APPLICATION_ACCESS_KEY']) }
    let(:invalid_token) { 'invalid token' }
    context 'record exists in db' do
      let(:geolocation) { create(:geolocation) }
      it 'gets geolocation' do
        get '/geolocations/show', params: { geolocation: { address: geolocation.address } },
                                  headers: { 'Authorization' => "Bearer #{access_token}" }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(geolocation.address)
      end
    end
    context 'record does not exists in db' do
      it 'it returns 404' do
        get '/geolocations/show', params: { geolocation: { address: 'address' } },
                                  headers: { 'Authorization' => "Bearer #{access_token}" }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Record not found')
      end
    end
    context 'access_token is not valid' do
      it 'it returns 401' do
        get '/geolocations/show', params: { geolocation: { address: 'address' } },
                                  headers: { 'Authorization' => "Bearer #{invalid_token}" }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Unauthorized')
      end
    end
    describe '#destroy' do
      context 'record exists in db' do
        let(:geolocation) { create(:geolocation) }
        it 'destroy geolocation' do
          delete '/geolocations/destroy', params: { geolocation: { address: geolocation.address } },
                                          headers: { 'Authorization' => "Bearer #{access_token}" }
          expect(response).to have_http_status(:no_content)
        end
      end
      context 'record does not exists in db' do
        it 'it returns 404' do
          delete '/geolocations/destroy', params: { geolocation: { address: 'address' } },
                                          headers: { 'Authorization' => "Bearer #{access_token}" }
          expect(response).to have_http_status(:not_found)
          expect(response.body).to include('Record not found')
        end
      end
      context 'access_token is not valid' do
        it 'it returns 401' do
          delete '/geolocations/destroy', params: { geolocation: { address: 'address' } },
                                          headers: { 'Authorization' => "Bearer #{invalid_token}" }
          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to include('Unauthorized')
        end
      end
      describe '#create' do
        context 'address is correct' do
          let(:address) { 'https://api.rubyonrails.org/' }
          it 'creates geolocation' do
            post '/geolocations', params: { geolocation: { address: } },
                                  headers: { 'Authorization' => "Bearer #{access_token}" }
            expect(response).to have_http_status(:ok)
            expect(response.body).to include(address)
          end
        end

        context 'address is not correct' do
          let(:invalid_address) { '12345' }
          it 'it returns 422' do
            post '/geolocations', params: { geolocation: { address: invalid_address } },
                                  headers: { 'Authorization' => "Bearer #{access_token}" }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.body).to include('Invalid URL or ip address')
          end
        end

        context 'access_token is not valid' do
          it 'it returns 401' do
            post '/geolocations', params: { geolocation: { address: 'address' } },
                                  headers: { 'Authorization' => "Bearer #{invalid_token}" }
            expect(response).to have_http_status(:unauthorized)
            expect(response.body).to include('Unauthorized')
          end
        end
      end
    end
  end
end
