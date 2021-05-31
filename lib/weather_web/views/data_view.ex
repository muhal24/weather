defmodule WeatherWeb.DataView do
  use WeatherWeb, :view
  alias WeatherWeb.DataView

  def render("show.json", %{data: data}) do
    %{data: render_one(data, DataView, "data.json")}
  end

  def render("data.json", %{data: data}) do
    %{id: data.id}
  end
end
