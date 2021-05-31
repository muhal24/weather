defmodule Dependency.MixProject do
  use Mix.Project

  def project do
    [
      app: :dependency,
      version: "0.2.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Dependency",

      # Hex
      description: "Dependency injection for Elixir",
      package: package(),

      # Docs
      source_url: "https://github.com/joshnuss/dependency",
      homepage_url: "http://github.com/joshnuss/dependency",
      docs: [
        main: "Dependency",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Dependency.Application, []}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/joshnuss/dependency"},
    ]
  end

  defp deps do
    [{:ex_doc, "~> 0.19.0", only: :dev, runtime: false}]
  end
end
