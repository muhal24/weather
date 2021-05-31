use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :weather, WeatherWeb.Endpoint, server: false

# Print only warnings and errors during test
config :logger, level: :warn
config :pbkdf2_elixir, :rounds, 1

# Configure your database
config :weather, Weather.Repo, pool: Ecto.Adapters.SQL.Sandbox
