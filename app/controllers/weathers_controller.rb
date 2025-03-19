# frozen_string_literal: true

class WeathersController < ApplicationController
  def show
    # Responses are cached if successful for optimization
    address_attributes = params[:address].present? ? address_params : {}
    @address = Address.new(address_attributes)
    if @address.valid?
      begin
        geocoded_hash = GeocodeService.new(@address.formatted).search
        cache_key = geocoded_hash[:zipcode]
        @cache_hit = Rails.cache.exist?(cache_key)
        @weather_data = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
          API::Openweather::Client.one_call(lat: geocoded_hash[:latitude], lon: geocoded_hash[:longitude])
        end
      rescue GeocodeService::GeocodeResponseError, Faraday::ResourceNotFound, Faraday::ConnectionFailed, OpenWeather::Errors::Fault => e
        flash.alert = e.message
      end
    else
      flash.tap do |f|
        if address_attributes.empty?
          f.notice = 'Please enter an address'
        else
          f.alert = 'Address is not valid'
        end
      end
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state)
  end
end
