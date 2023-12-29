defmodule Ewbscp.Port.Workflow.Articles.Models.ArticleRequest do
  @type t :: %__MODULE__{
    uri: String.t()
  }

  defstruct [:uri]
end
