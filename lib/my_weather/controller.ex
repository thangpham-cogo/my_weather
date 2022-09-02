defmodule MyWeather.Controller do
  @moduledoc """
  Configure components from env and before starting application
  """

  use Task, restart: :temporary

  @location "Auckland,NZ"

  def start_link(_opts) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run(interval \\ interval()) do
    ui = ui_client()

    @location
    |> provider().current_weather()
    |> case do
      {:ok, data} -> ui.display_weather(data)
      _ -> ui.display_error()
    end

    if is_nil(interval) do
      :ok
    else
      Process.sleep(interval)
      run()
    end
  end

  defp provider() do
    app_config() |> Keyword.get(:provider)
  end

  defp ui_client() do
    app_config() |> Keyword.get(:ui_client)
  end

  defp interval() do
    app_config() |> Keyword.get(:interval, nil)
  end

  defp app_config() do
    Application.get_env(:my_weather, MyWeather.Controller, [])
  end
end
