defmodule MarsExplorer do
  require Logger

  defstruct []

  @type t :: %__MODULE__{}

  @moduledoc """
  MarsExplorer is ...
  """

  @doc """
  Main function responsible to be the entrypoint of App
  """
  def main(args \\ []) do
    state = List.first(args) || %{}
  end
end
