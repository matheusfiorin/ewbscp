defmodule CLI do
  def main(args) do
    parsed = args |> OptionParser.parse(strict: [allow_empty: :boolean])

    with {options, [command_str | command_args], []} <- parsed,
         true <- CLICommand.valid_command?(String.to_atom(command_str)) do
      cli_command = %CLICommand{command: String.to_atom(command_str), args: {command_args, options}}
      CLIHandler.handle_command(cli_command)
    else
      _ ->
        IO.puts("Invalid or unknown command")
        System.halt(1)
    end
  end
end
