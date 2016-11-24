defmodule Medium.Mixfile do
  use Mix.Project

  def project do
    [
      app: :medium,
      version: "0.1.0",
      elixir: "~> 1.3",
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      applications: [:logger, :hackney]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/cases"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:tesla, "~> 0.5.0"},
      {:hackney, "~> 1.6"},
      {:poison, "~> 3.0"},
      # Only test
      {:bypass, "~> 0.1", only: :test}
    ]
  end
end
