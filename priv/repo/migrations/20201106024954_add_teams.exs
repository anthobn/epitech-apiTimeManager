defmodule ApiTimeManager.Repo.Migrations.AddTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string, null: false

      timestamps()
    end
    alter table(:users) do
      add :team_id, references(:teams), null: true
    end

    create unique_index(:teams, [:name])

  end
end
