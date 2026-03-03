defmodule Hardcorehandyman.Repo.Migrations.AddPhone do
  use Ecto.Migration

  def change do
    # add :phone, :string
    alter table(:quote) do
      add :phone, :string
    end
  end
end
