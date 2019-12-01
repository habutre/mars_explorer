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
  def main(args \\ []) do
    state = List.first(args) || %{}
  end
end
