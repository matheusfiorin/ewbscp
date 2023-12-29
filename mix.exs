defmodule Ewbscp.MixProject do
  use Mix.Project

  def project do
    [
      app: :ewbscp,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Ewbscp.Entrypoints.CLI.Input]
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
      {:tesla, "~> 1.8"},
      {:floki, "~> 0.35.0"}
    ]
  end
end
