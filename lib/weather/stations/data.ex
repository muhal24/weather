defmodule Weather.Stations.Data do
  use Instream.Series

  alias Weather.Connection

  @fields ~w(barometer
    bar_trend
    in_temperature
    out_temperature
    in_humidity
    out_humidity
    rain_rate
    ten_min_wind_speed
    wind_direction
    wind_speed
  )a

  series do
    measurement("datas")

    tag(:station_id)

    @fields
    |> Enum.map(&field/1)
  end

  def query(station_id, %{
        group_by: %{interval: interval, method: method},
        time: %{start_time: start_time, end_time: end_time}
      }) do
    start_time = DateTime.to_iso8601(start_time)
    end_time = DateTime.to_iso8601(end_time)

    list_fields()
    |> Enum.reduce([], &(["#{method}(#{&1}) as #{&1}"] ++ &2))
    |> Enum.join(", ")
    |> (&"SELECT time, #{&1} FROM datas WHERE station_id = '#{station_id}' AND time >= '#{
          start_time
        }' AND time < '#{end_time}' GROUP BY time(#{interval}) ORDER BY time DESC").()
    |> parse_result()
  end

  def query(station_id, %{group_by: %{interval: interval, method: method}}) do
    list_fields()
    |> Enum.reduce([], &(["#{method}(#{&1}) as #{&1}"] ++ &2))
    |> Enum.join(", ")
    |> (&"SELECT time, #{&1} FROM datas WHERE station_id = '#{station_id}'  GROUP BY time(#{
          interval
        }) ORDER BY time DESC").()
    |> parse_result()
  end

  def query(station_id, %{time: %{start_time: start_time, end_time: end_time}}) do
    start_time = DateTime.to_iso8601(start_time)
    end_time = DateTime.to_iso8601(end_time)

    list_fields()
    |> Enum.join(", ")
    |> (&"SELECT time, #{&1} FROM datas WHERE station_id = '#{station_id}' AND time >= '#{
          start_time
        }' AND time < '#{end_time}' ORDER BY time DESC").()
    |> parse_result()
  end

  def query(station_id, %{limit: limit}) do
    list_fields()
    |> Enum.join(", ")
    |> (&"SELECT time, #{&1} FROM datas WHERE station_id = '#{station_id}' ORDER BY time DESC LIMIT #{
          limit
        }").()
    |> parse_result()
    |> List.first()
  end

  def query(station_id, _args) do
    list_fields()
    |> Enum.join(", ")
    |> (&"SELECT time, #{&1} FROM datas WHERE station_id = '#{station_id}' ORDER BY time DESC").()
    |> parse_result()
  end

  defp parse_result(query) do
    with %{results: [%{series: [data | _]} | _]} <- Connection.query(query) do
      columns = data.columns |> Enum.map(&String.to_atom/1)
      data.values |> Enum.map(&parse_data(columns, &1))
    end
  end

  defp list_fields() do
    @fields
    |> Enum.map(&Atom.to_string/1)
  end

  defp parse_data(col, val) do
    [col, val] |> List.zip() |> Map.new()
  end
end
