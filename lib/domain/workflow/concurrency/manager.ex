defmodule Ewbscp.Domain.Workflow.Concurrency.Manager do
  use GenServer

  @initial_concurrency 100
  @decrease_factor 0.8
  @increase_factor 1.2

  @spec start_link(atom()) :: GenServer.on_start()
  def start_link(name) do
    GenServer.start_link(__MODULE__, @initial_concurrency, name: name)
  end

  def get_concurrency(name) do
    GenServer.call(name, :get_current_concurrency)
  end

  def adjust_concurrency(name, adjustment) do
    GenServer.call(name, {:adjust_concurrency, adjustment})
  end

  @spec calculate_adjustment(atom(), integer()) :: integer()
  def calculate_adjustment(adjustment, state) do
    case adjustment do
      :increase -> state * @increase_factor
      :decrease -> state * @decrease_factor
      _ -> state
    end
  end

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_call({:adjust_concurrency, adjustment}, _, state) do
    new_state = calculate_adjustment(adjustment, state)
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call(:get_current_concurrency, _, state) do
    {:reply, state, state}
  end
end
