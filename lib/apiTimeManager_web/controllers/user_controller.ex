defmodule ApiTimeManagerWeb.UserController do
  use ApiTimeManagerWeb, :controller

  alias ApiTimeManager.Guardian

  action_fallback ApiTimeManagerWeb.FallbackController

  def sign_in(conn, %{"user" => user_params}) do
    case ApiTimeManager.Accounts.token_sign_in(user_params["email"], user_params["password"]) do
      {:ok, token, _claims} ->
        user = ApiTimeManager.Repo.get_by(ApiTimeManager.User, email: user_params["email"])
        user = ApiTimeManager.Repo.preload(user, :team)

        data = %{"user" => user, "token" => token}
        conn |> render("jwt.json", data: data)
      _ ->
        {:error, :unauthorized}
    end
  end
  
  def index(conn, params) do

    if Map.has_key?(params, "email") && Map.has_key?(params, "username") do
      user = ApiTimeManager.Repo.get_by(ApiTimeManager.User, [email: params["email"], username: params["username"]])
      user = ApiTimeManager.Repo.preload(user, :team)
      renderONE(conn, user)
    else
      user = ApiTimeManager.Repo.all(ApiTimeManager.User)
      user = ApiTimeManager.Repo.preload(user, :team)
      renderMANY(conn, user)
    end
  end

  def show(conn, %{"id" => userID}) do
    user =  ApiTimeManager.Repo.get(ApiTimeManager.User, userID)
    user = ApiTimeManager.Repo.preload(user, :team)

    renderONE(conn, user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %ApiTimeManager.User{} = user} <- ApiTimeManager.Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
          user = ApiTimeManager.Repo.preload(user, :team)
          data = %{"user" => user, "token" => token}
          conn |> render("jwt.json", data: data)
    end
  end

  def update(conn, %{"user" => user_params, "id" => userID}) do
    {teamId, _} = Integer.parse(user_params["team_id"])

    user = ApiTimeManager.Repo.get!(ApiTimeManager.User, userID)

    changeset = ApiTimeManager.User.changeset(user, %{email: user_params["email"], username: user_params["username"], team_id: teamId, password: user_params["password"], password_confirmation: user_params["password_confirmation"]})

    if changeset.valid? do

      ApiTimeManager.Repo.update(changeset)

      user = ApiTimeManager.Repo.get!(ApiTimeManager.User, userID)
      user = ApiTimeManager.Repo.preload(user, :team)

      renderONE(conn, user)
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