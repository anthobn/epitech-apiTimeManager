defmodule ApiTimeManager.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :time, :naive_datetime, null: false
      add :status, :boolean, default: false, null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
