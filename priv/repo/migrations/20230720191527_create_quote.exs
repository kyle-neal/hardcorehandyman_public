defmodule Hardcorehandyman.Repo.Migrations.CreateQuote do
  use Ecto.Migration

  def change do
    create table(:quote) do
      add :job_title, :string
      add :description, :string
      add :photos, {:array, :binary}
      add :fname, :string
      add :lname, :string
      add :email, :string
      add :country, :string
      add :addr, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :schedule, :string
      add :reference, :string
      add :optin, :boolean, default: true, null: false

      timestamps()
    end
  end
end
