defmodule WeatherGraph.Types.Stations do
  use Absinthe.Schema.Notation

  alias WeatherGraph.Resolvers

  import_types(Absinthe.Type.Custom)

  @desc "A station in the application"
  object :station do
    field(:id, non_null(:id))
    field(:name, non_null(:string))

    field :current, type: :data do
      resolve(&Resolvers.Stations.current_data/3)
    end

    field :datas, list_of(:data) do
      arg(:time, :time_filter)
      arg(:group_by, :group_filter)

      resolve(&Resolvers.Stations.list_datas/3)
    end
  end

  @desc "A data of a station"
  object :data do
    field(:time, :string)
    field(:barometer, :float)
    field(:in_temperature, :float)
    field(:out_temperature, :float)
    field(:in_humidity, :float)
    field(:out_humidity, :float)
    field(:rain_rate, :float)
    field(:ten_min_wind_speed, :float)
    field(:wind_direction, :float)
    field(:wind_speed, :float)
  end

  @desc "The Station input"
  input_object :station_params do
    field(:name, non_null(:string))
  end

  @desc "The time filter input"
  input_object :time_filter do
    field(:start_time, :datetime)
    field(:end_time, :datetime)
  end

  @desc "The group filter input"
  input_object :group_filter do
    field(:interval, :interval)
    field(:method, :method)
  end

  enum :interval do
    value(:minute, as: '1m', description: "By Minutes")
    value(:hour, as: '1h', description: "By Hours")
    value(:day, as: '1d', description: "By Days")
  end

  enum :method do
    value(:mean, as: 'mean', description: "Mean")
    value(:sum, as: 'sum', description: "Sum")
  end
end
