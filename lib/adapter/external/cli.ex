defmodule CLI do
  def main(args) do
    parsed =
      args
      |> OptionParser.parse(strict: [allow_empty: :boolean])

    with {options, [directory], []} <- parsed,
         true <- File.dir?(directory),
         {:ok, files} <- list_files(directory) do
      Enum.reduce(files, 0, fn file, size -> size + calculate_file_size(file) end)
      |> print_size(files, options)
    else
      _ ->
        IO.puts("Invalid input")
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
	    files =
          files
          |> Enum.map(&Path.join(directory, &1))
          |> Enum.reject(&File.dir?/1)

		{:ok, files}

      error ->
        error
    end
  end

  defp calculate_file_size(file) do
    file
    |> File.stat!()
    |> Map.get(:size)
  end
end
