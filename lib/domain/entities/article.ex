defmodule Ewbscp.Domain.Entities.Article do
  @type t :: %__MODULE__{
    article: String.t(),
    references: List.t(),
  }

  defstruct [article: nil, references: []]
end

defimpl String.Chars, for: Ewbscp.Domain.Entities.Article do
  def to_string(article) do
    "Article: #{article.article}\nReferences: #{Enum.join(article.references, ", ")}"
  end
end
