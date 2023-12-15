defmodule CLIHandler do
  def handle_command(%CLICommand{command: :directory_size, args: {files, options}}) do
    DirectoryHandler.handle_list_directory_size(files, options)
  end

  def handle_command(%CLICommand{command: :fetch_wikipedia_page, args: {uri, _}}) do
    memory_before = :erlang.memory(:total)
    WikipediaHandler.handle_wikipedia_article(uri)
    memory_after = :erlang.memory(:total)

    memory_used = memory_after - memory_before
    IO.puts("Memory used: #{memory_used} bytes")
  end

  def handle_command(%CLICommand{}) do
    IO.puts("Unknown command.")
    IO.puts("Run 'make help' to see what you can do.")
    System.halt(1)
  end
end
