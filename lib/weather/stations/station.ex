defmodule Weather.Stations.Station do
  use Ecto.Schema
  import Ecto.Changeset

  alias Weather.Accounts.User
  alias Weather.Stations.Station

  schema "stations" do
    field(:name, :string)

    timestamps()
  end


  @doc false
  def changeset(%Station{} = station, attrs) do
    station
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
