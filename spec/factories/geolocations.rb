# frozen_string_literal: true

FactoryBot.define do
  factory :geolocation do
    address { 'https://api.rubyonrails.org/' }
    location do
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
  end
end
