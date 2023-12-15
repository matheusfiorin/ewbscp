defmodule Article do
  defstruct article: nil, references: []
end

defimpl String.Chars, for: Article do
  def to_string(article) do
    "Article: #{article.article}\nReferences: #{Enum.join(article.references, ", ")}"
  end
end
