defmodule Ewbscp.Adapter.External.MangaKakalot do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://ww7.mangakakalot.tv")

  # returns the page with the search results (this would be a list of links to be presented to the user)
  def search_manga(manga_title) do
    case get("/search/" <> manga_title) do
      {:ok, %{status: 200, body: body}} ->
        body

      {:error, reason} ->
        {:error, reason}

      _ ->
        {:error, :unknown}
    end
  end

  def get_manga_main_page(manga_main_page_uri) do
    case get(manga_main_page_uri) do
      {:ok, %{status: 200, body: body}} ->
        body

      {:error, reason} ->
        {:error, reason}

      _ ->
        {:error, :unknown}
    end
  end

  def get_chapter_page(chapter_link) do
    case get(chapter_link) do
      {:ok, %{status: 200, body: body}} ->
        body

      {:error, reason} ->
        {:error, reason}

      _ ->
        {:error, :unknown}
    end
  end
end
