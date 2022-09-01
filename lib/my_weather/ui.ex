defmodule MyWeather.UI do
  use Task, restart: :temporary

  def start_link(_opts) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run() do
    provider().current_weather(DateTime.utc_now() |> DateTime.to_iso8601())
    |> IO.inspect()
  end

  defp provider() do
    Application.get_env(:my_weather, :provider)
  end
end
