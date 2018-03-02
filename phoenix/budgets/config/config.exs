# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :budgets,
  ecto_repos: [Budgets.Repo]

# Configures the endpoint
config :budgets, Budgets.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9lUYO2ura1WwlASaNG0nftIHn4MoI0qymYNwOitq4ZbrXrmZSH2lHLiQogMkQVZD",
  render_errors: [view: Budgets.ErrorView, accepts: ~w(json)],
  pubsub: [name: Budgets.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
