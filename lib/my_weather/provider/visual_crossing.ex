defmodule MyWeather.Provider.VisualCrossing do
  @behaviour MyWeather.WeatherProviderBehavior

  @impl true
  def current_weather(location) do
    %{endpoint: endpoint, api_key: api_key} = api_config()

    Finch.build(:get, build_url(endpoint, location, api_key))
    |> Finch.request(MyFinch)
    |> parse_response()
  end

  defp build_url(endpoint, location, api_key) do
    queries = %{
      "unitGroup" => "metric",
      "include" => "days",
      "key" => api_key
    }

    "#{endpoint}/#{location}/#{current_datetime_string()}?" <> URI.encode_query(queries)
  end

  defp current_datetime_string() do
    DateTime.utc_now()
    |> DateTime.truncate(:second)
    |> DateTime.to_iso8601()
  end

  defp parse_response(resp) do
    with {:ok, body} <- parse(resp),
         {:ok, data} <- JSON.decode(body),
         {:ok, [day]} <- Map.fetch(data, "days"),
         condition <- map_to_condition(day) do
      {:ok, condition}
    else
      _ -> {:error, :unavailable}
    end
  end

  defp parse({:ok, %{status: 200, body: body}}) do
    {:ok, body}
  end

  defp parse(_) do
    {:error, :unavailable}
  end

  defp api_config() do
    Application.get_env(:my_weather, MyWeather.Provider.VisualCrossing) |> Enum.into(%{})
  end

  defp map_to_condition(day) do
    day
    |> Map.take(["description", "temp", "feelslike", "windspeed", "conditions"])
    |> then(
      &Map.new(&1, fn
        {"description", value} -> {:description, value}
        {"temp", value} -> {:temperature, value}
        {"feelslike", value} -> {:feels_like, value}
        {"windspeed", value} -> {:wind_speed, value}
        {"conditions", value} -> {:conditions, value}
      end)
    )
    |> MyWeather.WeatherCondition.new()
  end
end
