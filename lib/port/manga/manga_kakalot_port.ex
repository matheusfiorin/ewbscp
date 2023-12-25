defmodule Ewbscp.Ports.Manga.MangaKakalot do

  @moduledoc """
  This module serves as the layer to transform the data into something that makes sense to our Application Core.
  These functions specifically will handle the web scrapping of the pages from the specific source - MangaKakalot website - and transforms them
  into Manga Structs and Chapter structs, to be used later in the workflow of the application
  """

  alias Ewbscp.Application.Domain.Manga.Manga

  def return_search_results(manga_search_results) do
    with {:ok, parsed_document} <- Floki.parse_document(manga_search_results) do
      parsed_document
      |> Floki.find(".panel_story_list > .story_item > .story_item_right > h3 > a")
      |> Enum.map(fn {_, [_, {_, manga_uri}], [manga_title]} ->
        %Manga{manga_uri: manga_uri, manga_title: manga_title}
      end)
    end
  end

  def find_chapters_list(manga_title_page) do
  end

  def find_pages_links(manga_chapter_page) do
  end
end
