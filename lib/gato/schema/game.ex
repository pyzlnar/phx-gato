defmodule Gato.Schema.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gato.Schema

  schema "games" do
    field :uuid,   Ecto.UUID
    field :board,  Schema.BoardType
    field :player, :integer
    field :state,  Ecto.Enum, values: ~W[initial progress finished]a
    field :winner, :integer

    has_many :game_moves, Schema.GameMove

    timestamps()
  end

  def new do
    %__MODULE__{}
  end

  def insert_changeset(game_id, %TicTacToe.Game{} = game) do
    new()
    |> cast(from_game(game), ~W[board player state winner]a)
    |> put_change(:uuid, game_id)
    |> validate_required(~W[uuid state]a)
  end

  defp from_game(%TicTacToe.Game{} = game), do: game |> Map.from_struct
end
