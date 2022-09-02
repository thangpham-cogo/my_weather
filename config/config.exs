import Config

config :my_weather, MyWeather.Controller,
  ui_client: MyWeather.UI.Console,
  provider: MyWeather.Provider.VisualCrossing,
  interval: 1000

import_config("#{config_env()}.exs")
