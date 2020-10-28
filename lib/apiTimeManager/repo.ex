defmodule ApiTimeManager.Repo do
  use Ecto.Repo,
    otp_app: :apiTimeManager,
    adapter: Ecto.Adapters.Postgres
end
