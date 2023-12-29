defmodule Ewbscp.Clients.Article do
  alias Ewbscp.Domain.Workflow.Concurrency.Manager, as: ConcurrencyManager
  alias Ewbscp.Clients.HTTP.Wikipedia, as: WikipediaClient

  def fetch_wikipedia_page(uri, attempts) do
    case WikipediaClient.fetch_content(uri) do
      {:ok, content} ->
        ConcurrencyManager.adjust_concurrency(:wikipedia, :increase)
        content

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

  def fetch_references(references) do
    unique_references = Enum.uniq(references)
    concurrency = ConcurrencyManager.get_concurrency(:wikipedia)

    IO.puts("initial references: #{Enum.count(unique_references)}")
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
