defmodule Weather.Stations do
  @moduledoc """
  The Stations context.
  """

  import Ecto.Query, warn: false

  alias Weather.Repo
  alias Weather.Stations.{Data, Station}

  @doc """
  Returns the list of stations.
  """
  def list_stations do
    Station
    |> order_by(:name)
    |> Repo.all()
  end

  

  @doc """
  Gets a single station.
  """
  def find_station(id), do: Repo.get(Station, id)

  @doc """
  Gets the first station.
  """
  def first(), do: Station |> first |> Repo.one()

  @doc """
  Creates a station.
  """
  def create_station(attrs \\ %{}) do
    %Station{}
    |> Station.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a station.
  """
  def update_station(%Station{} = station, attrs) do
    station
    |> Station.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Station.
  """
  def delete_station(%Station{} = station) do
    Repo.delete(station)
  end

  @doc """
  Returns the list of datas for a station.
  """
  def list_datas(station, args) do
    Data.query(station.id, args)
  end

  @doc """
  Returns the current data of a station
  """
  def current_data(station) do
    Data.query(station.id, %{limit: 1})
  end
end
