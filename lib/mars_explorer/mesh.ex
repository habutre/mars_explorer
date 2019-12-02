defmodule MarsExplorer.Mesh do
  use Agent

  defstruct [:lon, :lat, :explorer]

  @opaque t :: %__MODULE__{lon: integer(), lat: integer(), explorer: MarsExplorer.t()}

  @moduledoc """
  Mesh module is responsible by store the mesh limits and keep the latest explorer landed.
  The mesh limits are longitude and latitude define by its lower position 0,0 to higher one defined in the moment of bootstrap of Mars Explorer by X,Y
  """

  @doc """
  Starts an agent linked to the current process with the given function
  See more at https://hexdocs.pm/elixir/Agent.html#start_link/2
  """
  @spec start() :: {:ok, pid} | {:error, {:already_started, pid}}
  def start do
    Agent.start_link(fn -> %__MODULE__{} end, name: __MODULE__)
  end

  @doc """
  Define the higher limit for the Mesh defined by lontitude and latitude since the lower one is 0,0
  """
  @spec boundary(integer(), integer()) :: :ok
  def boundary(lon, lat) do
    Agent.update(__MODULE__, &struct(&1, %{lon: lon, lat: lat}))
  end

  @doc """
  Retrieve the boundary defined on application bootstrap
  """
  @spec boundary() :: {integer(), integer()} | {nil, nil}
  def boundary do
    mesh = Agent.get(__MODULE__, & &1)
    {mesh.lon, mesh.lat}
  end

  @doc """
  Store the latest explorer landed in Mars. That information will be used to process the movement commands
  Whenever a new explorer arrives this information is replaced
  """
  @spec explorer(MarsExplorer.t()) :: :ok
  def explorer(landed_explorer) do
    Agent.update(__MODULE__, &struct(&1, %{explorer: landed_explorer}))
  end

  @doc """
  Retrieve the latest explorer landed
  """
  @spec explorer() :: MarsExplorer.t() | nil
  def explorer do
    mesh = Agent.get(__MODULE__, & &1)
    mesh.explorer
  end
end
