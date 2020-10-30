defmodule ApiTimeManager.Repo.Migrations.RoleBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:roles) do
      add :user_id, references(:users)
    end
  end
end
