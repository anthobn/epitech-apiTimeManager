defmodule ApiTimeManager.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :admin, :boolean, default: false
    field :name, :string
    belongs_to :user, ApiTimeManager.User

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :admin])
    |> validate_required([:name, :admin])
  end
end
