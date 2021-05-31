defmodule Weather.StationsTest do
  use Weather.DataCase

  alias Weather.Stations

  describe "stations" do
    alias Weather.Stations.Station

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def station_fixture(attrs \\ %{}) do
      {:ok, station} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stations.create_station()

      station
    end

    test "list_stations/0 returns all stations" do
      station = station_fixture()
      assert Stations.list_stations() == [station]
    end

    test "get_station!/1 returns the station with given id" do
      station = station_fixture()
      assert Stations.get_station!(station.id) == station
    end

    test "create_station/1 with valid data creates a station" do
      assert {:ok, %Station{} = station} = Stations.create_station(@valid_attrs)
    end

    test "create_station/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stations.create_station(@invalid_attrs)
    end

    test "update_station/2 with valid data updates the station" do
      station = station_fixture()
      assert {:ok, station} = Stations.update_station(station, @update_attrs)
      assert %Station{} = station
    end

    test "update_station/2 with invalid data returns error changeset" do
      station = station_fixture()
      assert {:error, %Ecto.Changeset{}} = Stations.update_station(station, @invalid_attrs)
      assert station == Stations.get_station!(station.id)
    end

    test "delete_station/1 deletes the station" do
      station = station_fixture()
      assert {:ok, %Station{}} = Stations.delete_station(station)
      assert_raise Ecto.NoResultsError, fn -> Stations.get_station!(station.id) end
    end

    test "change_station/1 returns a station changeset" do
      station = station_fixture()
      assert %Ecto.Changeset{} = Stations.change_station(station)
    end
  end

  describe "datas" do
    alias Weather.Stations.Data

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def data_fixture(attrs \\ %{}) do
      {:ok, data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stations.create_data()

      data
    end

    test "list_datas/0 returns all datas" do
      data = data_fixture()
      assert Stations.list_datas() == [data]
    end

    test "get_data!/1 returns the data with given id" do
      data = data_fixture()
      assert Stations.get_data!(data.id) == data
    end

    test "create_data/1 with valid data creates a data" do
      assert {:ok, %Data{} = data} = Stations.create_data(@valid_attrs)
    end

    test "create_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stations.create_data(@invalid_attrs)
    end

    test "update_data/2 with valid data updates the data" do
      data = data_fixture()
      assert {:ok, data} = Stations.update_data(data, @update_attrs)
      assert %Data{} = data
    end

    test "update_data/2 with invalid data returns error changeset" do
      data = data_fixture()
      assert {:error, %Ecto.Changeset{}} = Stations.update_data(data, @invalid_attrs)
      assert data == Stations.get_data!(data.id)
    end

    test "delete_data/1 deletes the data" do
      data = data_fixture()
      assert {:ok, %Data{}} = Stations.delete_data(data)
      assert_raise Ecto.NoResultsError, fn -> Stations.get_data!(data.id) end
    end

    test "change_data/1 returns a data changeset" do
      data = data_fixture()
      assert %Ecto.Changeset{} = Stations.change_data(data)
    end
  end
end
