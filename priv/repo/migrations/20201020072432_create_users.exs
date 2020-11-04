defmodule ApiTimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  defenum RolesEnum, :role, [:employee, :manager, :admin]

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :role, RolesEnum.type(), default: "employee"

      timestamps()
    end

  end
end
