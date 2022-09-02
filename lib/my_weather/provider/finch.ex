defmodule MyWeather.Provider.Finch do
  @moduledoc """
  Simple wrapper around Finch.request to enable mocking in test
  """
  def request(request) do
    Application.get_env(:my_weather, :finch, Finch).request(request, MyWeather.HttpClient.Finch)
  end
end
