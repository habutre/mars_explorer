defmodule MarsExplorer.MeshTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, mesh} = MarsExplorer.Mesh.start()
    %{mesh: mesh}
  end

  describe "boundary/2" do
    test "set the mesh's boundary" do
      MarsExplorer.Mesh.boundary(8, 8)
      boundary = MarsExplorer.Mesh.boundary()

      assert {8, 8} == boundary
    end
  end

  describe "boundary/0" do
    test "retrieve mesh's boundary" do
      boundary = MarsExplorer.Mesh.boundary()
      assert {nil, nil} = boundary
    end
  end

  describe "explorer/1" do
    test "should store the latest landed explorer on mesh" do
      landed_explorer = %MarsExplorer{lon: 1, lat: 1, direction: "W"}
      MarsExplorer.Mesh.explorer(landed_explorer)

      stored_explorer = MarsExplorer.Mesh.explorer()

      assert stored_explorer == landed_explorer
    end
  end

  describe "explorer/0" do
    test "should retrieve the latest landed explorer on mesh" do
      landed_explorer_a = %MarsExplorer{lon: 1, lat: 1, direction: "W"}
      landed_explorer_b = %MarsExplorer{lon: 1, lat: 5, direction: "S"}
      landed_explorer_c = %MarsExplorer{lon: 4, lat: 3, direction: "E"}
      MarsExplorer.Mesh.explorer(landed_explorer_b)
      MarsExplorer.Mesh.explorer(landed_explorer_c)
      MarsExplorer.Mesh.explorer(landed_explorer_a)

      stored_explorer = MarsExplorer.Mesh.explorer()

      assert stored_explorer == landed_explorer_a
    end
  end
end
