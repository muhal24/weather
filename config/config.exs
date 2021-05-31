use Mix.Config

alias Weather.Authentication

# General application configuration
config :weather, ecto_repos: [Weather.Repo]
config :phoenix, :json_library, Poison

# Configures the endpoint
config :weather, WeatherWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT")],
  url: [host: System.get_env("BASE_URL"), port: System.get_env("PORT")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: WeatherWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Weather.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]







config :weather, Authentication.Pipeline,
  module: Authentication.Guardian,
  error_handler: Authentication.ErrorHandler

config :cors_plug,
  origin: [System.get_env("APP_DOMAIN") || "*"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
