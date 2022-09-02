defmodule MyWeather.ControllerTest do
  use ExUnit.Case
  import Mox

  alias MyWeather.Controller

  setup :verify_on_exit!

  describe "run/1" do
    test "calls display_weather if data comes back" do
      expect(MockWeatherProvider, :current_weather, fn "Auckland,NZ" -> {:ok, "weather"} end)

      expect(MockUIClient, :display_weather, fn _ -> :ok end)

      assert Controller.run() == :ok
    end

    test "calls display_error if fails to fetch data" do
      expect(MockWeatherProvider, :current_weather, fn "Auckland,NZ" -> {:error, :unavailable} end)

      expect(MockUIClient, :display_error, fn -> :ok end)

      assert Controller.run() == :ok
    end
  end

  defp read_json(filename), do: File.read!(Path.join(["test", "data", filename]))
end
