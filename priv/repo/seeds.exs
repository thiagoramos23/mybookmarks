# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mybookmarks.Repo.insert!(%Mybookmarks.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Mybookmarks.Repo
alias Mybookmarks.Bookmarks.Bookmark

{:ok, user} =
  %{
    email: "user@user.com",
    password: "123123123123123",
    confirmed_at: NaiveDateTime.utc_now()
  }
  |> Mybookmarks.Accounts.register_user()

Enum.each(1..20, fn _ ->
  %Bookmark{
   name: "Test",
   url: "www.google.com",
   user: user,
   type: :blog
  }
  |> Repo.insert()
end)

Enum.each(1..20, fn _ ->
  %Bookmark{
   name: "Test Facebook",
   url: "www.facebook.com",
   user: user,
   type: :read_it_later
  }
  |> Repo.insert()
end)

Enum.each(1..20, fn _ ->
  %Bookmark{
   name: "Test Twitter",
   url: "www.google.com",
   user: user,
   type: :learning
  }
  |> Repo.insert()
end)

Enum.each(1..20, fn _ ->
  %Bookmark{
   name: "Test Linked in",
   url: "www.google.com",
   user: user,
   type: :learning
  }
  |> Repo.insert()
end)

Enum.each(1..20, fn _ ->
  %Bookmark{
   name: "Test Instagram",
   url: "www.google.com",
   user: user,
   type: :learning
  }
  |> Repo.insert()
end)

Enum.each(1..20, fn _ ->
  %Bookmark{
   name: "Test Max",
   url: "www.google.com",
   user: user,
   type: :learning
  }
  |> Repo.insert()
end)




