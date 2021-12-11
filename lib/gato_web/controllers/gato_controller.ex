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
    case play_game(conn, params) do
      {:ok, conn} ->
        conn
        |> render("show.html", game: conn.assigns.game)
      error ->
        Logger.error inspect(error)
        conn
        |> put_flash(:error, "Something went wrong")
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

  defp play_game(conn, params) do
    with pos when is_binary(pos)          <- params["form"]["pos"],
         {_,_}   = move                   <- parse_pos(pos),
         {state, %Game{} = game}
           when state in [:ok, :finished] <- TicTacToe.play(params["id"], move)
    do
      {:ok, assign(conn, :game, game)}
    end
  end

  defp parse_pos(pos) do
    pos
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end
end
