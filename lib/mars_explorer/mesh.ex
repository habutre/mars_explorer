defmodule MarsExplorer.Mesh do
  use Agent

  defstruct [:lon, :lat]

  @type t :: %__MODULE__{lon: integer(), lat: integer()}

  def start do
    Agent.start_link(fn -> %__MODULE__{} end, name: __MODULE__)
  end

  def boundary(lon, lat) do
    Agent.update(__MODULE__, &struct(&1, %{lon: lon, lat: lat}))
  end

  def boundary do
    Agent.get(__MODULE__, & &1)
  end
end
