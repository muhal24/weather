defmodule WeatherGraph.Resolvers.Stations do
  alias Weather.Stations

  def list_stations(_args, _info) do
    {:ok, Stations.list_stations()}
  end

  def list_my_stations(_args, %{context: %{current_user: user}}) do
    {:ok, Stations.list_stations_for_user(user)}
  end

  def find_station(%{id: id}, _info) do
    case Stations.find_station(id) do
      nil -> {:error, "Station id #{id} was not found"}
      station -> {:ok, station}
    end
  end

  def find_station(_args, _info) do
    case Stations.first() do
      nil -> {:error, "Station was not found"}
      station -> {:ok, station}
    end
  end

  def create_station(_parent, %{station: station}, %{context: %{current_user: user}}) do
    station
    |> Map.put(:owner_id, user.id)
    |> Stations.create_station()
  end

  def list_datas(station, args, _info) do
    {:ok, Stations.list_datas(station, args)}
  end

  def current_data(station, _args, _info) do
    case Stations.current_data(station) do
      data -> {:ok, data}
    end
  end
end
