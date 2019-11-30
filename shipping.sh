#!/bin/bash
FORCE_STATIC_ANALYSIS=$1

echo "Starting package preparation for shipping"

echo "Updating dependencies"
MIX_ENV=prod mix do deps.get, deps.compile

echo "Performing application tests"
if [ "$FORCE_STATIC_ANALYSIS" = "-f" ]; then # way simple check
  mix do clean, compile, credo --strict, dialyzer && mix test
else
  mix do clean, compile, credo --strict && mix test
fi

echo "Prepare documentation"
MIX_ENV=prod mix compile && \
  ~/.mix/escripts/ex_doc "MarsExplorer" "0.1.0" \
  _build/prod/lib/mars_explorer/ebin \
  -m "MarsExplorer" \
  -u "https://git.acme.com/company/mars_explorer" && \
  MIX_ENV=prod mix escript.build

echo "Building MarsExplorer App"
MIX_ENV=prod mix escript.build

echo "Build docker image company/mars_explorer:0.1.0"
docker build -t company/mars_explorer:0.1.0 .

