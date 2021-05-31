use Mix.Config

config :weather, WeatherWeb.Endpoint,
  http: [port: System.get_env("PORT") || 4000], # <-- YOU ARE INTERESTED IN THIS HERE
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [],
  allowed_cors_profile: "all"

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
config :phoenix, :stacktrace_depth, 20
