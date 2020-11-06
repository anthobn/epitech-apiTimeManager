defmodule ApiTimeManagerWeb.TeamController do
  use ApiTimeManagerWeb, :controller
  import Ecto.Query

  def index(conn, _params) do
    renderMANY(conn, (ApiTimeManager.Repo.all(ApiTimeManager.Team)))
  end

  def create(conn, %{"team" => team_params}) do

    ApiTimeManager.Repo.insert(%ApiTimeManager.Team{name: team_params["name"]})
    team = ApiTimeManager.Repo.get_by(ApiTimeManager.Team, [name:  team_params["name"]])
    team = ApiTimeManager.Repo.preload(team, :users)

    renderONE(conn, team)

  end
end
