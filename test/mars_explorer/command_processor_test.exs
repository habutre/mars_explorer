defmodule MarsExplorer.CommandProcessorTest do
  use ExUnit.Case
  alias MarsExplorer.CommandProcessor

  describe "process/2" do
    test "should not change state when receives empty commands list" do
      position = %MarsExplorer{lon: 3, lat: 4, direction: "E", boundary: {5, 5}}
      commands = []
      expected_state = {:ok, %MarsExplorer{lon: 3, lat: 4, direction: "E", boundary: {5, 5}}}

      assert expected_state == CommandProcessor.process(position, commands)
    end

    test "applying LMLMLMLMM against position 1 2 N should result 1 3 N" do
      position = %MarsExplorer{lon: 1, lat: 2, direction: "N", boundary: {5, 5}}
      commands = ["L", "M", "L", "M", "L", "M", "L", "M", "M"]
      expected_state = {:ok, %MarsExplorer{lon: 1, lat: 3, direction: "N", boundary: {5, 5}}}

      assert expected_state == CommandProcessor.process(position, commands)
    end

    test "applying MMRMMRMRRM against position 3 3 E should result 5 1 E" do
      position = %MarsExplorer{lon: 3, lat: 3, direction: "E", boundary: {5, 5}}
      commands = ["M", "M", "R", "M", "M", "R", "M", "R", "R", "M"]
      expected_state = {:ok, %MarsExplorer{lon: 5, lat: 1, direction: "E", boundary: {5, 5}}}

      assert expected_state == CommandProcessor.process(position, commands)
    end

    test "applying RMLMMM against positioin 2 2 S should never cross boundaries resulting 0 0 W" do
      position = %MarsExplorer{lon: 2, lat: 2, direction: "S", boundary: {5, 5}}
      commands = ["R", "M", "L", "M", "M", "M", "R", "M"]
      expected_state = {:ok, %MarsExplorer{lon: 0, lat: 0, direction: "W", boundary: {5, 5}}}

      assert expected_state == CommandProcessor.process(position, commands)
    end

    test "applying RMLMMM against positioin 2 2 S, unknown commands should be ignored" do
      position = %MarsExplorer{lon: 2, lat: 2, direction: "S", boundary: {5, 5}}
      commands = ["Y", "R", "M", "L", "M", "A", "M", "M", "R", "M", "Z"]
      expected_state = {:ok, %MarsExplorer{lon: 0, lat: 0, direction: "W", boundary: {5, 5}}}

      assert expected_state == CommandProcessor.process(position, commands)
    end

    test "should return an error when commands is not list" do
      position = %MarsExplorer{lon: 2, lat: 2, direction: "W", boundary: {5, 5}}
      commands = {"L", "M", "L", "M", "L", "M", "L", "M", "M"}
      expected_state = {:error, "Commands should be a List of Strings"}

      assert expected_state == CommandProcessor.process(position, commands)
    end
  end
end
