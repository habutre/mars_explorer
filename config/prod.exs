import Config

config :logger, :console,
  backends: [:console],
  level: :info,
  metadata: [:application, :module, :function, :file, :line]
