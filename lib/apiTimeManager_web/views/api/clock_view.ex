defmodule ApiTimeManagerWeb.ClockView do
  use ApiTimeManagerWeb, :view

  def render("show_one.json", %{clock: clock}) do
    render_one(clock, ApiTimeManagerWeb.ClockView, "clock.json")
  end
  
  def render("show_many.json", %{clock: clock}) do
    render_many(clock, ApiTimeManagerWeb.ClockView, "clock.json")
  end

  def render("clock.json", %{clock: clock}) do
    %{
      time: clock.time,
      status: clock.status,
      inserted_at: clock.inserted_at,
      updated_at: clock.updated_at
    }
  end

end