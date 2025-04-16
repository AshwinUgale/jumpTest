defmodule JumpTest.Repo do
  use Ecto.Repo,
    otp_app: :jumpTest,
    adapter: Ecto.Adapters.Postgres
end
