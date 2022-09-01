defmodule MyWeather.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_weather,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.13.0"},
      {:credo, "~> 1.6.6"},
      {:mox, "~> 1.0.2"},
      {:json, "~> 1.4"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
