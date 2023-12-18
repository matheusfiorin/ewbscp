defmodule ConcurrencyManager do
  use GenServer

  @initial_concurrency 100
  @min_concurrency 10
  @max_concurrency 200

  @decrease_factor 0.8
  @increase_factor 1.2

  @spec start_link(atom()) :: GenServer.on_start()
  def start_link(name) do
    GenServer.start_link(__MODULE__, @initial_concurrency, name: name)
  end

  def get_concurrency(name) do
    GenServer.call(name, :get_current_concurrency)
  end

  @spec calculate_adjustment(atom(), atom()) :: integer()
  def calculate_adjustment(name, adjustment) do
    state = GenServer.call(name, :get_current_concurrency)

    case adjustment do
      :increase -> state * @increase_factor
      :decrease -> state * @decrease_factor
      _ -> state
    end
  end

  @impl true
  def handle_info(_, state) do
    {:noreply, state}
  end

  @impl true
  def handle_call(:get_current_concurrency, _, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast(name, adjustment) do
    {:noreply, calculate_adjustment(name, adjustment)}
  end
end
