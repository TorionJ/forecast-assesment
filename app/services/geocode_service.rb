# frozen_string_literal: true

# Geocode service takes in an address and returns the latitude, longitude, and zipcode of said address if valid
class GeocodeService
  class GeocodeResponseError < StandardError; end

  DATA_ATTRIBUTES_MAPPING = {
    latitude: 'lat',
    longitude: 'lon',
    zipcode: 'address-postcode'
  }.freeze

  def self.call(address)
    geocode_data = validate_response(Geocoder.search(address))
    build_geocoded_hash(geocode_data)
  end

  def self.validate_response(response)
    raise GeocodeResponseError, 'Could not find any data for the address' if response.first&.data.nil?

    response.first.data
  end

  def self.build_geocoded_hash(data)
    geocode_hash = {}
    DATA_ATTRIBUTES_MAPPING.each_pair do |geocode_key, data_key|
      if data_key.split('-').count == 2
        key_one, key_two = data_key.split('-')
        geocode_hash[geocode_key] = data[key_one][key_two]
      else
        geocode_hash[geocode_key] = data[data_key].to_f
      end
    end
    geocode_hash
  end
end
