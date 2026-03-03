defmodule Hardcorehandyman.ReleaseTest do
  use ExUnit.Case, async: true

  describe "Release" do
    test "module is loaded" do
      assert Code.ensure_loaded?(Hardcorehandyman.Release)
    end

    test "migrate/0 function exists" do
      Code.ensure_loaded!(Hardcorehandyman.Release)
      assert function_exported?(Hardcorehandyman.Release, :migrate, 0)
    end

    test "rollback/2 function exists" do
      Code.ensure_loaded!(Hardcorehandyman.Release)
      assert function_exported?(Hardcorehandyman.Release, :rollback, 2)
    end
  end
end
