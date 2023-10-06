defmodule PlaywrightExTest do
  use ExUnit.Case
  doctest PlaywrightEx

  test "greets the world" do
    assert PlaywrightEx.hello() == :world
  end
end
