defmodule WikipediaHandler do
  # TODO - rethink handle naming
  def handle_wikipedia_article(uri) do
    main_article = fetch_wikipedia_page(uri)
    references = fetch_references(main_article.references)
    IO.puts("refs: #{Enum.count(references)}")
  end

  defp fetch_wikipedia_page(uri) do
    case Wikipedia.fetch_content(uri) do
      {:ok, content} -> ArticlePort.wikipedia_to_article(content)
      {:error, reason} ->
	IO.puts("Error: #{reason}")
    end
  end

  defp fetch_wikipedia_page_r(uri, attempts) do
    case Wikipedia.fetch_content(uri) do
      {:ok, content} -> ArticlePort.wikipedia_to_article(content)
      {:error, reason} ->
	if(attempts > 0) do
	  Process.sleep(1000)
	  fetch_wikipedia_page_r(uri, attempts - 1)
	else
	  IO.puts("Error: #{reason}")
	end
    end
  end

  defp fetch_references(references) do
    unique_references = Enum.uniq(references)

    Task.async_stream(unique_references, fn uri -> fetch_wikipedia_page_r(uri, 3) end, max_concurrency: 500)
    |> Enum.to_list()
  end
end
