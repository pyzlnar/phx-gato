defmodule Gato.Schema.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :game_id, Ecto.UUID
    field :board,   Gato.Schema.BoardType
    field :player,  :integer
    field :state,   Ecto.Enum, values: ~W[initial progress finished]a
    field :winner,  :integer

    timestamps()
  end

  def new do
    %Gato.Schema.Game{}
  end

  def insert_changeset(game_id, %TicTacToe.Game{} = game) do
    new()
    |> cast(from_game(game), ~W[board player state winner]a)
    |> put_change(:game_id, game_id)
    |> validate_required(~W[game_id state]a)
  end

  defp from_game(%TicTacToe.Game{} = game), do: game |> Map.from_struct
end
