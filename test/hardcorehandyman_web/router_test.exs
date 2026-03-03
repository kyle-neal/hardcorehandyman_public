defmodule HardcorehandymanWeb.RouterTest do
  use HardcorehandymanWeb.ConnCase

  describe "browser routes" do
    test "GET / returns 200", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert html_response(conn, 200)
    end

    test "GET /quote returns 200", %{conn: conn} do
      conn = get(conn, ~p"/quote")
      assert html_response(conn, 200)
    end

    test "GET /nonexistent returns error", %{conn: conn} do
      conn = get(conn, "/nonexistent")
      assert conn.status in [404, 302]
    end
  end
end
