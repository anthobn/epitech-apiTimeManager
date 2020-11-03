defmodule ApiTimeManagerWeb.Controllers.Helpers do
  import Plug.Conn
  import Phoenix.Controller

  def renderONE(conn, data) do
    case data do
      nil -> conn |> put_status(404) |> html("")
      _ -> render conn, "show.json", data: data
    end
  end

  def renderMANY(conn, data) do
    case data do
      nil -> conn |> put_status(404) |> html("")
      _ -> render conn, "index.json", data: data
    end
  end

  def renderStatus(conn, status) do
    conn |> put_status(status) |> html("")
  end

  def clockOut(conn, clock) do
    clock = ApiTimeManager.Repo.preload(clock, :user)

    #Update clock to false
    ApiTimeManager.Repo.update(ApiTimeManager.Clock.changeset(clock, %{status: false}))
    createWorkingTime(conn, clock.user.id, clock.time, NaiveDateTime.utc_now)
  end

  def createWorkingTime(conn, userID, timeStart, timeEnd) do
    timeStart = NaiveDateTime.truncate(timeStart, :second)
    timeEnd = NaiveDateTime.truncate(timeEnd, :second)

    ApiTimeManager.Repo.insert(%ApiTimeManager.WorkingTime{user_id: userID, start: timeStart, end: timeEnd})

    workingtime = ApiTimeManager.Repo.get_by(ApiTimeManager.WorkingTime, [user_id: userID, start: timeStart, end: timeEnd])
    workingtime = ApiTimeManager.Repo.preload(workingtime, :user)

    render(conn, ApiTimeManagerWeb.WorkingTimeView, "show.json", data: workingtime)
  end
  
  #default
  
  def render_blank(conn) do
    conn
    |> send_resp(204, "")
  end
  
  def render_error(conn, status, opts) do
    conn 
    |> put_status(status)
    |> render(MyApp.ErrorView, "#{status}.json", opts)
  end

  def ensure_current_user(conn, _) do
    case conn.assigns.current_user do
      nil -> render_error(conn, 401, message: "unauthorized")
      current_user -> conn
    end
  end

end