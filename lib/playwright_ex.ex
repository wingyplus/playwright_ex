defmodule PlaywrightEx do
  @moduledoc """
  TBD
  """

  @options [
    env: [
      type: {:map, :string, :string},
      default: %{},
      doc: "Additional environment variables that will be passed to the driver"
    ]
  ]

  def create(opts \\ []) do
    {:ok, opts} = NimbleOptions.validate!(opts, @options)
    # TODO: Re-enable it after we have force install option.
    # PlaywrightEx.Driver.create_and_install(opts[:env])
    PlaywrightEx.Driver.ensure_driver_installed(opts[:env])
  end
end
