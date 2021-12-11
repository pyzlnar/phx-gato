defmodule Gato.Repo do
  use Ecto.Repo,
    otp_app: :gato,
    adapter: Ecto.Adapters.Postgres
end
