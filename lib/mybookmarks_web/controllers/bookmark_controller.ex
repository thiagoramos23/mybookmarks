defmodule MybookmarksWeb.BookmarkController do
  use MybookmarksWeb, :controller

  alias Mybookmarks.Bookmarks
  alias Mybookmarks.Bookmarks.Bookmark

  def index(conn, params) do
    page = String.to_integer(params["page"] || "1")
    page = Bookmarks.list_bookmarks_by_user(conn.assigns.current_user, page)
    render(conn, "index.html", page: page)
  end

  def search(conn, %{"query" => query} = _params) do
    bookmarks = Bookmarks.list_searched_bookmarks_by_user(conn.assigns.current_user, query)
    render(conn, "index.html", bookmarks: bookmarks)
  end

  def new(conn, _params) do
    changeset = Bookmarks.change_bookmark(%Bookmark{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bookmark" => bookmark_params}) do
    user = conn.assigns.current_user
    case Bookmarks.create_bookmark(bookmark_params, user) do
      {:ok, _} ->

        conn
        |> put_flash(:info, "Bookmark created successfully.")
        |> redirect(to: Routes.bookmark_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    render(conn, "show.html", bookmark: bookmark)
  end

  def edit(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    changeset = Bookmarks.change_bookmark(bookmark)
    render(conn, "edit.html", bookmark: bookmark, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bookmark" => bookmark_params}) do
    bookmark = Bookmarks.get_bookmark!(id)

    case Bookmarks.update_bookmark(bookmark, bookmark_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Bookmark updated successfully.")
        |> redirect(to: Routes.bookmark_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bookmark: bookmark, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    {:ok, _bookmark} = Bookmarks.delete_bookmark(bookmark)

    conn
    |> put_flash(:info, "Bookmark deleted successfully.")
    |> redirect(to: Routes.bookmark_path(conn, :index))
  end
end
