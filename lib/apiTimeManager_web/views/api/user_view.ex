defmodule ApiTimeManagerWeb.UserView do
  use ApiTimeManagerWeb, :view
  alias ApiTimeManagerWeb.UserView

  def render("index.json", %{data: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{data: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    if user.team !== nil do
      %{
        id: user.id,
        username: user.username,
        email: user.email,
        team: %{
          name: user.team.name,
          id: user.team.id,
          inserted_at: user.team.inserted_at,
          updated_at: user.team.updated_at,
        },
        inserted_at: user.inserted_at,
        updated_at: user.updated_at
      }
    else
      %{
        id: user.id,
        username: user.username,
        email: user.email,
        team_id: user.team_id,
        inserted_at: user.inserted_at,
        updated_at: user.updated_at
      }
    end
  end

  def render("jwt.json", %{data: data}) do
    jwt = data["token"]
    user = data["user"]
    
    if user.team !== nil do

      %{
        jwt: jwt,
        user: %{
          id: user.id,
          username: user.username,
          email: user.email,
          team: %{
            name: user.team.name,
            id: user.team.id,
            inserted_at: user.team.inserted_at,
            updated_at: user.team.updated_at,
          },
          inserted_at: user.inserted_at,
          updated_at: user.updated_at
        }
      }

    else

      %{
        jwt: jwt,
        user: %{
          id: user.id,
          username: user.username,
          email: user.email,
          team_id: user.team_id,
          inserted_at: user.inserted_at,
          updated_at: user.updated_at
        }
      }

    end
  end
end