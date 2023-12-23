defmodule Ewbscp.Adapter.External.MangaKakalot do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://ww7.mangakakalot.tv")
  plug(Tesla.Middleware.Headers, [{"authorization", "token xyz"}])
  plug(Tesla.Middleware.JSON)

  # returns the page with the search results (this would be a list of links to be presented to the user)
  def search_manga(manga_title) do
    case get("/search/" <> manga_title) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}

      {:error, reason} ->
        {:error, reason}

      _ ->
        {:error, :unknown}
    end
  end

  def get_chapter_pages() do
    # this little guy will download the pages from the "opened" chapter
    # it can be a generic function, because the download is the same for every manga source anyways 
  end
end
