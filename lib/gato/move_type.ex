defmodule Gato.Schema.MoveType do
  @behaviour Ecto.Type

  @impl Ecto.Type
  def cast({x,y} = move) when x in 0..2 and y in 0..2 do
    {:ok, move}
  end
  def cast(_), do: :error

  @impl Ecto.Type
  def dump(move), do: {:ok, Tuple.to_list(move)}

  @impl Ecto.Type
  def embed_as(term), do: term

  @impl Ecto.Type
  def equal?(t1, t2), do: t1 == t2

  @impl Ecto.Type
  def load(list), do: {:ok, List.to_tuple(list)}

  @impl Ecto.Type
  def type, do: :"int[]"
end
