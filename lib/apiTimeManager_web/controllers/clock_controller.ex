defmodule ApiTimeManagerWeb.ClockController do
  use ApiTimeManagerWeb, :controller
  import Ecto.Query

  defmodule DataBase do
    def createClock(conn, userID) do
    {userID, _} = Integer.parse(userID)
    time = NaiveDateTime.truncate((NaiveDateTime.utc_now), :second)

    ApiTimeManager.Repo.insert(%ApiTimeManager.Clock{user_id: userID, time: time, status: true})

    clock = ApiTimeManager.Repo.get_by(ApiTimeManager.Clock, [user_id: userID, time: time])
    clock = ApiTimeManager.Repo.preload(clock, :user)

    renderONE(conn, clock)
    end
  end

  def index(conn, %{"userID" => userID}) do
    renderMANY(conn, (ApiTimeManager.Repo.all(from clock in ApiTimeManager.Clock, where: clock.user_id == ^userID)))
  end

  def create(conn, %{"userID" => userID}) do
    user = ApiTimeManager.Repo.preload(ApiTimeManager.Repo.get(ApiTimeManager.User, userID), :clocks)

    if List.last(user.clocks) !== nil && List.last(user.clocks).status == true do

      #If clock exist and is in progress, create workingtime
      clockOut(conn, (List.last(user.clocks)))

    else

      #If not exist clock for this user, create clock
      DataBase.createClock(conn, userID)

    end
  end
end
