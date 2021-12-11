defmodule GatoWeb.GatoController do
  use GatoWeb, :controller

  # GET /gato
  def index(conn, _params) do
    render(conn, "index.html")
  end

  # POST /gato
  # TODO Should create a new game
  def create(conn, _params) do
    render(conn, "index.html")
  end
end
