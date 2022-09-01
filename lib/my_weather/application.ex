defmodule MyWeather.Application do
  use Application

  def start(_, _) do
    children = [
      {Finch, name: MyFinch},
      MyWeather.UI
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
