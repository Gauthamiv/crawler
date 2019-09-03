defmodule CustomFilter do
    @behaviour Crawler.Fetcher.UrlFilter.Spec
  def filter("https://www.searchblox.com" <> _, _opts), do: {:ok, true}
  def filter(_, _), do: {:ok, false}
end