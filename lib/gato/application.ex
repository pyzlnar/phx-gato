defmodule Gato.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    start_ets_table()
    start_supervisor()
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GatoWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # ----

  def start_ets_table do
    Gato.Game.MoveCache.new_table
  end

  def start_supervisor do
    children = [
      # Start the Ecto repository
      Gato.Repo,
      # Start the Telemetry supervisor
      GatoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gato.PubSub},
      # Start the Endpoint (http/https)
      GatoWeb.Endpoint
      # Start a worker by calling: Gato.Worker.start_link(arg)
      # {Gato.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gato.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
