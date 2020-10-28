defmodule ApiTimeManagerWeb.Controllers.Helpers do
  import Plug.Conn
  import Phoenix.Controller

  def renderONE(conn, data) do
    case data do
      nil -> conn |> put_status(404) |> html("")
      _ -> render conn, "show_one.json", user: data
    end
  end

  def renderMANY(conn, data) do
    case data do
      nil -> conn |> put_status(404) |> html("")
      _ -> render conn, "show_many.json", users: data
    end
  end

  def renderStatus(conn, status) do
    conn |> put_status(status) |> html("")
  end


  
  #default
  
  def render_blank(conn) do
    conn
    |> send_resp(204, "")
  end
  
  def render_error(conn, status, opts) do
    conn 
    |> put_status(status)
    |> render(MyApp.ErrorView, "#{status}.json", opts)
  end

  def ensure_current_user(conn, _) do
    case conn.assigns.current_user do
      nil -> render_error(conn, 401, message: "unauthorized")
      current_user -> conn
    end
  end

end