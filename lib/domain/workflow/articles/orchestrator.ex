defmodule Ewbscp.Domain.Workflow.Articles.Orchestrator do
  alias Ewbscp.Port.Workflow.Articles.Internal.URIArticle
  alias Ewbscp.Domain.Workflow.Concurrency.Manager, as: ConcurrencyManager

  def fetch_article_by_uri(uri) do
    # Benchmark code to be removed
    memory_before = :erlang.memory(:total)
    ConcurrencyManager.start_link(:wikipedia)

    URIArticle.fetch_article_from_wikipedia(uri)

    memory_after = :erlang.memory(:total)
    memory_used = memory_after - memory_before
    IO.puts("Memory used: #{Float.round(memory_used / 1024 / 1024, 2)}MBs")
  end
end
