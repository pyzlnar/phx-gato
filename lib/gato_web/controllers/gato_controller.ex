defmodule GatoWeb.GatoController do
  use GatoWeb, :controller
  alias TicTacToe.Game
  require Logger

  plug :set_game when action in ~W[show update]a

  # GET /gato
  def index(conn, _params) do
    render(conn, "index.html")
  end

  # POST /gato
  def create(conn, _params) do
    game = Ecto.UUID.generate |> TicTacToe.new_game
    redirect(conn, to: Routes.gato_path(conn, :show, game))
  end

  def show(conn, _params) do
    render(conn, "show.html", game: conn.assigns.game)
  end

  def update(conn, params) do
    case Gato.Game.Play.run(params["id"], params["form"]["pos"]) do
      {:ok, game} ->
        conn
        |> render("show.html", game: game)
      error ->
        Logger.error "Error playing #{inspect(error)}"
        conn
        |> put_flash(:error, "Something went wrong #{inspect(error)}")
        |> render("show.html", game: conn.assigns.game)
    end
  end

  # ----

  defp set_game(conn, _) do
    case TicTacToe.get_game(conn.params["id"]) do
      {:ok, %Game{} = game} ->
        conn
        |> assign(:game, game)
      _ ->
        conn
        |> put_flash(:error, "Game no longer exists")
        |> redirect(to: Routes.gato_path(conn, :index))
        |> halt
    end
  end
end
