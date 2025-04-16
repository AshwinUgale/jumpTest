defmodule JumpTest.DemoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JumpTest.Demo` context.
  """

  @doc """
  Generate a counter.
  """
  def counter_fixture(attrs \\ %{}) do
    {:ok, counter} =
      attrs
      |> Enum.into(%{
        count: 42
      })
      |> JumpTest.Demo.create_counter()

    counter
  end
end
