defmodule ApiTimeManagerWeb.TeamView do
  use ApiTimeManagerWeb, :view

  def render("show.json", %{data: team}) do
    %{team: render_one(team, ApiTimeManagerWeb.TeamView, "team.json")}
  end
  
  def render("index.json", %{data: teams}) do
    %{teams: render_many(teams, ApiTimeManagerWeb.TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name,
      inserted_at: team.inserted_at,
      updated_at: team.updated_at,
    }
  end

end