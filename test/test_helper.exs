Mox.defmock(MockFinch, for: MyWeather.Provider.FinchRequestBehavior)
Application.put_env(:my_weather, :finch, MockFinch)

ExUnit.start()
