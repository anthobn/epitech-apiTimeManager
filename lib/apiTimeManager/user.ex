defmodule ApiTimeManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    has_many :clocks, ApiTimeManager.Clock
    has_many :workingtimes, ApiTimeManager.WorkingTime
    has_many :roles, ApiTimeManager.Role

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
