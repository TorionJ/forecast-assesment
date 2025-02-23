#  frozen_string_literal: true

require 'test_helper'

class ForecastServiceTest < ActiveSupport::TestCase
  describe '.call' do
    subject { ForecastService }
    context "when there's a valid latitude and longitude" do
      it 'should return hash with forecasts' do
        VCR.use_cassette('valid_forecast_response') do
          forecast = subject.call(lat: 29.9510489, lon: -90.08230762538903)
          assert(forecast.daily)
        end
      end
    end

    context "when there's an invalid latitude and longitude" do
      it 'should return GeocodeResponseError' do
        VCR.use_cassette('invalid_forecast_response') do
          error = assert_raises OpenWeather::Errors::Fault do
            subject.call(lat: '', lon: '')
          end
          assert_equal('Nothing to geocode', error.message)
        end
      end
    end
  end
end
