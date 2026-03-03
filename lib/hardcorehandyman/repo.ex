defmodule Hardcorehandyman.Repo do
  use Ecto.Repo,
    otp_app: :hardcorehandyman,
    adapter: Ecto.Adapters.Postgres
end
