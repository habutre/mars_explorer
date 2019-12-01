# lib/mars_explorer.ex
defmodule MarsExplorer do
  require Logger

  defstruct [:lon, :lat, :direction]

  @type t :: %__MODULE__{
          lon: integer(),
          lat: integer(),
          direction: String.t()
        }

  @moduledoc """
  MarsExplorer is a explorer controller that process commands received as stimulus and instruct the engines to which direction moves
  MarsExplorer is able:
      * to built the surface mesh limiting boundaries of movement
      * to land the explorer on a planned location
      * to move according with commands received
      * to inform the final position, probably the point to depart
  """

  @doc """
  Main function responsible to be the entrypoint of App
  """
  def main(_args \\ []) do
    MarsExplorer.Mesh.start()

    case IO.read(:stdio, :line) do
      :eof ->
        Logger.debug("All commands were processed")
        System.halt(0)

      {:error, reason} ->
        Logger.error("Error! Reason: #{reason}")
        System.halt(1)

      instruction ->
        instruction
        |> parse
        |> exec
        |> print
        # recursively call main passing the state as List
        |> (&MarsExplorer.main(&1)).()
    end
  end

  defp parse(line) do
    line
    |> String.replace(~r/[\s\t\n\r]+/, " ", global: true)
    |> String.trim()
    |> String.split(" ")
  end

  defp exec(command) when is_list(command) and length(command) == 1 do
    explorer = MarsExplorer.Mesh.explorer()

    cmd =
      command
      |> List.first()
      |> String.split("")
      |> Enum.filter(&(&1 != ""))

    {:ok, result} = MarsExplorer.CommandProcessor.process(explorer, cmd)

    result
  end

  defp exec(command) when is_list(command) and length(command) == 2 do
    [lon, lat] = Enum.map(command, fn elem -> String.to_integer(elem) end)

    MarsExplorer.Mesh.boundary(lon, lat)
  end

  defp exec(command) when is_list(command) and length(command) == 3 do
    [lon, lat, direction] = command

    landed_explorer = %MarsExplorer{
      lon: String.to_integer(lon),
      lat: String.to_integer(lat),
      direction: direction
    }

    MarsExplorer.Mesh.explorer(landed_explorer)
  end

  defp exec(command), do: IO.puts("Unknown command [#{command}] ignoring")

  defp print(explorer) when is_map(explorer) do
    IO.puts("#{explorer.lon} #{explorer.lat} #{explorer.direction}")
  end

  defp print(:ok), do: nil
end
