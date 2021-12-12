defmodule Gato.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :game_id, :uuid,   null: false
      add :board,   :jsonb,  null: false, default: "[]"
      add :player,  :integer
      add :state,   :string
      add :winner,  :integer

      timestamps()
    end

    create unique_index(:games, :game_id)
  end
end
