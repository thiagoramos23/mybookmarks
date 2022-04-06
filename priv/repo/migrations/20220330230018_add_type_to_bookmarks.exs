defmodule Mybookmarks.Repo.Migrations.AddTypeToBookmarks do
  use Ecto.Migration

  def change do
    alter table(:bookmarks) do
      add :type, :string, default: "blog", null: false
    end
  end
end
