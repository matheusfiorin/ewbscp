defmodule Ewbscp.Domain.Entities.URI do
  @type t :: %__MODULE__{
    uri: String.t()
  }

  defstruct [:uri]
end
