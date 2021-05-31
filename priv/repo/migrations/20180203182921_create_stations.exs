defmodule Weather.Repo.Migrations.CreateStations do
  use Ecto.Migration

  def change do
    create table(:stations) do
      add :name, :string, null: false
      add :owner_id, references(:users), null: false

      timestamps()
    end
  end
end
