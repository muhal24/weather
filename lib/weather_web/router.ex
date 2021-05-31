defmodule WeatherWeb.Router do
  use WeatherWeb, :router

  # Aliases
  alias Weather.Authentication
  alias WeatherGraph.{Plugs, Schema}
  alias WeatherWeb.{DataController, UserSocket}
  # Pipelines
  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :graphql do
    plug(:accepts, ["json"])

    plug(Authentication.Pipeline)
    plug(Plugs.Context)
  end

  scope "/api" do
    pipe_through(:api)

    post("/stations/:station_id/datas", DataController, :create)
  end

  scope "/graphql" do
    pipe_through(:graphql)

    forward(
      "/",
      Absinthe.Plug,
      schema: Schema,
      socket: UserSocket
    )
  end

  with :dev <- Mix.env() do
    scope "/graphiql" do
      pipe_through(:graphql)

      forward(
        "/",
        Absinthe.Plug.GraphiQL,
        schema: Schema,
        socket: UserSocket,
        interface: :playground
      )
    end
  end
end
