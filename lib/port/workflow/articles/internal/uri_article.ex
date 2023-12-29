defmodule Ewbscp.Port.Workflow.Articles.Internal.URIArticle do
  alias Ewbscp.Domain.Entities.Article
  alias Ewbscp.Clients.Article, as: ArticleClient

  def fetch_article_from_wikipedia(uri, depth \\ 3) do
    if depth <= 0 do
      # Base case for recursion: return empty article when depth is exhausted
      %Article{}
    else
      # Fetch and process main article
      main_article_html = ArticleClient.fetch_wikipedia_page(uri, 3)
      main_article = wikipedia_to_article(main_article_html)

      # Fetch and process references recursively
      references = ArticleClient.fetch_references(main_article.references)

      processed_references =
        Enum.map(references, fn ref_uri ->
          fetch_article_from_wikipedia(ref_uri, depth - 1)
        end)

      # Return article with processed references
      %Article{main_article | references: processed_references}
    end
  end

  defp wikipedia_to_article(html) do
    with {:ok, parsed_document} <- Floki.parse_document(html) do
      article = format_document(parsed_document)

      references =
        html
        |> Floki.find(".mw-parser-output a[href]")
        |> Enum.map(fn a -> Floki.attribute(a, "href") end)
        |> List.flatten()
        |> Enum.filter(&valid_reference?/1)
        |> Enum.map(&normalize_reference/1)

      %Article{article: article, references: Enum.take(references, 300)}
    end
  end

  defp format_document(parsed_document) do
    parsed_document
    |> Floki.find(".mw-parser-output p")
    |> Enum.map(&Floki.text/1)
    |> Enum.join(" ")
    |> remove_square_bracket_contents()
  end

  defp remove_square_bracket_contents(text) do
    Regex.replace(~r/\[[^\]]*\]/, text, "")
  end

  defp valid_reference?(ref) do
    not is_reference_citation(ref)
  end

  defp is_reference_citation(ref) do
    String.contains?(ref, ["cite_note", "cite_ref", "CITEREF"])
  end

  defp normalize_reference(ref) do
    if String.starts_with?(ref, "http"), do: ref, else: "https://www.wikipedia.org" <> ref
  end
end
