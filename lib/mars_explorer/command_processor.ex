# lib/mars_explorer/command_processor.ex
defmodule MarsExplorer.CommandProcessor do
  require Logger

  @moduledoc """
  Executes all commands sent to Explorer. In other words is the explorer controller
  """

  @doc """
  Executes movements and direction of Explorer and controls the boundaries to avoid accidents and control resources used on exploration
  """
  @spec process(MarsExplorer.t(), list(String.t())) ::
          {:ok, MarsExplorer.t()} | {:error, String.t()}
  def process(state, commands) when is_list(commands) do
    {_, new_state} =
      Enum.map_reduce(commands, state, fn cmd, new_state ->
        {cmd, Map.merge(state, exec(cmd, new_state))}
      end)

    {:ok, new_state}
  end

  def process(state, []), do: {:ok, state}

  def process(_state, _commands), do: {:error, "Commands should be a List of Strings"}

  defp exec("M", state) do
    if can_move?(state) do
      move(state)
    else
      Logger.debug("Cannot move to #{state.direction} from lon: #{state.lon} / lat: #{state.lat}")

      state
    end
  end

  defp exec("L", state) do
    turn_left(state)
  end

  defp exec("R", state) do
    turn_right(state)
  end

  defp exec(_command, state) do
    state
  end

  defp can_move?(state) do
    {lon, lat} = MarsExplorer.Mesh.boundary()

    cond do
      "N" == state.direction && state.lat == lat -> false
      "S" == state.direction && state.lat == 0 -> false
      "E" == state.direction && state.lon == lon -> false
      "W" == state.direction && state.lon == 0 -> false
      true -> true
    end
  end

  defp move(state) do
    case state.direction do
      "N" -> struct(state, %{lat: state.lat + 1})
      "S" -> struct(state, %{lat: state.lat - 1})
      "E" -> struct(state, %{lon: state.lon + 1})
      "W" -> struct(state, %{lon: state.lon - 1})
      _ -> state
    end
  end

  defp turn_right(state) do
    case state.direction do
      "N" -> struct(state, %{direction: "E"})
      "S" -> struct(state, %{direction: "W"})
      "E" -> struct(state, %{direction: "S"})
      "W" -> struct(state, %{direction: "N"})
      _ -> state
    end
  end

  defp turn_left(state) do
    case state.direction do
      "N" -> struct(state, %{direction: "W"})
      "S" -> struct(state, %{direction: "E"})
      "E" -> struct(state, %{direction: "N"})
      "W" -> struct(state, %{direction: "S"})
      _ -> state
    end
  end
end
