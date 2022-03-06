defmodule Mybookmarks.Repo.Migrations.CreateBookmarks do
  use Ecto.Migration

  def change do
    create table(:bookmarks) do
      add :name, :string
      add :url, :string
      add :favorite, :boolean, default: false, null: false
      add :type, :string, default: "blog", null: false
      add :user_id, references(:users)

      timestamps()
    end

  end
end
