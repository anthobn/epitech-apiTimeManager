defmodule ApiTimeManager.User do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  
  defenum RolesEnum, :role, [:employee, :manager, :admin]

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :role, RolesEnum, default: "employee"

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :clocks, ApiTimeManager.Clock
    has_many :workingtimes, ApiTimeManager.WorkingTime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :password_confirmation, :role])
    |> validate_required([:username, :email, :password, :password_confirmation, :role])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end

end
