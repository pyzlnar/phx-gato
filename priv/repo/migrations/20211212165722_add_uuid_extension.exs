defmodule Gato.Repo.Migrations.AddUuidExtension do
  use Ecto.Migration

  def up do
    execute ~S{CREATE EXTENSION IF NOT EXISTS "uuid-ossp"}
  end

  def down, do: :noop
end
