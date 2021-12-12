defmodule Gato.Game.Play do
  alias TicTacToe.Game

  def run(id, position) when is_binary(position) do
    with {_,_} = move                     <- parse_position(position),
         {state, %Game{} = game}
           when state in [:ok, :finished] <- submit_move(id, move),
         {:ok, _}                         <- save_game_if_finished(state, game)
    do
      {:ok, game}
    end
  end
  def run(_, _), do: {:error, [pos: "pos has to be a binary"]}

  defp parse_position(position) do
    position
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end

  defp submit_move(id, move) do
    TicTacToe.play(id, move)
  end

  defp save_game_if_finished(state, game) do
    case state do
      :ok ->
        {:ok, :not_persisted}
      :finished ->
        {:ok, :persisted}
    end
  end
end
