defmodule MyWeather.Provider.VisualCrossingTest do
  use ExUnit.Case
  import Mox

  alias MyWeather.Provider.VisualCrossing

  setup :verify_on_exit!

  describe "current_weather/1" do
    test "returns unavailable error for non 200 response" do
      expect(MockFinch, :request, fn _, MyWeather.HttpClient.Finch ->
        {:error, %{status: 404, body: "not found"}}
      end)

      assert {:error, :unavailable} = VisualCrossing.current_weather("Auckland,NZ")
    end

    test "parses a valid response with all fields available" do
      "200.json"
      |> read_json()
      |> mock_200_response()

      expected = %MyWeather.WeatherCondition{
        conditions: "Rain, Partially cloudy",
        description: "Partly cloudy throughout the day with morning rain.",
        feels_like: 11.6,
        temperature: 11.7,
        wind_speed: 11.2
      }

      assert {:ok, ^expected} = VisualCrossing.current_weather("Auckland,NZ")
    end

    test "parses a valid response with null fields" do
      # maybe just making a new json file?
      "200.json"
      |> read_json()
      |> Jason.decode!()
      |> update_in(["days", Access.all()], fn day ->
        day
        |> Map.put("conditions", nil)
        |> Map.put("feelslike", nil)
      end)
      |> mock_200_response()

      expected = %MyWeather.WeatherCondition{
        conditions: nil,
        description: "Partly cloudy throughout the day with morning rain.",
        feels_like: nil,
        temperature: 11.7,
        wind_speed: 11.2
      }

      assert {:ok, ^expected} = VisualCrossing.current_weather("Auckland,NZ")
    end

    test "returns error if no relevant day data is returned" do
      response =
        "200.json"
        |> read_json()
        |> Jason.decode!()

      [
        response |> Map.drop(["days"]),
        response |> Map.put("days", nil),
        response |> Map.put("days", [])
      ]
      |> Enum.each(fn resp ->
        mock_200_response(resp)

        assert {:error, :unavailable} = VisualCrossing.current_weather("Auckland,NZ")
      end)
    end
  end

  defp mock_200_response(body) when not is_binary(body) do
    expect(MockFinch, :request, fn _, MyWeather.HttpClient.Finch ->
      {:ok, %{status: 200, body: Jason.encode!(body)}}
    end)
  end

  defp mock_200_response(body) do
    expect(MockFinch, :request, fn _, MyWeather.HttpClient.Finch ->
      {:ok, %{status: 200, body: body}}
    end)
  end

  defp read_json(filename), do: File.read!(Path.join(["test", "data", filename]))
end
