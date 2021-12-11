defmodule GatoWeb.GatoView do
  use GatoWeb, :view

  alias TicTacToe.Game

  def pos_to_string(game, pos) do
    move_to_string(game, pos, game.board[pos])
  end

  def move_to_string(_, _, 1), do: "X"
  def move_to_string(_, _, 2), do: "0"
  def move_to_string(%Game{state: :finished}, _, nil), do: ""
  def move_to_string(_, {x,y}, nil) do
    radio_button(:form, :pos, "#{x},#{y}")
  end
end
