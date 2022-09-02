defmodule MyWeather.WeatherCondition do
  @moduledoc """
  Defines the weather condition struct used throughout the application
  """

  defstruct [:description, :conditions, :wind_speed, :temperature, :feels_like]

  @type t() :: %{
          description: String.t() | nil,
          conditions: String.t() | nil,
          wind_speed: float() | nil,
          temperature: float() | nil,
          feels_like: float() | nil
        }

  def new(opts) do
    struct(%__MODULE__{}, opts)
  end
end

defmodule MyWeather.WeatherProviderBehavior do
  @moduledoc """
  Defines callbacks and response type that any Weather Provider must implement
  """

  @type response() :: {:ok, MyWeather.WeatherCondition.t()} | {:error, :unavailable}

  @callback current_weather(location :: String.t()) :: response()
end
