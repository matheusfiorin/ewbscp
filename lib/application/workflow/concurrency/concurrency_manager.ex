defmodule ConcurrencyManager do
  use GenServer

  @initial_max_concurrency 100
  @decrease_factor 0.8
  @increase_factor 1.2
  @min_concurrency 10
  @max_concurrency 200

  def start_link() do
    GenServer.start_link(__MODULE__, @initial_max_concurrency, name: __MODULE__)
  end

  def handle_call(:get_max_concurrency, _, max_concurrency) do
    {:reply, max_concurrency, max_concurrency}
  end

  def get_max_concurrency() do
    GenServer.call(__MODULE__, :get_max_concurrency)
  end

  def handle_cast({:adjust_concurrency, adjustment}, max_concurrency) do
    new_concurrency = calculate_new_concurrency(max_concurrency, adjustment)
    {:noreply, new_concurrency}
  end

  defp adjust_concurrency(adjustment) do
    GenServer.cast(__MODULE__, {:adjust_concurrency, adjustment})
  end

  defp calculate_new_concurrency(current, :increase) do
    new_concurrency = round(current * @increase_factor)
    min(@max_concurrency, new_concurrency)
  end

  defp calculate_new_concurrency(current, :decrease) do
    new_concurrency = round(current * @decrease_factor)
    max(@min_concurrency, new_concurrency)
  end
end
