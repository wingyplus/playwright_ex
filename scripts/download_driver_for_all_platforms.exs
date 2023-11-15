# This script ported from `scripts/download_driver_for_all_platforms.sh` in
# dotnet-java repository to Elixir script (aka `exs`).
#
# The benefit of using Elixir script is that we can use it for all platforms 
# (Linux, Windows, macOS, etc) that Elixir and Erlang/OTP supported.

Application.ensure_all_started(:ssl)
Application.ensure_all_started(:inets)

url = "https://playwright.azureedge.net/builds/driver"
platforms = ["mac", "mac-arm64", "linux", "linux-arm64", "win32_x64"]

# TODO: Strict with this version for now. Find the way to 
# bump this version.
cli_version = "1.39.0"
file_prefix = "playwright-#{cli_version}"

File.rm_rf!(Path.join(["priv", "driver-bundle"]))

platforms
|> Task.async_stream(
  fn platform ->
    destination = Path.join(["priv", "driver-bundle", platform])
    File.mkdir_p!(destination)

    filename = "#{file_prefix}-#{platform}.zip"
    url = "#{url}/#{filename}"

    IO.puts("#{platform}: Downloading driver for #{platform} using url #{url}")

    # TODO: match next version here.
    {:ok, {{_, 200, _}, _, zip}} = :httpc.request(url)
    File.write!(filename, zip)
    {:ok, _} = :zip.unzip(String.to_charlist(filename), cwd: String.to_charlist(destination))
    File.rm_rf!(filename)
    # Erlang :zip module doesn't keep permission after unzip the file.
    case platform do
      "win32_x64" ->
        File.chmod!(Path.join([destination, "node.exe"]), 0o755)
        File.chmod!(Path.join([destination, "playwright.cmd"]), 0o755)

      _ ->
        File.chmod!(Path.join([destination, "node"]), 0o755)
        File.chmod!(Path.join([destination, "playwright.sh"]), 0o755)
    end

    IO.puts("#{platform}: Done")
  end,
  timeout: :timer.minutes(10)
)
|> Stream.run()
