defmodule Mybookmarks.Repo do
  use Ecto.Repo,
    otp_app: :mybookmarks,
    adapter: Ecto.Adapters.Postgres
end
