import Config

config :my_weather,
  api_key: "KQ2DBL6NDJC6TPHQRLKU4TB8U",
  endpoint: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services"

# Auckland?unitGroup=metric&key=KQ2DBL6NDJC6TPHQRLKU4TB8U&contentType=json

config :my_weather, :provider, MyWeather.VisualCrossingProvider
