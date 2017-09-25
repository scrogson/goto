# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :goto,
  ecto_repos: [Goto.Repo]

# Configures the endpoint
config :goto, GotoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uMTqQmSIo1nO4lO+VaBLCVbZ1MzuQPbGZ3mcdrZwI3vBmsBtlxgoM7WuJkRz52Fv",
  render_errors: [view: GotoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Goto.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
