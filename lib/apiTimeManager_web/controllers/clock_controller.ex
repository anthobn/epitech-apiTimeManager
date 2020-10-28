defmodule ApiTimeManagerWeb.ClockController do
  use ApiTimeManagerWeb, :controller
  import Ecto.Query

  defmodule DataBase do
    def updateBDD(changeset, userID, conn) do
      if changeset.valid? do
        ApiTimeManager.Repo.insert(changeset)
        clockBDD = ApiTimeManager.Repo.get_by!(ApiTimeManager.Clock, user_id: userID)
        
        case clockBDD do
          nil -> conn |> put_status(404) |> html("")
          _ -> render conn, "show_one.json", clock: clockBDD
        end

      else
        conn |> put_status(400) |> html("")
      end
    end
  end

  def index(conn, %{"userID" => userID}) do
    clock = ApiTimeManager.Repo.all(from clock in ApiTimeManager.Clock, where: clock.user_id == ^userID)

    case clock do
      nil -> conn |> put_status(404) |> html("")
      _ -> render conn, "show_many.json", clock: clock
     end
  end

  def create(conn, %{"userID" => userID}) do
    time = NaiveDateTime.utc_now
    user = ApiTimeManager.Repo.preload(ApiTimeManager.Repo.all(from user in ApiTimeManager.User, where: user.id == ^userID), :clocks)

    if List.last(user).clocks !== nil && List.last(List.last(user).clocks).status == true do
    #If clock is in progress
    #create workingtime
    conn |> put_status(502) |> html("")
    else
      DataBase.updateBDD(ApiTimeManager.Clock.changeset(%ApiTimeManager.Clock{}, %{user_id: userID, time: time, status: true}), userID, conn)
    end
  end
end
