defmodule Playwright.Process do
  @moduledoc """
  Start a Playwright process with the given sub-command.
  """

  use GenServer

  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, args)
  end

  @doc """
  Stop driver process.
  """
  def stop(pid) do
    GenServer.stop(pid)
  end

  @impl GenServer
  def init(args) do
    Process.flag(:trap_exit, true)

    port =
      Port.open(
        {:spawn_executable, args[:playwright_bin_path]},
        args: [args[:command]]
      )

    Port.monitor(port)
    {:ok, %{process: port}}
  end
end
