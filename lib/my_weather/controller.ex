defmodule MyWeather.Controller do
  @moduledoc """
  Configure components from env and before starting application
  """

  use Task, restart: :temporary

  @location "Auckland,NZ"
  @interval 1000

  def start_link(_opts) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run() do
    fetch_and_display_weather()
    reschedule()
    :ok = wait_for_next_poll()
    run()
  end

  defp wait_for_next_poll() do
    receive do
      :exit -> Process.exit(self(), :normal)
      :fetch_weather -> :ok
    end
  end

  defp fetch_and_display_weather() do
    ui_client = config_for(:ui_client)
    weather_provider = config_for(:provider)

    @location
    |> weather_provider.current_weather()
    |> case do
      {:ok, data} -> ui_client.display_weather(data)
      _ -> ui_client.display_error()
    end
  end

  defp config_for(key, default \\ nil) do
    Application.get_env(:my_weather, MyWeather.Controller, []) |> Keyword.get(key, default)
  end

  defp reschedule() do
    Process.send_after(self(), :fetch_weather, config_for(:interval, @interval))
  end
end
