# MarsExplorer

In order to validate the MarsExplorer App execution three possible ways are proposed

The first three proposed ways needs some installed dependencies
* Elixir 1.9
* Erlang 22
* mix local.hex
* mix escript.install hex ex_doc
* Use the ex_doc to see the documentation locally (details on `shipping.sh:5`)

## Running the code locally

1. Extract the code somewhere eg.: `/tmp`
1. Execute the following commands (commands will work on *nix systems*)
    1. cd mars_explorer
    1. mix deps.get
    1. mix deps.compile
    1. iex -S mix
    1. MarsExplorer.main
    1. 5 5 <enter>
    1. 1 2 N <enter>
    1. LMLMLMLMM <enter>

As a result one should see an output similar to:

```
1 3 N
```

> Follow the instruction on `shipping.sh:5` for generate and check documentation

## Running with code locally assembled

1. Extract the code somewhere eg.: `/tmp`
1. Execute the following commands (commands will work on *nix systems*)
    1. cd /tmp/mars_explorer
    1. mix deps.get
    1. mix deps.compile
    1. mix escript.build
    1. ./mars_explorer < commands.txt

As a result one should see an output similar to:

```
1 3 N
5 1 E
```

> Follow the instruction on `shipping.sh:5` for generate and check documentation

## Running via docker (Elixir environment provided)

1. Execute the following commands (commands will work on *nix systems*)
    1. Extract the code and execute `cd mars_explorer`
    1. ./shipping.sh 
    1. cat commands.txt | docker run -i -p 80:80 company/mars_explorer:0.1.0
    1. Check the output for validation
    1. Open the link in your browser (http://localhost/MarsExplorer.html)

With an input provided in the project `commands.txt`:

```
⇒ cat commands.txt
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
```

One should see a output like this:

```
1 3 N
5 1 E
```

## Running via docker only (No Elixir environment needed)

1. Execute the following commands (commands will work on *nix systems*)
    1. Extract the code and execute `cd mars_explorer`
    1. ./shipping-multi-stage.sh 
    1. cat commands.txt | docker run -i -p 80:80 company/mars_explorer:0.1.0
    1. Check the output for validation
    1. Open the link in your browser (http://localhost/MarsExplorer.html)

With an input provided in the project `commands.txt`:

```
⇒ cat commands.txt
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
```

One should see a output like this:

```
1 3 N
5 1 E
```

> The nginx logs will be printed in the current terminal, so ensure to validate the output first or run the docker steps again

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mars_explorer](https://hexdocs.pm/mars_explorer).

