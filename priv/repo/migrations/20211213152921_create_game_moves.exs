defmodule Gato.Repo.Migrations.CreateGameMoves do
  use Ecto.Migration

  def change do
    create table(:game_moves) do
      add :game_id, references(:games), null: false

      add :number, :int
      add :move,   :"int[]", null: false, default: "{}"

      timestamps()
    end
  end
end
