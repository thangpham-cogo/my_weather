Mox.defmock(MockFinch, for: MyWeather.Provider.FinchRequestBehavior)
Mox.defmock(MockUIClient, for: MyWeather.UIClientBehavior)
Mox.defmock(MockWeatherProvider, for: MyWeather.WeatherProviderBehavior)

Application.put_env(:my_weather, :finch, MockFinch)

Application.put_env(:my_weather, MyWeather.Controller,
  ui_client: MockUIClient,
  provider: MockWeatherProvider
)

ExUnit.start()
