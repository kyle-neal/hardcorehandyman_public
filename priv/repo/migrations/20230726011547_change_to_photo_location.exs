defmodule Hardcorehandyman.Repo.Migrations.ChangeToPhotoLocation do
  use Ecto.Migration

  def change do
    alter table(:quote) do
      add :photo_locations, {:array, :string}
    end

    alter table(:quote) do
      remove :photos
    end
  end
end
