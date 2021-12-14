defmodule GatoWeb.GameController do
  use GatoWeb, :controller
  alias Gato.Game.Browser

  def index(conn, params) do
    games = Browser.get_recent_games
    render(conn, "index.html", games: games)
  end

  def show(conn, %{"id" => id}) do
    game = Browser.get_game_with_moves(id)
    render(conn, "show.html", game: game)
  end
end
