defmodule Mybookmarks.Bookmarks.ReadLater do
  use Ecto.Schema
  import Ecto.{Changeset, Query}

  schema "read_laters" do
    field :name, :string
    field :url, :string
    belongs_to :user, Mybookmarks.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(read_later, attrs) do
    read_later
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url])
  end

  def read_laters_by_user(user, limit \\ 0) do
    query =
      from r in Mybookmarks.Bookmarks.ReadLater,
        where: r.user_id == ^user.id,
        order_by: [r.inserted_at, r.name]

    if limit > 0 do
      query |> limit(^limit)
    else
      query
    end
  end
end
