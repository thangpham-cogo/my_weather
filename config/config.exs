import Config

config :my_weather, MyWeather.Controller,
  ui_client: MyWeather.UI.Console,
  provider: MyWeather.Provider.VisualCrossing

import_config("#{config_env()}.exs")
