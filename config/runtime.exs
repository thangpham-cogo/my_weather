import Config

# can be made into env vars
if config_env() == :prod do
  config :my_weather, MyWeather.Provider.VisualCrossing,
    api_key: "KQ2DBL6NDJC6TPHQRLKU4TB8U",
    endpoint:
      "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline"
end
