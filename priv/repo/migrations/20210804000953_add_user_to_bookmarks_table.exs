defmodule Mybookmarks.Repo.Migrations.AddUserToBookmarksTable do
  use Ecto.Migration

  def change do
    alter table(:bookmarks) do
      add :user_id, references(:users)
    end
  end
end
