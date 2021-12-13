defmodule Gato.Game.MoveCache do
  @table :move_cache

  def new_table(opts \\ ~W[public bag named_table]a) do
    :ets.new(@table, opts)
  end

  def get_moves(name \\ @table, id) do
    :ets.lookup(name, id)
    |> Enum.map(&elem(&1, 1))
  end

  def add_move(name \\ @table, id, {_,_} = move) do
    :ets.insert(name, {id, move})
  end

  def cleanup(name \\ @table, id) do
    :ets.delete(name, id)
  end
end
