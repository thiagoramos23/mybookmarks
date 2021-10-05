defmodule Mybookmarks.Bookmarks do
  @moduledoc """
  The Bookmarks context.
  """

  import Ecto.Query, warn: false
  alias Mybookmarks.Repo

  alias Mybookmarks.Bookmarks.Bookmark

  @doc """
  Returns the list of bookmarks.

  ## Examples

      iex> list_bookmarks()
      [%Bookmark{}, ...]

  """
  def list_bookmarks do
    Repo.all(Bookmark)
    |> Repo.preload(:user)
  end

  @doc """
  Returns the list of bookmarks for the user.

  ## Examples

      iex> list_bookmarks_by_user(user)
      [%Bookmark{}, ...]

  """
  def list_bookmarks_by_user(user) do
    Repo.all(Bookmark.bookmarks_by_user(user))
    Repo.all(Bookmark.bookmarks_by_user(user))
    |> Repo.preload(:user)
  end

  @doc """
  Returns the list of bookmarks that matches the search term for the user.

  ## Examples

      iex> list_searched_bookmarks_by_user(user, "Test")
      [%Bookmark{}, ...]

  """
  def list_searched_bookmarks_by_user(user, search) do
    Repo.all(Bookmark.bookmarks_by_user_match_term(user, search))
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single bookmark.

  Raises `Ecto.NoResultsError` if the Bookmark does not exist.

  ## Examples

      iex> get_bookmark!(123)
      %Bookmark{}

      iex> get_bookmark!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bookmark!(id), do: Repo.get!(Bookmark, id) |> Repo.preload(:user)

  @doc """
  Creates a bookmark.

  ## Examples

      iex> create_bookmark(%{field: value})
      {:ok, %Bookmark{}}

      iex> create_bookmark(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bookmark(attrs \\ %{}, user) do
    %Bookmark{}
    |> Bookmark.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a bookmark.

  ## Examples

      iex> update_bookmark(bookmark, %{field: new_value})
      {:ok, %Bookmark{}}

      iex> update_bookmark(bookmark, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bookmark(%Bookmark{} = bookmark, attrs) do
    bookmark
    |> Bookmark.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bookmark.

  ## Examples

      iex> delete_bookmark(bookmark)
      {:ok, %Bookmark{}}

      iex> delete_bookmark(bookmark)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bookmark(%Bookmark{} = bookmark) do
    Repo.delete(bookmark)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bookmark changes.

  ## Examples

      iex> change_bookmark(bookmark)
      %Ecto.Changeset{data: %Bookmark{}}

  """
  def change_bookmark(%Bookmark{} = bookmark, attrs \\ %{}) do
    Bookmark.changeset(bookmark, attrs)
  end

  alias Mybookmarks.Bookmarks.ReadLater

  @doc """
  Returns the list of read_laters.

  ## Examples

      iex> list_read_laters_by_user(user)
      [%ReadLater{}, ...]

  """
  def list_read_laters_by_user(user, limit \\ 5) do
    Repo.all(ReadLater.read_laters_by_user(user, limit))
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single read_later.

  Raises `Ecto.NoResultsError` if the Read later does not exist.

  ## Examples

      iex> get_read_later!(123)
      %ReadLater{}

      iex> get_read_later!(456)
      ** (Ecto.NoResultsError)

  """
  def get_read_later!(id), do: Repo.get!(ReadLater, id) |> Repo.preload(:user)

  @doc """
  Creates a read_later.

  ## Examples

      iex> create_read_later(%{field: value})
      {:ok, %ReadLater{}}

      iex> create_read_later(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_read_later(attrs \\ %{}, user) do
    %ReadLater{}
    |> ReadLater.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a read_later.

  ## Examples

      iex> update_read_later(read_later, %{field: new_value})
      {:ok, %ReadLater{}}

      iex> update_read_later(read_later, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_read_later(%ReadLater{} = read_later, attrs) do
    read_later
    |> ReadLater.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a read_later.

  ## Examples

      iex> delete_read_later(read_later)
      {:ok, %ReadLater{}}

      iex> delete_read_later(read_later)
      {:error, %Ecto.Changeset{}}

  """
  def delete_read_later(%ReadLater{} = read_later) do
    Repo.delete(read_later)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking read_later changes.

  ## Examples

      iex> change_read_later(read_later)
      %Ecto.Changeset{data: %ReadLater{}}

  """
  def change_read_later(%ReadLater{} = read_later, attrs \\ %{}) do
    ReadLater.changeset(read_later, attrs)
  end
end
