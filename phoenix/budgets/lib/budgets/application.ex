defmodule Budgets.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BudgetsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Budgets.PubSub},
      # Start the Endpoint (http/https)
      BudgetsWeb.Endpoint
      # Start a worker by calling: Budgets.Worker.start_link(arg)
      # {Budgets.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Budgets.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BudgetsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
