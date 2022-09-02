defmodule MyWeather.ControllerTest do
  use ExUnit.Case

  import Mox
  import ExUnit.CaptureIO

  alias MyWeather.Controller

  describe "run/0" do
    test "calls display_weather if data comes back" do
      json = read_json("200.json")

      stub(MockFinch, :request, fn _, _ -> {:ok, %{status: 200, body: json}} end)

      assert capture_io(&Controller.run/0) =~
               "Partly cloudy throughout the day with morning rain. - Rain, partially cloudy - Wind Speed at 11.2m/s - It's 11.7 C and feels like 11.6 C"
    end

    test "calls display_error if fails to fetch data" do
      stub(MockFinch, :request, fn _, _ -> {:error, %{status: 404, body: "not found"}} end)

      assert capture_io(&Controller.run/0) =~ "Sorry. Please come back later"
    end
  end

  defp read_json(filename), do: File.read!(Path.join(["test", "data", filename]))
end
