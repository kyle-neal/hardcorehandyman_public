defmodule Hardcorehandyman.Schema do
  @moduledoc """
  Behaviour to replace `Ecto.Schema` to set some defaults across all schemas in
  the codebase -- namely, UUID primary keys.
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      alias Hardcorehandyman.Repo
      import EctoCommons.{DateValidator, EmailValidator, URLValidator, PhoneNumberValidator}

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end
