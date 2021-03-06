defmodule ApiTimeManagerWeb.ClockView do
  use ApiTimeManagerWeb, :view

  def render("show.json", %{data: clock}) do
    %{clock: render_one(clock, ApiTimeManagerWeb.ClockView, "clock.json")}
  end
  
  def render("index.json", %{data: clock}) do
    %{clocks: render_many(clock, ApiTimeManagerWeb.ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{
      time: clock.time,
      status: clock.status,
      inserted_at: clock.inserted_at,
      updated_at: clock.updated_at,
      user: %{
        id: clock.user.id,
        username: clock.user.username,
        email: clock.user.email
      }
    }
  end

end