defmodule Crawler.Dispatcher do
  @moduledoc """
  Dispatches requests to a queue for crawling.
  """

  @doc """
  Takes the `request` argument which is a tuple containing either:

  - `{_, link, _, url}` when it's a link that got transformed into a URL
  - `{_, url}` when it's a URL already

  And issues `Crawler.crawl/2` to initiate the crawl.
  """
  def dispatch(request, opts) do
    #IO.puts "in dispatch func for url " <> opts[:url]
    #deleteRegistry(opts[:url])
    case request do
      {_, _link, _, url} -> 
        Crawler.crawl(url, opts)
      {_, url}           -> 
        Crawler.crawl(url, opts)
    end
  end
  def deleteRegistry(url) do
    :ok = Registry.unregister(Crawler.Store.DB,url)

  end
end
