defmodule ApiTimeManagerWeb.WorkingTimeView do
  use ApiTimeManagerWeb, :view

  def render("show_one.json", %{workingtime: workingtime}) do
    render_one(workingtime, ApiTimeManagerWeb.WorkingTimeView, "workingtime.json")
  end
  
  def render("show_many.json", %{workingtime: workingtime}) do
    render_many(workingtime, ApiTimeManagerWeb.WorkingTimeView, "workingtime.json")
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    IO.puts('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&')
    IO.inspect workingtime
    %{
      start: workingtime.start,
      end: workingtime.end,
      inserted_at: workingtime.inserted_at,
      updated_at: workingtime.updated_at
    }
  end

end