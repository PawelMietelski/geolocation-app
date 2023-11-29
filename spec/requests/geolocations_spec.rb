# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Geolocations', type: :request do
  describe '#show' do
    let(:geolocation) do
      { 'ip' => '104.26.11.194',
        'zip' => '20147',
        'city' => 'Ashburn',
        'type' => 'ipv4',
        'latitude' => 39.043701171875,
        'location' =>
       { 'is_eu' => false,
         'capital' => 'Washington D.C.',
         'languages' => [{ 'code' => 'en', 'name' => 'English', 'native' => 'English' }],
         'geoname_id' => 4_744_870,
         'calling_code' => '1',
         'country_flag' => 'https://assets.ipstack.com/flags/us.svg',
         'country_flag_emoji' => '🇺🇸',
         'country_flag_emoji_unicode' => 'U+1F1FA U+1F1F8' },
        'longitude' => -77.47419738769531,
        'region_code' => 'VA',
        'region_name' => 'Virginia',
        'country_code' => 'US',
        'country_name' => 'United States',
        'continent_code' => 'NA',
        'continent_name' => 'North America' }
    end

    let(:ipstack_client) do
      instance_double(Api::Ipstack::Client, get_location: geolocation)
    end

    before(:each) do
      allow(Api::Ipstack::Client).to receive(:new).and_return(ipstack_client)
    end

    let(:access_token) { Auth::JsonWebToken.encode(access_key: ENV['APPLICATION_ACCESS_KEY']) }
    let(:invalid_token) { 'invalid token' }
    context 'record exists in db' do
      let(:geolocation) { create(:geolocation) }
      it 'gets geolocation' do
        get '/geolocations/show', params: { address: geolocation.address },
                                  headers: { 'Authorization' => "Bearer #{access_token}" }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(geolocation.address)
      end
    end
    context 'record does not exists in db' do
      it 'it returns 404' do
        get '/geolocations/show', params: { address: 'address' },
                                  headers: { 'Authorization' => "Bearer #{access_token}" }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Record not found')
      end
    end
    context 'access_token is not valid' do
      it 'it returns 401' do
        get '/geolocations/show', params: { address: 'address' },
                                  headers: { 'Authorization' => "Bearer #{invalid_token}" }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Unauthorized')
      end
    end
    describe '#destroy' do
      context 'record exists in db' do
        let(:geolocation) { create(:geolocation) }
        it 'destroy geolocation' do
          delete '/geolocations/destroy', params: { address: geolocation.address },
                                          headers: { 'Authorization' => "Bearer #{access_token}" }
          expect(response).to have_http_status(:no_content)
        end
      end
      context 'record does not exists in db' do
        it 'it returns 404' do
          delete '/geolocations/destroy', params: { address: 'address' },
                                          headers: { 'Authorization' => "Bearer #{access_token}" }
          expect(response).to have_http_status(:not_found)
          expect(response.body).to include('Record not found')
        end
      end
      context 'access_token is not valid' do
        it 'it returns 401' do
          delete '/geolocations/destroy', params: { address: 'address' },
                                          headers: { 'Authorization' => "Bearer #{invalid_token}" }
          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to include('Unauthorized')
        end
      end
      describe '#create' do
        context 'address is correct' do
          let(:address) { 'https://api.rubyonrails.org/' }
          it 'creates geolocation' do
            post '/geolocations', params: { address: },
                                  headers: { 'Authorization' => "Bearer #{access_token}" }
            expect(response).to have_http_status(:ok)
            expect(response.body).to include(address)
          end
        end

        context 'address is not correct' do
          let(:invalid_address) { '12345' }
          it 'it returns 422' do
            post '/geolocations', params: { address: invalid_address },
                                  headers: { 'Authorization' => "Bearer #{access_token}" }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.body).to include('Invalid URL or ip address')
          end
        end

        context 'access_token is not valid' do
          it 'it returns 401' do
            post '/geolocations', params: { address: 'address' },
                                  headers: { 'Authorization' => "Bearer #{invalid_token}" }
            expect(response).to have_http_status(:unauthorized)
            expect(response.body).to include('Unauthorized')
          end
        end
      end
    end
  end
end
