defmodule HardcorehandymanWeb.EndpointTest do
  use HardcorehandymanWeb.ConnCase

  describe "endpoint" do
    test "serves static files", %{conn: conn} do
      conn = get(conn, "/robots.txt")
      assert conn.status == 200
    end

    test "returns 200 for the home page", %{conn: conn} do
      conn = get(conn, "/")
      assert conn.status == 200
    end
  end
end
