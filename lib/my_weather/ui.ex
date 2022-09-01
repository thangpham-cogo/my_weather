defmodule MyWeather.UI do
  @spec display(MyWeather.WeatherProviderBehavior.response()) :: :ok
  def display({:ok, data}) do
    data
    |> format_data()
    |> IO.puts()
  end

  def display({:error, :unavailable}) do
    IO.puts("Sorry. Please come back later")
  end

  def display(_), do: display({:error, :unavailable})

  @spec format_data(MyWeather.WeatherCondition.t()) :: String.t()
  defp format_data(data) do
    "#{String.capitalize(data.description)} - #{String.capitalize(data.conditions)} - Wind Speed at #{to_string(data.wind_speed)}m/s - It's #{to_string(data.temperature)} C and feels like #{to_string(data.feels_like)} C"
  end
end
