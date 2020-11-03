defmodule ApiTimeManagerWeb.WorkingTimeController do
  use ApiTimeManagerWeb, :controller
  import Ecto.Query

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"userID" => userID, "workingtime" => wt_params}) do
    startDate = wt_params["startDate"]
    startTime = wt_params["startTime"]

    startDateTime = NaiveDateTime.from_iso8601(startDate <> startTime)
    {_, startDateTime} = startDateTime

    endDate = wt_params["endDate"]
    endTime = wt_params["endTime"]

    endDateTime = NaiveDateTime.from_iso8601(endDate <> endTime)
    {_, endDateTime} = endDateTime

    IO.puts(startDateTime)

    createWorkingTime(conn, userID, startDateTime, endDateTime)
  end
end