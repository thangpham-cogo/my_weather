defmodule MyWeather.UI.ConsoleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias MyWeather.UI.Console

  describe "display_weather/1" do
    test "it displays current weather message to the console if data is available" do
      condition = %{
        description: "hot",
        conditions: "humid",
        wind_speed: 20.0,
        temperature: 20.0,
        feels_like: 20.0
      }

      assert capture_io(fn -> Console.display_weather(condition) end) =~
               "Hot - Humid - Wind Speed at 20.0m/s - It's 20.0 C and feels like 20.0 C"
    end

    @tag :skip
    test "it leaves out any missing fields from the message" do
      condition = %{
        description: "hot",
        conditions: nil,
        wind_speed: nil,
        temperature: 20.0,
        feels_like: nil
      }

      assert capture_io(fn -> Console.display_weather(condition) end) =~
               "Hot - It's 20.0 C"
    end
  end

  test "display_error/0" do
    assert capture_io(fn -> Console.display_error() end) =~
             "Sorry. Please come back later"
  end
end
