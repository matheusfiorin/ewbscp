defmodule Ewbscp.Ports.Manga.MangaKakalot do
  @moduledoc """
  This module serves as the layer to transform the data into something that makes sense to our Application Core.
  These functions specifically will handle the web scrapping of the pages from the specific source - MangaKakalot website - and transforms them
  into Manga Structs and Chapter structs, to be used later in the workflow of the application
  """

  alias Ewbscp.Application.Domain.Manga.SearchResult

  def return_search_results(manga_search_results) do
    with {:ok, parsed_document} <- Floki.parse_document(manga_search_results) do
      parsed_document
      |> Floki.find(".panel_story_list > .story_item > .story_item_right > h3 > a")
      |> Enum.map(fn {_, [_, {_, manga_uri}], [manga_title]} ->
        %SearchResult{manga_uri: manga_uri, manga_title: manga_title}
      end)
    end
  end

  def return_chapters_list(manga_title_page) do
    with {:ok, parsed_document} <- Floki.parse_document(manga_title_page) do
      parsed_document
      |> Floki.find(".manga-info-chapter > .chapter-list > .row > span > a")
      |> Enum.map(fn {_, [{_, chapter_link}, {_, _}], _} ->
        chapter_link
      end)
      |> Enum.reverse()
    end
  end

  # To do: format the chapter title
  defp get_chapter_title(chapter_page) do
    with {:ok, parsed_document} <- Floki.parse_document(chapter_page) do
      parsed_document
      |> Floki.find(".info-top-chapter > h2")
    end
  end

  def return_pages_from_chapter(chapter_page) do
    with {:ok, parsed_document} <- Floki.parse_document(chapter_page) do
      parsed_document
      |> Floki.find(".vung-doc > img")
      |> Floki.attribute("data-src")
    end
  end
end
