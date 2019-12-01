# lib/mars_explorer/command_processor.ex
defmodule MarsExplorer.CommandProcessor do
  @spec process(MarsExplorer.t(), list()) :: MarsExplorer.t()
  def process(state, commands) do
    {_, res} =
      Enum.map_reduce(commands, state, fn cmd, new_state ->
        {cmd, Map.merge(state, exec(cmd, new_state))}
      end)

    res
  end

  defp exec("M", state) do
    move(state)
  end

  defp exec("L", state) do
    turn_left(state)
  end

  defp exec("R", state) do
    turn_right(state)
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
