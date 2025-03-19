# frozen_string_literal: true

# OpenWeather Client receives the latitude and longitude of an address and returns Forecast data for the address
module API
  module Openweather
    class Client
      EXCLUDED_DATA = %w[minutely hourly].freeze

      def self.one_call(lat:, lon:)
        # Lat & Lon needs to be float numbers
        # EXCLUDED_DATA is added to exclude unneccessay data
        # Units come in 'standard', 'metric', and 'imperial'. I went with imperial since my application is based in US
        client.one_call(lat: lat, lon: lon, exclude: EXCLUDED_DATA, units: 'imperial')
      end

      def self.client
        OpenWeather::Client.new(
          api_key: Rails.application.credentials.open_weather_api_key
        )
      end
    end
  end
end