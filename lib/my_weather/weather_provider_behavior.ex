"""
{
  "queryCost": 1,
  "latitude": -36.8523,
  "longitude": 174.764,
  "resolvedAddress": "Auckland, New Zealand",
  "address": "Auckland,NZ",
  "timezone": "Pacific/Auckland",
  "tzoffset": 13.0,
  "days": [
      {
          "datetime": "2020-10-19",
          "datetimeEpoch": 1603018800,
          "tempmax": 67.9,
          "tempmin": 57.2,
          "temp": 61.5,
          "feelslikemax": 67.9,
          "feelslikemin": 57.2,
          "feelslike": 61.5,
          "dew": 56.3,
          "humidity": 83.4,
          "precip": 0.05,
          "precipprob": null,
          "precipcover": 16.67,
          "preciptype": null,
          "snow": 0.0,
          "snowdepth": 0.0,
          "windgust": null,
          "windspeed": 18.1,
          "winddir": 257.5,
          "pressure": 1017.5,
          "cloudcover": 52.5,
          "visibility": 8.4,
          "solarradiation": 246.1,
          "solarenergy": 12.4,
          "uvindex": 4.0,
          "sunrise": "06:31:21",
          "sunriseEpoch": 1603042281,
          "sunset": "19:41:04",
          "sunsetEpoch": 1603089664,
          "moonphase": 0.05,
          "conditions": "Rain, Partially cloudy",
          "description": "Partly cloudy throughout the day with a chance of rain throughout the day.",
          "icon": "rain",
          "stations": [
              "93119099999",
              "NZAA",
              "93129099999",
              "93110099999",
              "C4778"
          ],
          "source": "obs"
      }
  ],
  "stations": {
      "NZAA": {
          "distance": 18941.0,
          "latitude": -37.02,
          "longitude": 174.8,
          "useCount": 0,
          "id": "NZAA",
          "name": "NZAA",
          "quality": 50,
          "contribution": 0.0
      },
      "93119099999": {
          "distance": 17522.0,
          "latitude": -37.008,
          "longitude": 174.792,
          "useCount": 0,
          "id": "93119099999",
          "name": "AUCKLAND INTERNATIONAL, NZ",
          "quality": 50,
          "contribution": 0.0
      },
      "93129099999": {
          "distance": 80444.0,
          "latitude": -36.867,
          "longitude": 175.667,
          "useCount": 0,
          "id": "93129099999",
          "name": "WHITIANGA AERODROME AWS, NZ",
          "quality": 99,
          "contribution": 0.0
      },
      "93110099999": {
          "distance": 16751.0,
          "latitude": -37.0,
          "longitude": 174.8,
          "useCount": 0,
          "id": "93110099999",
          "name": "AUCKLAND AERO AWS, NZ",
          "quality": 99,
          "contribution": 0.0
      },
      "C4778": {
          "distance": 2515.0,
          "latitude": -36.863,
          "longitude": 174.739,
          "useCount": 0,
          "id": "C4778",
          "name": "CW4778 Auckland NZ",
          "quality": 0,
          "contribution": 0.0
      }
  }
}
"""

defmodule MyWeather.WeatherProviderBehavior do
  @type weather_condition() :: %{
          description: String.t(),
          conditions: String.t(),
          wind_speed: float(),
          temperature: float(),
          feels_like: float()
        }

  @type error :: {:error, :unavailable}

  @callback current_weather(location :: String.t(), datetime_string :: String.t()) ::
              {:ok, weather_condition()} | error()
end
