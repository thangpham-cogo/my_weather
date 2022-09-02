defmodule MyWeather.UIClientBehavior do
  @moduledoc """
  Defines callback for ui client
  """

  @callback display_weather(weather :: MyWeather.WeatherCondition.t()) :: :ok
  @callback display_error() :: :ok
end
