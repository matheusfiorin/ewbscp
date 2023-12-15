defmodule CLICommand do
  defstruct [:command, :args]

  @valid_commands [:directory_size, :fetch_wikipedia_page]
  def valid_command?(command), do: command in @valid_commands
end
