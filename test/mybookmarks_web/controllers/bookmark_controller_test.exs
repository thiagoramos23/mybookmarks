defmodule MybookmarksWeb.BookmarkControllerTest do
  use MybookmarksWeb.ConnCase

  import Mybookmarks.AccountsFixtures

  alias Mybookmarks.Bookmarks

  @create_attrs %{favorite: true, name: "some name", url: "some url", type: :read_it_later}
  @update_attrs %{favorite: false, name: "some updated name", url: "some updated url", type: :read_it_later}
  @invalid_attrs %{favorite: nil, name: nil, url: nil}

  setup :register_and_log_in_user

  def fixture(:bookmark) do
    user = user_fixture()
    {:ok, bookmark} = Bookmarks.create_bookmark(@create_attrs, user)
    bookmark
  end

  describe "index" do
    test "lists all bookmarks by user", %{conn: conn} do
      conn = get(conn, Routes.bookmark_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Bookmarks"
    end
  end

  describe "new bookmark" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.bookmark_path(conn, :new))
      assert html_response(conn, 200) =~ "Name"
      assert html_response(conn, 200) =~ "URL Address"
    end
  end

  describe "create bookmark" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bookmark_path(conn, :create), bookmark: @create_attrs)
      assert redirected_to(conn) == Routes.bookmark_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bookmark_path(conn, :create), bookmark: @invalid_attrs)
      assert html_response(conn, 200) =~ "Name"
    end
  end

  describe "edit bookmark" do
    setup [:create_bookmark]

    test "renders form for editing chosen bookmark", %{conn: conn, bookmark: bookmark} do
      conn = get(conn, Routes.bookmark_path(conn, :edit, bookmark))
      assert html_response(conn, 200) =~ "Name"
      assert html_response(conn, 200) =~ "URL Address"
    end
  end

  describe "update bookmark" do
    setup [:create_bookmark]

    test "redirects when data is valid", %{conn: conn, bookmark: bookmark} do
      conn = put(conn, Routes.bookmark_path(conn, :update, bookmark), bookmark: @update_attrs)
      assert redirected_to(conn) == Routes.bookmark_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn, bookmark: bookmark} do
      conn = put(conn, Routes.bookmark_path(conn, :update, bookmark), bookmark: @invalid_attrs)
      assert html_response(conn, 200) =~ "Name"
    end
  end

  describe "delete bookmark" do
    setup [:create_bookmark]

    test "deletes chosen bookmark", %{conn: conn, bookmark: bookmark} do
      conn = delete(conn, Routes.bookmark_path(conn, :delete, bookmark))
      assert redirected_to(conn) == Routes.bookmark_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.bookmark_path(conn, :show, bookmark))
      end
    end
  end

  defp create_bookmark(_) do
    bookmark = fixture(:bookmark)
    %{bookmark: bookmark}
  end
end
