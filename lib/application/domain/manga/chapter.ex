defmodule Ewbscp.Application.Domain.Manga.Chapter do
  @type t :: %__MODULE__{
          chapter_title: String.t(),
          page_links: String.t()
        }

  defstruct [:chapter_title, :page_links]
end
