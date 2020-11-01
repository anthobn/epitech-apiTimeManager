defmodule ApiTimeManager.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :apiTimeManager,
    module: ApiTimeManager.Guardian,
    error_handler: ApiTimeManager.AuthErrorHandler
  
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end