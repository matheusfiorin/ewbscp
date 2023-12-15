defmodule CLIHandler do
  def handle_command(%CLICommand{command: directory, args: {_, options}}) do
    if File.dir?(directory) do
      case list_files(directory) do
        {:ok, files} ->
          total_size = Enum.reduce(files, 0, &(&2 + calculate_file_size(&1)))
          print_size(total_size, files, options)

        :error ->
          IO.puts("Error listing files")
          System.halt(1)
      end
    else
      IO.puts("Invalid directory")
      System.halt(1)
    end
  end

  defp print_size(0, _, options) do
    case Keyword.get(options, :allow_empty) do
      true ->
        IO.puts("0")

      _ ->
        IO.puts("Empty directory")
        System.halt(1)
    end
  end

  defp print_size(total_size, files, _) do
    IO.puts(div(total_size, length(files)))
  end

  defp list_files(directory) do
    case File.ls(directory) do
      {:ok, files} ->
        files
        |> Enum.map(&Path.join(directory, &1))
        |> Enum.reject(&File.dir?/1)
        |> then(fn files -> {:ok, files} end)

      error -> error
    end
  end

  defp calculate_file_size(file) do
    file
    |> File.stat!()
    |> Map.get(:size)
  end
end
