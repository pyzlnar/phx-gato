defmodule Gato.Game.Browser do
  import Ecto.Query
  alias Gato.{Repo, Schema}

  def get_recent_games do
    from(f in Schema.Game, limit: 50, order_by: [desc: :updated_at])
    |> Repo.all
  end
end
