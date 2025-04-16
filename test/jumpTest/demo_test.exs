defmodule JumpTest.DemoTest do
  use JumpTest.DataCase

  alias JumpTest.Demo

  describe "counters" do
    alias JumpTest.Demo.Counter

    import JumpTest.DemoFixtures

    @invalid_attrs %{count: nil}

    test "list_counters/0 returns all counters" do
      counter = counter_fixture()
      assert Demo.list_counters() == [counter]
    end

    test "get_counter!/1 returns the counter with given id" do
      counter = counter_fixture()
      assert Demo.get_counter!(counter.id) == counter
    end

    test "create_counter/1 with valid data creates a counter" do
      valid_attrs = %{count: 42}

      assert {:ok, %Counter{} = counter} = Demo.create_counter(valid_attrs)
      assert counter.count == 42
    end

    test "create_counter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Demo.create_counter(@invalid_attrs)
    end

    test "update_counter/2 with valid data updates the counter" do
      counter = counter_fixture()
      update_attrs = %{count: 43}

      assert {:ok, %Counter{} = counter} = Demo.update_counter(counter, update_attrs)
      assert counter.count == 43
    end

    test "update_counter/2 with invalid data returns error changeset" do
      counter = counter_fixture()
      assert {:error, %Ecto.Changeset{}} = Demo.update_counter(counter, @invalid_attrs)
      assert counter == Demo.get_counter!(counter.id)
    end

    test "delete_counter/1 deletes the counter" do
      counter = counter_fixture()
      assert {:ok, %Counter{}} = Demo.delete_counter(counter)
      assert_raise Ecto.NoResultsError, fn -> Demo.get_counter!(counter.id) end
    end

    test "change_counter/1 returns a counter changeset" do
      counter = counter_fixture()
      assert %Ecto.Changeset{} = Demo.change_counter(counter)
    end
  end
end
