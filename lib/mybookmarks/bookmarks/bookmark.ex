defmodule Mybookmarks.Bookmarks.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookmarks" do
    field :favorite, :boolean, default: false
    field :name, :string
    field :url, :string
    belongs_to :user, Mybookmarks.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(bookmark, attrs) do
    bookmark
    |> cast(attrs, [:name, :url, :favorite])
    |> validate_required([:name, :url, :favorite])
  end
end
