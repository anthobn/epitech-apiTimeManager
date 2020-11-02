defmodule ApiTimeManagerWeb.UserView do
  use ApiTimeManagerWeb, :view
  alias ApiTimeManagerWeb.UserView

  def render("index.json", %{data: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{data: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      password_hash: user.password_hash,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

end