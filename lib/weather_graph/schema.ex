defmodule WeatherGraph.Schema do
  use Absinthe.Schema

  # Aliases

  alias WeatherGraph.Resolvers
  alias WeatherGraph.Types.Stations
 

  # Types
  import_types(Stations)
 

  query do
  

    @desc "Get the list of stations"
    field :stations, list_of(:station) do
      resolve(&Resolvers.Stations.list_stations/2)
    end

    @desc "Get a station"
    field :station, type: non_null(:station) do
      arg(:id, :id)

      resolve(&Resolvers.Stations.find_station/2)
    end
  end

  mutation do
 
    @desc "Create a station"
    field :create_station, type: non_null(:station) do
      arg(:station, non_null(:station_params))

      resolve(&Resolvers.Stations.create_station/3)
    end
  end
end
