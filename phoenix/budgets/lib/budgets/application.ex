defmodule Budgets.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    source = goth_source()
    children = [
      # Start the Telemetry supervisor
      BudgetsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Budgets.PubSub},
      # Start the Endpoint (http/https)
      BudgetsWeb.Endpoint,
      # Start a worker by calling: Budgets.Worker.start_link(arg)
      # {Budgets.Worker, arg}

      {Goth, name: Budgets.Goth, source: source}
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

  defp goth_source() do
    env_name = "GOOGLE_APPLICATION_CREDENTIALS"

    default_path =
      "~/.config/gcloud/application_default_credentials.json"
      |> Path.expand

    {type, filename} = case {System.get_env(env_name), File.regular?(default_path)} do
      {filename, _} when is_binary(filename) -> {:credentials, filename}
      {_, true} -> {:refresh_token, default_path}
      _ -> {:error, "Credentials file not found"}
    end

    {type, filename |> File.read!() |> Jason.decode!(), [] }
  end

end
