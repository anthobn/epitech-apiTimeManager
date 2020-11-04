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
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      password_hash: user.password_hash,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  def render("jwt.json", %{data: data}) do
    jwt = data["token"]
    user = data["user"]
    IO.inspect(user)
    %{
      jwt: jwt,
      user: %{
        id: user.id,
        username: user.username,
        email: user.email,
        inserted_at: user.inserted_at,
        updated_at: user.updated_at
      }
    }
  end

end