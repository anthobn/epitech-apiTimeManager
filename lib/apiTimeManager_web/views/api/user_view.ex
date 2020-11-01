defmodule ApiTimeManagerWeb.UserView do
  use ApiTimeManagerWeb, :view
  alias ApiTimeManagerWeb.UserView

@oldUserShow """
  def render("show_one.json", %{user: user}) do
    render_one(user, ApiTimeManagerWeb.UserView, "user.json")
  end

  def render("show_many.json", %{users: users}) do
    render_many(users, ApiTimeManagerWeb.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

"""

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      password_hash: user.password_hash}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

end