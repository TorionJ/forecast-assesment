# frozen_string_literal: true

require 'test_helper'

class WeathersControllerTest < ActionDispatch::IntegrationTest
  describe "when there's a valid address" do
    it 'should return response success' do
      original_cache_store = Rails.cache
      Rails.cache = ActiveSupport::Cache::MemoryStore.new
      GeocodeService.expects(:call).returns({ zipcode: '90201' })
      ForecastService.expects(:call).returns({ result: 'ok' })
      get weathers_show_url, params: { address: { street: '10110 binary ave', city: 'microchip', state: 'solid' } }
      assert_response :success
      Rails.cache = original_cache_store
    end
  end

  describe "when there's an invalid address" do
    it 'should return response of bad_request' do
      get weathers_show_url, params: { address: { street: '232 oh no way' } }
      assert(flash.alert)
    end
  end
end
