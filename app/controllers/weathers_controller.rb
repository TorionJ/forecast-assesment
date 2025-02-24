# frozen_string_literal: true

class WeathersController < ApplicationController
  def show
    # Will have a default adress of the Superdome if no address params are present...WHODAT!!
    # Responses are cached if successful for optimization
    if params[:address].present?
      address_attributes = address_params
    end
    @address = Address.new(address_attributes || Address.default_attributes)
    if @address.valid?
      begin
        geocoded_hash = GeocodeService.call(@address.formatted)
        cache_key = geocoded_hash[:zipcode]
        @cache_hit = Rails.cache.exist?(cache_key)
        @weather_data = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
          ForecastService.call(lat: geocoded_hash[:latitude], lon: geocoded_hash[:longitude])
        end
      rescue GeocodeService::GeocodeResponseError, Faraday::ResourceNotFound, Faraday::ConnectionFailed, OpenWeather::Errors::Fault => e
        flash.alert = e.message
      end
    else
      flash.alert = 'Address is not valid'
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state)
  end
end
