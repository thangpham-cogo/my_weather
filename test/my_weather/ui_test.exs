defmodule MyWeather.UITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "it displays current weather message to the console if data is available" do
    condition = %{
      description: "hot",
      conditions: "humid",
      wind_speed: 20.0,
      temperature: 20.0,
      feels_like: 20.0
    }

    assert capture_io(fn -> MyWeather.UI.display({:ok, condition}) end) =~
             "Hot - Humid - Wind Speed at 20.0m/s - It's 20.0 C and feels like 20.0 C"
  end

  test "it displays a nice message if there is an error" do
    assert capture_io(fn -> MyWeather.UI.display({:error, :unavailable}) end) =~
             "Sorry. Please come back later"
  end
end
