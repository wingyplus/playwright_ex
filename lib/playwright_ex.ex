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
    opts
  end
end
