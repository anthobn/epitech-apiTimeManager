defmodule ApiTimeManagerWeb.UserController do
  use ApiTimeManagerWeb, :controller

  def index(conn, %{"email" => email, "username" => username}) do
    user = ApiTimeManager.Repo.get_by(ApiTimeManager.User, [email: email, username: username])
    case user do
      nil -> conn |> put_status(404) |> html("")
      _ -> render conn, "show.json", user: user
    end
  end

  def show(conn, %{"id" => userID}) do
    user = ApiTimeManager.Repo.get(ApiTimeManager.User, userID)
    case user do
      nil -> conn |> put_status(404) |> html("")
      _ -> render conn, "show.json", user: user
     end
  end

  def create(conn, %{"email" => email, "username" => username}) do
    changeset = ApiTimeManager.User.changeset(%ApiTimeManager.User{}, %{username: username, email: email})

    if changeset.valid? do
      ApiTimeManager.Repo.insert(changeset)
      userBDD = ApiTimeManager.Repo.get_by(ApiTimeManager.User, [email: email, username: username])
      
      case userBDD do
        nil -> conn |> put_status(404) |> html("")
        _ -> render conn, "show.json", user: userBDD
       end

    else
      conn |> put_status(400) |> html("")
    end
  end

  def update(conn, %{"id" => userID, "email" => email, "username" => username}) do
    user = ApiTimeManager.Repo.get!(ApiTimeManager.User, userID)

    changeset = ApiTimeManager.User.changeset(user, %{email: email, username: username})

    if changeset.valid? do

      ApiTimeManager.Repo.update(changeset)

      userBDD = ApiTimeManager.Repo.get!(ApiTimeManager.User, userID)
      
      case userBDD do
        nil -> conn |> put_status(404) |> html("")
        _ -> render conn, "show.json", user: userBDD
       end
    else
      conn |> put_status(400) |> html("")
    end
  end

  def delete(conn, %{"id" => userID}) do
    user = ApiTimeManager.Repo.get!(ApiTimeManager.User, userID)

    if user do
      ApiTimeManager.Repo.delete(user)
      conn |> put_status(200) |> html("")
    else
      conn |> put_status(404) |> html("")
    end

  end
end