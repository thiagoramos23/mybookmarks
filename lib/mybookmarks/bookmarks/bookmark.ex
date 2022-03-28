defmodule Mybookmarks.Bookmarks.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Mybookmarks.Bookmarks.Bookmark
  alias Mybookmarks.Pagination.Paginator

  schema "bookmarks" do
    field :favorite, :boolean, default: false
    field :name, :string
    field :url, :string
    field :type, Ecto.Enum, values: [:blog, :read_it_later, :learning, :other]
    belongs_to :user, Mybookmarks.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(bookmark, attrs) do
    bookmark
    |> cast(attrs, [:name, :url, :favorite, :type])
    |> validate_required([:name, :url, :favorite, :type])
  end

  def bookmarks_by_user(user, type, opts) do
    query = 
      from b in Bookmark,
        where: b.user_id == ^user.id,
        where: b.type == ^type,
        order_by: b.name


    Paginator.call(query, opts)
  end

  def bookmarks_by_user_match_term(user, search, page \\ 1) do
    query = 
      from b in Bookmark,
        where: b.user_id == ^user.id,
        where: ilike(b.name, ^"%#{search}%"),
        order_by: b.name

    Paginator.call(query, %{page: page})
  end
end
