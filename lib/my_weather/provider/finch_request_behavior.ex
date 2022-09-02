defmodule MyWeather.Provider.FinchRequestBehavior do
  @moduledoc """
  Defines request callback to allow mocking Finch with Mox
  """
  @callback request(map(), atom()) ::
              {:ok, %{status: integer(), body: binary()}} | {:error, any()}
end
