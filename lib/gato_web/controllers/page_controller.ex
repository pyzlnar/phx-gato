defmodule GatoWeb.PageController do
  use GatoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
