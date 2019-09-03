defmodule CustomFilter do
  @behaviour Crawler.Fetcher.UrlFilter.Spec
  def filter(url, _opts) do
    if String.starts_with?(url, "www.searchblox.com") do
      {:ok, true}
    else 
      {:ok, false}
    end
  end
end