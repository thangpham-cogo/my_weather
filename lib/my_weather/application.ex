defmodule MyWeather.Application do
  @moduledoc false

  use Application

  def start(_, _) do
    Supervisor.start_link(children(), strategy: :one_for_one)
  end

  defp children() do
    if start_console?() do
      [
        {Finch, name: MyWeather.HttpClient.Finch},
        MyWeather.Controller
      ]
    else
      [
        {Finch, name: MyWeather.HttpClient.Finch}
      ]
    end
  end

  defp start_console?() do
    Application.get_env(:my_weather, MyWeather.Application, []) |> Keyword.get(:ui_client, true)
  end
end
