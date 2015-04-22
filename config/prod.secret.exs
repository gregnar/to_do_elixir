use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :to_do, ToDo.Endpoint,
  secret_key_base: "zqRueKY3GY/hvxatuEJERvD0pWbVZbb7hMhoJw3m/VPDKlGoEuCatgvM6VoaZ+6p"

# Configure your database
config :to_do, ToDo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "to_do_prod"
