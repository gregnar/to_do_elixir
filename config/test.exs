use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :to_do, ToDo.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :to_do, ToDo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "to_do_test",
  size: 1,
  max_overflow: false
