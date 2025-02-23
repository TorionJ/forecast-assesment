#  frozen_string_literal: true

require 'test_helper'

class GeocodeServiceTest < ActiveSupport::TestCase
  describe '.call' do
    subject { GeocodeService }
    context "when there's a valid address" do
      it 'should return hash with latitude, longitude, and zipcode' do
        VCR.use_cassette('valid_address_geocoded') do
          geocode_hash = subject.call('1500 Sugar Bowl Dr, New Orleans, LA')
          assert(geocode_hash[:latitude])
          assert(geocode_hash[:longitude])
          assert(geocode_hash[:zipcode])
        end
      end
    end

    context "when there's an invalid address" do
      it 'should return GeocodeResponseError' do
        VCR.use_cassette('invalid_address_geocoded') do
          error = assert_raises GeocodeService::GeocodeResponseError do
            subject.call('101 nowhere lane, NOLA, LA')
          end
          assert_equal('Could not find any data for the address', error.message)
        end
      end
    end
  end
end
