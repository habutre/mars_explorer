defmodule MarsExplorer.CommandProcessorTest do
  use ExUnit.Case
  alias MarsExplorer.CommandProcessor

  describe "process/2" do
    test "apply LMLMLMLMM against position 1 2 N should result 1 3 N" do
      position = %MarsExplorer{lon: 1, lat: 2, direction: "N"}
      commands = ["L", "M", "L", "M", "L", "M", "L", "M", "M"]
      expected_position = %MarsExplorer{lon: 1, lat: 3, direction: "N"}

      assert expected_position == CommandProcessor.process(position, commands)
    end

    test "applying MMRMMRMRRM against position 3 3 E should result 5 1 E" do
      position = %MarsExplorer{lon: 3, lat: 3, direction: "E"}
      commands = ["M", "M", "R", "M", "M", "R", "M", "R", "R", "M"]
      expected_position = %MarsExplorer{lon: 5, lat: 1, direction: "E"}

      assert expected_position == CommandProcessor.process(position, commands)
    end
  end
end
