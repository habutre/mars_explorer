defmodule MarsExplorer.MeshTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, mesh} = MarsExplorer.Mesh.start()
    %{mesh: mesh}
  end

  describe "boundary/2" do
    test "set the mesh's boundary" do
      MarsExplorer.Mesh.boundary(8, 8)

      assert MarsExplorer.Mesh.boundary() == %MarsExplorer.Mesh{lon: 8, lat: 8}
    end
  end

  describe "boundary/0" do
    test "retrieve initial mesh's boundary", %{mesh: mesh} do
      assert MarsExplorer.Mesh.boundary() == %MarsExplorer.Mesh{lon: nil, lat: nil}
    end
  end
end
