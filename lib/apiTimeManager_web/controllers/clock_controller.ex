defmodule ApiTimeManagerWeb.ClockController do
  use ApiTimeManagerWeb, :controller
  import Ecto.Query

  defmodule DataBase do
    def createClock(changeset, userID, conn) do
      if changeset.valid? do
        ApiTimeManager.Repo.insert(changeset)
        renderONE(conn, (ApiTimeManager.Repo.get_by!(ApiTimeManager.Clock, user_id: userID)))
      else
        conn |> put_status(400) |> html("")
      end
    end
  end

  def index(conn, %{"userID" => userID}) do
    renderMANY(conn, (ApiTimeManager.Repo.all(from clock in ApiTimeManager.Clock, where: clock.user_id == ^userID)))
  end

  def create(conn, %{"userID" => userID}) do
    time = NaiveDateTime.utc_now
    user = ApiTimeManager.Repo.preload(ApiTimeManager.Repo.all(from user in ApiTimeManager.User, where: user.id == ^userID), :clocks)

    if List.last(List.last(user).clocks) !== nil && List.last(List.last(user).clocks).status == true do

      #If clock exist and is in progress, create workingtime
      clockOut(conn, (List.last(List.last(user).clocks)))

    else

      #If not exist clock for this user, create clock
      DataBase.createClock(ApiTimeManager.Clock.changeset(%ApiTimeManager.Clock{}, %{user_id: userID, time: time, status: true}), userID, conn)

    end
  end
end
