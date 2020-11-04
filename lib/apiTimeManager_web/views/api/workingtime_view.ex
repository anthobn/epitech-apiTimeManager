defmodule ApiTimeManagerWeb.WorkingTimeView do
  use ApiTimeManagerWeb, :view

  def render("show.json", %{data: workingtime}) do
    %{workingtime: render_one(workingtime, ApiTimeManagerWeb.WorkingTimeView, "workingtime.json")}
  end
  
  def render("index.json", %{data: workingtime}) do
    %{workingtimes: render_many(workingtime, ApiTimeManagerWeb.WorkingTimeView, "workingtime.json")}
  end

  def render("workingtime.json", workingtime) do
    workingtime = workingtime.working_time
    %{
      start: workingtime.start,
      end: workingtime.end,
      inserted_at: workingtime.inserted_at,
      updated_at: workingtime.updated_at,
      user: %{
        id: workingtime.user.id,
        username: workingtime.user.username,
        email: workingtime.user.email
      }
    }
  end

end