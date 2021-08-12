defmodule Mybookmarks.Bookmarks.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset 
  import Ecto.Query

  alias Mybookmarks.Bookmarks.Bookmark

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

  def bookmarks_by_user(user) do
    from b in Bookmark,
      where: b.user_id == ^user.id,
      order_by: b.name
  end

  def bookmarks_by_user_match_term(user, search) do
    from b in Bookmark,
      where: b.user_id == ^user.id,
      where: ilike(b.name, ^"%#{search}%"),
      order_by: b.name
  end
end
