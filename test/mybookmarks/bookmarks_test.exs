defmodule Mybookmarks.BookmarksTest do
  use Mybookmarks.DataCase

  import Mybookmarks.AccountsFixtures

  alias Mybookmarks.Bookmarks

  describe "bookmarks" do
    alias Mybookmarks.Bookmarks.Bookmark

    @valid_attrs %{favorite: true, name: "some name", url: "some url"}
    @update_attrs %{favorite: false, name: "some updated name", url: "some updated url"}
    @invalid_attrs %{favorite: nil, name: nil, url: nil}

    def bookmark_fixture(attrs \\ %{}, user \\ user_fixture()) do
      {:ok, bookmark} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bookmarks.create_bookmark(user)

      bookmark
    end

    test "list_bookmarks/0 returns all bookmarks" do
      bookmark = bookmark_fixture()
      assert Bookmarks.list_bookmarks() == [bookmark]
    end

    test "list_bookmarks_by_user/1 returns all bookmarks for the user" do
      bookmark              = bookmark_fixture()
      another_user          = user_fixture(%{email: "test@test.com"})
      another_user_bookmark = bookmark_fixture(@valid_attrs, another_user)
      assert Bookmarks.list_bookmarks_by_user(another_user) == [another_user_bookmark]
    end

    test "get_bookmark!/1 returns the bookmark with given id" do
      bookmark = bookmark_fixture()
      assert Bookmarks.get_bookmark!(bookmark.id) == bookmark
    end

    test "create_bookmark/1 with valid data creates a bookmark" do
      user = user_fixture()
      assert {:ok, %Bookmark{} = bookmark} = Bookmarks.create_bookmark(@valid_attrs, user)
      assert bookmark.favorite == true
      assert bookmark.name == "some name"
      assert bookmark.url == "some url"
      assert bookmark.user.id == user.id
    end

    test "create_bookmark/1 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookmarks.create_bookmark(@invalid_attrs, user)
    end

    test "update_bookmark/2 with valid data updates the bookmark" do
      bookmark = bookmark_fixture()
      assert {:ok, %Bookmark{} = bookmark} = Bookmarks.update_bookmark(bookmark, @update_attrs)
      assert bookmark.favorite == false
      assert bookmark.name == "some updated name"
      assert bookmark.url == "some updated url"
    end

    test "update_bookmark/2 with invalid data returns error changeset" do
      bookmark = bookmark_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookmarks.update_bookmark(bookmark, @invalid_attrs)
      assert bookmark == Bookmarks.get_bookmark!(bookmark.id)
    end

    test "delete_bookmark/1 deletes the bookmark" do
      bookmark = bookmark_fixture()
      assert {:ok, %Bookmark{}} = Bookmarks.delete_bookmark(bookmark)
      assert_raise Ecto.NoResultsError, fn -> Bookmarks.get_bookmark!(bookmark.id) end
    end

    test "change_bookmark/1 returns a bookmark changeset" do
      bookmark = bookmark_fixture()
      assert %Ecto.Changeset{} = Bookmarks.change_bookmark(bookmark)
    end
  end

  describe "read_laters" do
    alias Mybookmarks.Bookmarks.ReadLater

    @valid_attrs %{name: "some name", url: "some url"}
    @update_attrs %{name: "some updated name", url: "some updated url"}
    @invalid_attrs %{name: nil, url: nil}

    def read_later_fixture(attrs \\ %{}, user \\ user_fixture()) do
      {:ok, read_later} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bookmarks.create_read_later(user)

      read_later
    end

    test "list_read_laters_by_user/1 returns all read_laters by user" do
      read_later = read_later_fixture()
      assert Bookmarks.list_read_laters_by_user(read_later.user) == [read_later]
    end

    test "list_read_laters_by_user/2 returns the read laters by user using the limit passed" do
      user         = user_fixture()
      read_later   = read_later_fixture(@valid_attrs, user)
      read_later2  = read_later_fixture(@valid_attrs, user)
      _read_later3 = read_later_fixture(@valid_attrs, user)
      assert Bookmarks.list_read_laters_by_user(read_later.user, 2) == [read_later, read_later2]
    end

    test "get_read_later!/1 returns the read_later with given id" do
      read_later = read_later_fixture()
      assert Bookmarks.get_read_later!(read_later.id) == read_later
    end

    test "create_read_later/1 with valid data creates a read_later" do
      assert {:ok, %ReadLater{} = read_later} = Bookmarks.create_read_later(@valid_attrs, user_fixture())
      assert read_later.name == "some name"
      assert read_later.url == "some url"
    end

    test "create_read_later/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookmarks.create_read_later(@invalid_attrs, user_fixture())
    end

    test "update_read_later/2 with valid data updates the read_later" do
      read_later = read_later_fixture()
      assert {:ok, %ReadLater{} = read_later} = Bookmarks.update_read_later(read_later, @update_attrs)
      assert read_later.name == "some updated name"
      assert read_later.url == "some updated url"
    end

    test "update_read_later/2 with invalid data returns error changeset" do
      read_later = read_later_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookmarks.update_read_later(read_later, @invalid_attrs)
      assert read_later == Bookmarks.get_read_later!(read_later.id)
    end

    test "delete_read_later/1 deletes the read_later" do
      read_later = read_later_fixture()
      assert {:ok, %ReadLater{}} = Bookmarks.delete_read_later(read_later)
      assert_raise Ecto.NoResultsError, fn -> Bookmarks.get_read_later!(read_later.id) end
    end

    test "change_read_later/1 returns a read_later changeset" do
      read_later = read_later_fixture()
      assert %Ecto.Changeset{} = Bookmarks.change_read_later(read_later)
    end
  end
end
