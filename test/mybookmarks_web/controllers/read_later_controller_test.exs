defmodule MybookmarksWeb.ReadLaterControllerTest do
  use MybookmarksWeb.ConnCase

  import Mybookmarks.AccountsFixtures

  alias Mybookmarks.Bookmarks

  @create_attrs %{name: "some name", url: "some url"}
  @update_attrs %{name: "some updated name", url: "some updated url"}
  @invalid_attrs %{name: nil, url: nil}

  setup :register_and_log_in_user

  def fixture(:read_later) do
    user = user_fixture()
    {:ok, read_later} = Bookmarks.create_read_later(@create_attrs, user)
    read_later
  end

  describe "new read later" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.read_later_path(conn, :new))
      assert html_response(conn, 200) =~ "Add the URL you want to save and read it later"
    end
  end

  describe "create read_later" do
    test "redirects to bookmark index when data is valid", %{conn: conn} do
      conn = post(conn, Routes.read_later_path(conn, :create), read_later: @create_attrs)

      conn = get(conn, Routes.bookmark_path(conn, :index))
      assert html_response(conn, 200) =~ "Reading Later"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.read_later_path(conn, :create), read_later: @invalid_attrs)
      assert html_response(conn, 200) =~ "Add the URL you want to save and read it later"
    end
  end

  describe "edit read_later" do
    setup [:create_read_later]

    test "renders form for editing chosen read_later", %{conn: conn, read_later: read_later} do
      conn = get(conn, Routes.read_later_path(conn, :edit, read_later))
      assert html_response(conn, 200) =~ "Add the URL you want to save and read it later"
    end
  end

  describe "update read_later" do
    setup [:create_read_later]

    test "redirects when data is valid", %{conn: conn, read_later: read_later} do
      conn = put(conn, Routes.read_later_path(conn, :update, read_later), read_later: @update_attrs)

      conn = get(conn, Routes.bookmark_path(conn, :index))
      assert html_response(conn, 200) =~ "Reading Later"
    end

    test "renders errors when data is invalid", %{conn: conn, read_later: read_later} do
      conn = put(conn, Routes.read_later_path(conn, :update, read_later), read_later: @invalid_attrs)
      assert html_response(conn, 200) =~ "Add the URL you want to save and read it later"
    end
  end

  describe "delete read_later" do
    setup [:create_read_later]

    test "deletes chosen read_later", %{conn: conn, read_later: read_later} do
      conn = delete(conn, Routes.read_later_path(conn, :delete, read_later))
      assert redirected_to(conn) == Routes.bookmark_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.read_later_path(conn, :show, read_later))
      end
    end
  end

  defp create_read_later(_) do
    read_later = fixture(:read_later)
    %{read_later: read_later}
  end
end
