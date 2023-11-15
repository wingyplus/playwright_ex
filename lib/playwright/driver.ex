defmodule Playwright.Driver do
  def create_and_install(env) do
  end

  @doc """
  Ensure driver must be installed.
  """
  def ensure_driver_installed(_env_variables, opts \\ []) do
    env = [
      {"PW_LANG_NAME", "elixir"},
      # TODO: Use version from Mix.
      {"PW_LANG_NAME_VERSION", "0.1.0"},
      # TODO: Find the way to sync version with download script.
      {"PW_CLI_DISPLAY_VERSION", "1.38.0"}
    ]

    # TODO: Do not hard code path.
    System.cmd("#{File.cwd!()}/priv/driver-bundle/mac-arm64/playwright.sh", ["install"], env: env)
  end
end
