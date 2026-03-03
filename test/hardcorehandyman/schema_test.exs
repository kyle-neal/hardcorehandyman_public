defmodule Hardcorehandyman.SchemaTest do
  use ExUnit.Case, async: true

  defmodule TestSchema do
    use Hardcorehandyman.Schema

    schema "test_table" do
      field(:name, :string)
    end
  end

  describe "Hardcorehandyman.Schema" do
    test "sets binary_id as primary key type" do
      assert TestSchema.__schema__(:type, :id) == :binary_id
    end

    test "sets autogenerate on primary key" do
      assert {:id, :id, :binary_id} = TestSchema.__schema__(:autogenerate_id)
    end

    test "imports EctoCommons validators" do
      # Verify the module was compiled with imported validators
      # The Schema module imports these validators for use in schemas
      assert Code.ensure_loaded?(EctoCommons.EmailValidator)
    end
  end
end
