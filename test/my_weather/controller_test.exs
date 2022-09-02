defmodule MyWeather.ControllerTest do
  use ExUnit.Case
  import Mox

  alias MyWeather.Controller

  setup :verify_on_exit!

  describe "run/0" do
    test "calls display_weather if data comes back" do
      expect(MockWeatherProvider, :current_weather, fn _ -> {:ok, "weather"} end)
      expect(MockUIClient, :display_weather, fn _ -> "display weather condition" end)

      assert Controller.run() == "display weather condition"
    end

    test "calls display_error if fails to fetch data" do
      expect(MockWeatherProvider, :current_weather, fn _ -> {:error, :unavailable} end)
      expect(MockUIClient, :display_error, fn -> "display error" end)

      assert Controller.run() == "display error"
    end
  end

  defp read_json(filename), do: File.read!(Path.join(["test", "data", filename]))
end
