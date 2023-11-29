# frozen_string_literal: true

require 'rails_helper'

describe Api::Ipstack::Client do
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

  describe '#get_location' do
    context 'address is correct' do
      let(:address) { '104.26.11.194' }
      let(:ipstack_client) { instance_double(Api::Ipstack::Client, get_location: geolocation) }
      
      subject(:result) do
        ipstack_client.get_location(address)
      end

      it 'returns geolocation' do
        expect(result).to eq(geolocation)
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
