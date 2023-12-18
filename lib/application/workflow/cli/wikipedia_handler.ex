defmodule WikipediaHandler do
  def handle_wikipedia_article(uri) do
    main_article = fetch_wikipedia_page(uri, 3)
    references = fetch_references(main_article.references)
    IO.puts("fetched refs: #{Enum.count(references)}")
  end

  defp fetch_wikipedia_page(uri, attempts) do
    case Wikipedia.fetch_content(uri) do
      {:ok, content} ->
	ConcurrencyManager.adjust_concurrency(:wikipedia, :increase)
        ArticlePort.wikipedia_to_article(content)

      {:error, reason} ->
        if attempts > 0 do
          ConcurrencyManager.adjust_concurrency(:wikipedia, :decrease)
          :timer.sleep(500)
          fetch_wikipedia_page(uri, attempts - 1)
        else
          IO.puts("Error: #{reason}")
        end
    end
  end

  defp fetch_references(references) do
    unique_references = Enum.uniq(references)
    concurrency = ConcurrencyManager.get_concurrency(:wikipedia)

    IO.puts("initial concurrency: #{concurrency}")

    Task.async_stream(
      unique_references,
      fn uri -> fetch_wikipedia_page(uri, 3) end,
      concurrency: concurrency,
      timeout: 120_000
    )
    |> Enum.to_list()
  end
end
