defmodule ApiTimeManagerWeb.UserController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Guardian

  action_fallback ApiTimeManagerWeb.FallbackController

  def sign_in(conn, %{"user" => user_params}) do
    case ApiTimeManager.Accounts.token_sign_in(user_params["email"], user_params["password"]) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end
  
  def index(conn, params) do

    if Map.has_key?(params, "email") && Map.has_key?(params, "username") do
      renderONE(conn, ApiTimeManager.Repo.get_by(ApiTimeManager.User, [email: params["email"], username: params["username"]]))
    else
      renderMANY(conn, ApiTimeManager.Repo.all(ApiTimeManager.User))
    end
  end

  def show(conn, %{"id" => userID}) do
    renderONE(conn, ApiTimeManager.Repo.get(ApiTimeManager.User, userID))
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %ApiTimeManager.User{} = user} <- ApiTimeManager.Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> render("jwt.json", jwt: token)
    end
  end

@oldCreateMethodWithTuto """
  def create(conn, %{"user" => user_params}) do
    with {:ok, %ApiTimeManager.User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

"""

@oldCreateMethod """
  def create(conn, %{"email" => email, "username" => username}) do
    changeset = ApiTimeManager.User.changeset(%ApiTimeManager.User{}, %{username: username, email: email})

    if changeset.valid? do
      ApiTimeManager.Repo.insert(changeset)
      renderONE(conn, ApiTimeManager.Repo.get_by(ApiTimeManager.User, [email: email, username: username]))
    else
      renderStatus(conn, 404)
    end
  end
"""

  def update(conn, %{"id" => userID, "email" => email, "username" => username}) do
    user = ApiTimeManager.Repo.get!(ApiTimeManager.User, userID)

    changeset = ApiTimeManager.User.changeset(user, %{email: email, username: username})

    if changeset.valid? do

      ApiTimeManager.Repo.update(changeset)

      renderONE(conn, ApiTimeManager.Repo.get!(ApiTimeManager.User, userID))
    else
      renderStatus(conn, 404)
    end
  end

  def delete(conn, %{"id" => userID}) do
    user = ApiTimeManager.Repo.get!(ApiTimeManager.User, userID)

    if user do
      ApiTimeManager.Repo.delete(user)
      renderStatus(conn, 200)
    else
      renderStatus(conn, 404)
    end
  end
end