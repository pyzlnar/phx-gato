defmodule Gato.Game.Browser do
  import Ecto.Query
  alias Gato.{Repo, Schema}

  def get_recent_games do
    from(f in Schema.Game, limit: 50, order_by: [desc: :updated_at])
    |> Repo.all
  end

  def exists?(uuid) do
    uuid
    |> by_uuid
    |> Repo.exists?
  end

  def get_game_with_moves(uuid) do
    uuid
    |> by_uuid
    |> Repo.one
    |> Repo.preload(moves: ordered_moves())
  end

  # ---

  defp by_uuid(uuid) do
    from g in Schema.Game, where: g.uuid == ^uuid
  end

  defp ordered_moves do
    from m in Schema.GameMove,
      select:   [:move],
      order_by: [asc: m.number]
  end
end
