defmodule MarsExplorer.Mesh do
  use Agent

  defstruct [:lon, :lat, :explorer]

  @opaque t :: %__MODULE__{lon: integer(), lat: integer(), explorer: MarsExplorer.t()}

  def start do
    Agent.start_link(fn -> %__MODULE__{} end, name: __MODULE__)
  end

  def boundary(lon, lat) do
    Agent.update(__MODULE__, &struct(&1, %{lon: lon, lat: lat}))
  end

  def boundary do
    mesh = Agent.get(__MODULE__, & &1)
    {mesh.lon, mesh.lat}
  end

  def explorer(landed_explorer) do
    Agent.update(__MODULE__, &struct(&1, %{explorer: landed_explorer}))
  end

  def explorer do
    mesh = Agent.get(__MODULE__, & &1)
    mesh.explorer
  end
end
