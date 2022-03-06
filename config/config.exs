# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :mybookmarks,
  ecto_repos: [Mybookmarks.Repo]

# Configures the endpoint
config :mybookmarks, MybookmarksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "s91kI0Oc/mNOXl0Kt+lZx+V3+v0IbQAuJkyTD6FTLdHEda5H7qoBALlSpH3bk5ki",
  render_errors: [view: MybookmarksWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Mybookmarks.PubSub,
  live_view: [signing_salt: "6LGGc8Kt"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
