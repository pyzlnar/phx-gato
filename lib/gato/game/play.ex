defmodule Gato.Game.Play do
  alias Gato.Game.MoveCache
  alias Gato.Repo
  alias Gato.Schema

  def run(id, position) when is_binary(position) do
    with {_,_} = move                     <- parse_position(position),
         {state, %TicTacToe.Game{} = game}
           when state in [:ok, :finished] <- submit_move(id, move),
         true                             <- cache_move(id, move),
         {:ok, _}                         <- save_game_if_finished(state, id, game)
    do
      {:ok, game}
    end
  end
  def run(_, _), do: {:error, [pos: "pos has to be a binary"]}

  # -- Helpers -- #

  defp parse_position(position) do
    position
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end

  defp submit_move(id, move) do
    TicTacToe.play(id, move)
  end

  defp save_game_if_finished(state, id, game) do
    case state do
      :ok       -> {:ok, :not_persisted}
      :finished -> save_game(id, game)
    end
  end

  defp save_game(id, game) do
    with {:ok, game_record}             <- insert_game(id, game),
         [_|_] = moves                  <- fetch_moves(id),
         {n, _moves_records} when n > 1 <- insert_moves(game_record, moves),
         true                           <- cache_cleanup(id),
         do: {:ok, game_record}
  end

  defp insert_game(id, game) do
    Schema.Game.insert_changeset(id, game)
    |> Repo.insert
  end

  defp insert_moves(%Schema.Game{} = record, moves) do
    Schema.GameMove
    |> Repo.insert_all(Schema.GameMove.insert_list(record, moves))
  end

  defp cache_move(id, move) do
    MoveCache.add_move(id, move)
  end

  defp fetch_moves(id) do
    MoveCache.get_moves(id)
  end

  defp cache_cleanup(id) do
    MoveCache.cleanup(id)
  end
end
