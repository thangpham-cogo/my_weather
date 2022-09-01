defmodule MyWeather.VisualCrossingProvider do
  @behaviour MyWeather.WeatherProviderBehavior

  @location "Auckland/NZ"

  # TODO: extract these into config later
  @api_key "KQ2DBL6NDJC6TPHQRLKU4TB8U"
  @endpoint "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline"
  @default_queries %{
    "unitGroup" => "metric",
    "include" => "days",
    "key" => @api_key
  }

  @impl true
  def current_weather(location \\ @location, datetime_string) do
    Finch.build(:get, build_url(location, datetime_string))
    |> Finch.request(MyFinch)
    |> parse_response()
  end

  defp build_url(location, datetime_string) do
    "#{@endpoint}/#{location}/#{datetime_string}?" <> URI.encode_query(@default_queries)
  end

  defp parse_response(resp) do
    with {:ok, body} <- parse(resp),
         {:ok, data} <- JSON.decode(body) do
      data
    else
      {:error, _} -> {:error, :unavailable}
    end
  end

  defp parse({:ok, %{status: 200, body: body}}) do
    {:ok, body}
  end

  defp parse({:error, _}) do
    {:error, :unavailable}
  end
end
