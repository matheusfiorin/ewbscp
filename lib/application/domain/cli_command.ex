defmodule CLICommand do
  defstruct [:command, :args]

  @valid_commands [:directory_size, :another_command]
  def valid_command?(command), do: command in @valid_commands
end
