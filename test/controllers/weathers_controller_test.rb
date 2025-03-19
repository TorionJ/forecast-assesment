# frozen_string_literal: true

require 'test_helper'

class WeathersControllerTest < ActionDispatch::IntegrationTest
  describe "when there's a valid address" do
    let(:weather_data) do
      CurrentTemp = Struct.new(:temp)
      WeatherData = Struct.new(:current, :daily)
      current_temp = CurrentTemp.new(71)
      WeatherData.new(current_temp, nil)
    end

    it 'should return response success' do
      original_cache_store = Rails.cache
      Rails.cache = ActiveSupport::Cache::MemoryStore.new
      GeocodeService.any_instance.expects(:search).returns({ zipcode: '90201' })
      API::Openweather::Client.expects(:one_call).returns(weather_data)
      get weathers_show_url, params: { address: { street: '10110 binary ave', city: 'microchip', state: 'solid' } }
      assert_response :success
      Rails.cache = original_cache_store
    end
  end

  describe "when there's an invalid address" do
    it 'should return response of "Address is not valid"' do
      get weathers_show_url, params: { address: { street: '232 oh no way' } }
      assert_equal(flash.alert, 'Address is not valid')
    end
  end

  describe "when there's no address given" do
    it 'should return a response of "Please enter an address"' do
      get weathers_show_url
      assert_equal(flash.notice, 'Please enter an address')
    end
  end
end
