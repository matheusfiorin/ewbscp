defmodule ArticlePort do
  def wikipedia_to_article(html) do
    article =
      html
      |> Floki.parse_document()
      |> Floki.find(".mw-parser-output p")
      |> Enum.map(&Floki.text/1)
      |> Enum.join(" ")
      |> remove_square_bracket_contents()

    references =
      html
      |> Floki.find(".mw-parser-output a[href]")
      |> Enum.map(fn a -> Floki.attribute(a, "href") end)
      |> List.flatten()
      |> Enum.filter(&valid_reference?/1)
      |> Enum.map(&normalize_reference/1)

    %Article{article: article, references: Enum.take(references, 300)}
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
