defmodule Ewbscp.Ports.Manga.MangaKakalot do
  def return_search_results(manga_search_results) do
    manga_search_results
    |> Floki.find(".panel_story_list > .story_item > .story_item_right > h3 > a")
    |> Enum.map(fn {_, [_, {_, manga_uri}], [manga_title]} ->
     %{manga_uri: manga_uri, manga_title: manga_title} 
    end)
  end

  def find_chapters_list(manga_title_page) do
  end

  def find_pages_links(manga_chapter_page) do
  end
end
