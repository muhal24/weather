defmodule Weather.Mixfile do
  use Mix.Project

  def project do
    [
      app: :weather,
      version: "0.0.1",
      elixir: "~> 1.12.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Weather.Application, []},
      extra_applications: [:logger, :runtime_tools, :instream]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # HTTP
      {:cowboy, "~> 2.6"},

      # Phoenix
      {:phoenix, "~> 1.5.9"},
      {:phoenix_pubsub, "~> 2.0.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:poison, "~> 2.0"},
      {:gettext, "~> 0.18.2"},
      {:cors_plug, "~> 2.0.3"},
      {:postgrex, ">= 0.0.0"},
      {:plug_cowboy, "~> 2.5.0"},
      {:dependency, "~> 0.2.0", override: true},
      {:jason, "~> 1.0"},
 

  

      # GraphQL
      {:absinthe, "~> 1.6.4"},
      {:absinthe_plug, "~> 1.5.8"},

   
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
