defmodule Ewbscp.Clients.HTTP.Wikipedia do
  use Tesla

  plug Tesla.Middleware.FollowRedirects
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"User-Agent", "YourCustomUserAgent"}]

  def fetch_content(uri) do
    case get(uri) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}
      {:error, reason} ->
        {:error, reason}
      _ ->
	{:error, :nu}
    end
  end
end
