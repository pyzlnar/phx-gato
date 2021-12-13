defmodule GatoWeb.GameController do
  use GatoWeb, :controller
  alias Gato.Game.Browser

  def index(conn, params) do
    games = Browser.get_recent_games
    render(conn, "index.html", games: games)
  end
end
