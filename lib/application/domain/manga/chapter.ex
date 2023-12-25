defmodule Ewbscp.Application.Domain.Manga.Chapter do
  @type t :: %__MODULE__{
          chapter_title: String.t(),
          chapter_link: String.t()
        }

  defstruct [:chapter_title, :chapter_link]
end
