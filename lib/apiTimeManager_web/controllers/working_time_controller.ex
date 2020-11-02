defmodule ApiTimeManagerWeb.WorkingTimeController do
  use ApiTimeManagerWeb, :controller
  import Ecto.Query

  defmodule DataBase do
    def createWorkingTime(time, clock, userID, conn) do

      {userID, _} = Integer.parse(userID)

      startHour = NaiveDateTime.truncate(clock.time, :second)
      endHour = NaiveDateTime.truncate(time, :second)
      wt = %ApiTimeManager.WorkingTime{user_id: userID, start: startHour, end: endHour}

      if wt do
        ApiTimeManager.Repo.insert(wt)
        wtBDD = ApiTimeManager.Repo.all(from wt in ApiTimeManager.WorkingTime, where: wt.user_id == ^userID, where: wt.start == ^startHour, where: wt.end == ^endHour)
        case wtBDD do
          nil -> conn |> put_status(404) |> html("")
          _ -> render(conn, "show_one.json", workingtime: List.first(wtBDD))
        end

      else
        conn |> put_status(400) |> html("")
      end
    end
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"userID" => userID}) do
    time = NaiveDateTime.utc_now
    user = ApiTimeManager.Repo.preload(ApiTimeManager.Repo.get(ApiTimeManager.User, userID), :clocks)
    
    Enum.each user.clocks, fn clock -> 
      if clock.status == true do
        DataBase.createWorkingTime(time, clock, userID, conn)
      end
    end
  end
end