defmodule WeatherWeb.DataController do
  use WeatherWeb, :controller

  alias Weather.Stations.Data
  alias Weather.Connection

  action_fallback(WeatherWeb.FallbackController)

  def create(conn, %{"data" => data_params, "station_id" => station_id}) do
    params = for {key, val} <- data_params, into: %{}, do: {String.to_atom(key), val}
    data = %Data{}
    data = %{data | fields: Map.merge(data.fields, params)}
    data = %{data | tags: %{data.tags | station_id: String.to_integer(station_id)}}

    with :ok <- Connection.write(data) do
      send_resp(conn, :no_content, "")
    end
  end
end
