defmodule MyWeather.UI.Console do
  @moduledoc """
  Handles displaying weather condition to the console
  """

  @spec display_weather(data :: MyWeather.WeatherCondition.t()) :: :ok
  def display_weather(data) do
    data
    |> format_data()
    |> IO.puts()
  end

  def display_error() do
    IO.puts("Sorry. Please come back later")
  end

  defp format_data(data) do
    "#{String.capitalize(data.description)} - #{String.capitalize(data.conditions)} - Wind Speed at #{to_string(data.wind_speed)}m/s - It's #{to_string(data.temperature)} C and feels like #{to_string(data.feels_like)} C"
  end
end
