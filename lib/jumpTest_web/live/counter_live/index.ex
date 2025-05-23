defmodule JumpTestWeb.CounterLive.Index do
  use JumpTestWeb, :live_view

  alias JumpTest.Demo
  alias JumpTest.Demo.Counter

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :counters, Demo.list_counters())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Counter")
    |> assign(:counter, Demo.get_counter!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Counter")
    |> assign(:counter, %Counter{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Counters")
    |> assign(:counter, nil)
  end

  @impl true
  def handle_info({JumpTestWeb.CounterLive.FormComponent, {:saved, counter}}, socket) do
    {:noreply, stream_insert(socket, :counters, counter)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    counter = Demo.get_counter!(id)
    {:ok, _} = Demo.delete_counter(counter)

    {:noreply, stream_delete(socket, :counters, counter)}
  end
end
