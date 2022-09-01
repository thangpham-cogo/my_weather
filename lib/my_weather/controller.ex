defmodule MyWeather.Controller do
  use Task, restart: :temporary

  @location "Auckland,NZ"

  def start_link(_opts) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run() do
    # this is blocking so how do we show loader for example ?
    # has another process (WeatherService - Server) doing the dispatching, and just wait on the response ?
    # needs to handle time-out as well
    # so a cast basically ?
    provider().current_weather(@location)
    |> MyWeather.UI.display()

    # Process.sleep(1000)
    # run()
  end

  defp provider() do
    Application.get_env(:my_weather, :provider, MyWeather.Provider.VisualCrossing)
  end
end
