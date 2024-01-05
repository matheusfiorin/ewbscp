defmodule Ewbscp.Entrypoints.CLI.Input do
  alias Ewbscp.Entrypoints.CLI.Command
  alias Ewbscp.Entrypoints.CLI.Orchestrator

  def main(args) do
    parsed = args |> OptionParser.parse(strict: [allow_empty: :boolean])

    with {options, [command_str | command_args], []} <- parsed,
         true <- Command.valid_command?(String.to_atom(command_str)) do
      cli_command = %Command{command: String.to_atom(command_str), args: {command_args, options}}
      Orchestrator.orchestrate_command(cli_command)
    else
      _ ->
        IO.puts("Invalid or unknown command")
        System.halt(1)
    end
  end
end
