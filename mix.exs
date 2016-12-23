defmodule Medium.Mixfile do
  use Mix.Project

  def project do
    [
      app: :medium,
      version: "0.2.0",
      elixir: "~> 1.3",
      description: "An Elixir wrapper for the Medium.com API",
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.travis": :test],
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
      {:poison, "~> 2.2 or ~> 3.0"},
      # Only dev
      {:ex_doc, ">= 0.0.0", only: :dev},
      # Only test
      {:bypass, "~> 0.1", only: :test},
      {:excoveralls, "~> 0.5", only: :test}
    ]
  end

  defp package do
    [
     name: :medium,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Roberto Dip"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/roperzh/medium-sdk-elixir"}
   ]
  end
end
