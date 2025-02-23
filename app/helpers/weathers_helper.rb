# frozen_string_literal: true

module WeathersHelper
  def format_weather_weekday(datetime)
    datetime.strftime("%A")
  end

  def format_month_date(datetime)
    datetime.strftime("%-m/%e")
  end

  def high_and_low_temp(temp)
    "H:#{format_degrees(temp.max)}/L:#{format_degrees(temp.min)}"
  end

  def format_degrees(temp)
    "#{temp.round}&#x2109;"
  end

  def icon_uri(forecast)
    forecast.weather.first.icon_uri.to_s
  end
end
