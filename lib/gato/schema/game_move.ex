defmodule Gato.Schema.GameMove do
  use Ecto.Schema
  alias Gato.Schema

  schema "game_moves" do
    field :number, :integer
    field :move,   Schema.MoveType

    belongs_to :game, Schema.Game

    timestamps()
  end

  def insert_list(%Schema.Game{id: game_id}, moves) when is_list(moves) do
    moves
    |> Stream.with_index(1)
    |> Stream.map(&to_keyword(&1, get_common_fields(game_id)))
    |> Enum.to_list
  end

  defp get_common_fields(game_id) do
    timestamp = NaiveDateTime.utc_now |> NaiveDateTime.truncate(:second)
    [game_id: game_id, inserted_at: timestamp, updated_at: timestamp]
  end

  defp to_keyword({move, number}, common_fields) do
    [{:number, number}, {:move, move} | common_fields]
  end
end
