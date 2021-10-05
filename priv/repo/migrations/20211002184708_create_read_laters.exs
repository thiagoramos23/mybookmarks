defmodule Mybookmarks.Repo.Migrations.CreateReadLaters do
  use Ecto.Migration

  def change do
    create table(:read_laters) do
      add :name, :string
      add :url, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:read_laters, [:user_id])
  end
end
