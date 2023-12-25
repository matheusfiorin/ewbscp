defmodule Ewbscp.Application.Workflow.CLI.MangaHandler do
  alias Ewbscp.Adapter.External.MangaKakalot, as: KakalotClient
  alias Ewbscp.Ports.Manga.MangaKakalot, as: KakalotPort

  def search_manga_title(search_term) do
    search_term
    |> KakalotClient.search_manga()
    |> KakalotPort.return_search_results()
  end
end
