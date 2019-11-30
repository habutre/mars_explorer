import Config

config :logger, :console,
  backends: [:console],
  level: :debug,
  metadata: [:application, :module, :function, :file, :line]
