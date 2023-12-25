defmodule Ewbscp.Application.Domain.Manga.Manga do
  @type t :: %__MODULE__{
          manga_uri: String.t(),
          manga_title: String.t()
        }

  defstruct [:manga_uri, :manga_title]
end
