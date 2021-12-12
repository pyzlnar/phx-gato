defmodule Gato.Schema.BoardType do
  @behaviour Ecto.Type

  @impl Ecto.Type
  def cast(board) when is_map(board), do: {:ok, board}
  def cast(_), do: :error

  @impl Ecto.Type
  def dump(board) when is_map(board) do
    dumped =
      board
      |> Enum.sort
      |> Enum.map(&elem(&1, 1))

    {:ok, dumped}
  end
  def dump(_), do: :error

  @impl Ecto.Type
  def embed_as(term), do: term

  @impl Ecto.Type
  def equal?(t1, t2), do: t1 == t2

  @impl Ecto.Type
  def load(list) do
    loaded =
      for(x <- 0..2, y <- 0..2, do: {x,y})
      |> Enum.zip(list)
      |> Map.new

    {:ok, loaded}
  end

  @impl Ecto.Type
  def type, do: :jsonb
end
