defmodule GatoWeb.GameView do
  use GatoWeb, :view

  def pretty_state(state) do
    state
    |> Atom.to_string
    |> String.capitalize
  end

  def pretty_winner(:finished, nil), do: "Stalemate"
  def pretty_winner(_, nil),         do: nil
  def pretty_winner(_, winner),      do: "Player #{winner}"

  def pretty_played_at(played_at) do
    played_at
    |> Date.to_iso8601
  end
end
