defmodule CLI do
  def main(args) do
    parsed = args |> OptionParser.parse(strict: [allow_empty: :boolean])

    with {options, [command | command_args], []} <- parsed do
      cli_command = %CLICommand{command: command, args: {command_args, options}}
      CLIHandler.handle_command(cli_command)
    else
      _ ->
        IO.puts("Invalid input")
        System.halt(1)
    end
  end
end
