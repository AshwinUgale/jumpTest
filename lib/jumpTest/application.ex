defmodule JumpTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JumpTestWeb.Telemetry,
      JumpTest.Repo,
      {DNSCluster, query: Application.get_env(:jumpTest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JumpTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: JumpTest.Finch},
      # Start a worker by calling: JumpTest.Worker.start_link(arg)
      # {JumpTest.Worker, arg},
      # Start to serve requests, typically the last entry
      JumpTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JumpTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JumpTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
