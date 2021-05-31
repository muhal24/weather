defmodule WeatherGraph.Plugs.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} -> put_private(conn, :absinthe, %{context: context})
      _ -> conn
    end
  end

  def build_context(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil -> {:error}
      user -> {:ok, %{current_user: user}}
    end
  end
end
