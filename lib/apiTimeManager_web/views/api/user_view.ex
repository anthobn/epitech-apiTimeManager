defmodule ApiTimeManagerWeb.UserView do
  use ApiTimeManagerWeb, :view

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

end