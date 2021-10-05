defmodule MybookmarksWeb.ReadLaterController do
  use MybookmarksWeb, :controller

  alias Mybookmarks.Bookmarks
  alias Mybookmarks.Bookmarks.ReadLater

  def new(conn, _params) do
    changeset = Bookmarks.change_read_later(%ReadLater{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"read_later" => read_later_params}) do
    user = conn.assigns.current_user
    case Bookmarks.create_read_later(read_later_params, user) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Read Later created successfully.")
        |> redirect(to: Routes.bookmark_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    read_later = Bookmarks.get_read_later!(id)
    render(conn, "show.html", read_later: read_later)
  end

  def edit(conn, %{"id" => id}) do
    read_later = Bookmarks.get_read_later!(id)
    changeset = Bookmarks.change_read_later(read_later)
    render(conn, "edit.html", read_later: read_later, changeset: changeset)
  end

  def update(conn, %{"id" => id, "read_later" => read_later_params}) do
    read_later = Bookmarks.get_read_later!(id)

    case Bookmarks.update_read_later(read_later, read_later_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Read Later updated successfully.")
        |> redirect(to: Routes.bookmark_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", read_later: read_later, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    read_later = Bookmarks.get_read_later!(id)
    {:ok, _read_later} = Bookmarks.delete_read_later(read_later)

    conn
    |> put_flash(:info, "Read Later deleted successfully.")
    |> redirect(to: Routes.bookmark_path(conn, :index))
  end
end
