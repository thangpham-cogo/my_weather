defmodule MyWeather.ControllerTest do
  use ExUnit.Case
  import Mox

  alias MyWeather.Controller

  setup :verify_on_exit!

  describe "run/1" do
    test "calls display_weather if data comes back" do
      expect(MockWeatherProvider, :current_weather, fn "Auckland,NZ" -> {:ok, "weather"} end)

      expect(MockUIClient, :display_weather, fn _ -> :ok end)

      {:ok, pid} = Controller.start_link([])
      Process.sleep(1)
      send(pid, :exit)
    end

    test "calls display_error if fails to fetch data" do
      expect(MockWeatherProvider, :current_weather, fn "Auckland,NZ" -> {:error, :unavailable} end)

      expect(MockUIClient, :display_error, fn -> :ok end)

      {:ok, pid} = Controller.start_link([])
      Process.sleep(1)
      send(pid, :exit)
    end

    test "call itself on a set interval" do
      expect(MockWeatherProvider, :current_weather, 3, fn "Auckland,NZ" -> {:ok, "weather"} end)

      expect(MockUIClient, :display_weather, 3, fn _ -> :ok end)

      {:ok, pid} = Controller.start_link([])
      Process.sleep(3000)

      send(pid, :exit)
    end
  end
end
