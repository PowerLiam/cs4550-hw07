defmodule Events.UsersTest do
  use Events.DataCase

  alias Events.Users

  describe "events" do
    alias Events.Users.Event

    @valid_attrs %{date: "2010-04-17T14:00:00Z", description: "some description", name: "some name"}
    @update_attrs %{date: "2011-05-18T15:01:01Z", description: "some updated description", name: "some updated name"}
    @invalid_attrs %{date: nil, description: nil, name: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Users.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Users.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Users.create_event(@valid_attrs)
      assert event.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert event.description == "some description"
      assert event.name == "some name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Users.update_event(event, @update_attrs)
      assert event.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert event.description == "some updated description"
      assert event.name == "some updated name"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_event(event, @invalid_attrs)
      assert event == Users.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Users.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Users.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Users.change_event(event)
    end
  end
end
