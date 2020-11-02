defmodule ApiTimeManager.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime
    belongs_to :user, ApiTimeManager.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
    |> unique_constraint(:id, name: :clocks_pkey)
  end

  def startTime(user) do
    #Create new entry with clock and current status = true
  end

  def endTime(user) do
    #Save clock

    #Change current status to false

    #Save working time
  end

  def saveWorkingTime do
    #Calc hours
    #self

    #Create new entry of workingTime with values
  end
end
