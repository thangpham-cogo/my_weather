import Config

config :my_weather, MyWeather.Provider.VisualCrossing,
  api_key: "api_key",
  endpoint: "https://test_endpoint.com"

config :my_weather, MyWeather.Application, ui_client: false
