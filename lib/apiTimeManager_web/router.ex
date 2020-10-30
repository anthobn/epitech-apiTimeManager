defmodule ApiTimeManagerWeb.Router do
  use ApiTimeManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
	plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/", ApiTimeManagerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ApiTimeManagerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
	options   "/users", UserController, :options
	get "/users", UserController, :index

    scope "/workingtimes" do
      resources "/", WorkingTimeController, only: [:index, :update, :delete]
      resources "/:userID", WorkingTimeController, only: [:create, :show]
    end

    resources "/clocks/:userID", ClockController, only: [:index, :create]


  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ApiTimeManagerWeb.Telemetry
    end
  end
end
