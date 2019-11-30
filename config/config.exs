import Config

config :logger, :console,
  backends: [:console],
  level: :error

import_config "#{Mix.env()}.exs"
