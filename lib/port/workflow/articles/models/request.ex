defmodule Port.Workflow.Articles.Models.Request do
  @type t :: %__MODULE__{
    uri: String.t()
  }

  defstruct [:uri]
end
