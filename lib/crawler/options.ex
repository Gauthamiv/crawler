defmodule Crawler.Options do
  @moduledoc """
  Options for the crawler.
  """

  alias Crawler.Mixfile

  @assets     []
  @save_to    nil
  @workers    10
  @interval   0
  @max_depths 3
  @allowpaths ""
  @token      ""
  @descrip    ""
  @urlusage    ""
  @customerId ""
  @userId ""
  @collectionName ""
  @timeout    5_000
  @user_agent "Crawler/#{Mixfile.project[:version]} (https://github.com/fredwu/crawler)"
  @url_filter Crawler.Fetcher.UrlFilter
  @retrier    Crawler.Fetcher.Retrier
  @modifier   Crawler.Fetcher.Modifier
  @scraper    Crawler.Scraper
  @parser     Crawler.Parser
  @encode_uri false

  @doc """
  Assigns default option values.

  ## Examples

      iex> Options.assign_defaults(%{}) |> Map.has_key?(:depth)
      true

      iex> Options.assign_defaults(%{}) |> Map.get(:max_depths)
      3

      iex> Options.assign_defaults(%{max_depths: 4}) |> Map.get(:max_depths)
      4
  """
  def assign_defaults(opts) do
    Map.merge(%{
      depth:      0,
      html_tag:   "a",
      assets:     assets(),
      save_to:    save_to(),
      workers:    workers(),
      interval:   interval(),
      max_depths: max_depths(),
      allowpaths: allowpaths(),
      token: token(),
      descrip: descrip(),
      urlusage: urlusage(),
      customerId: customerId(),
      userId: userId(),
      collectionName: collectionName(),
      timeout:    timeout(),
      user_agent: user_agent(),
      url_filter: url_filter(),
      retrier:    retrier(),
      modifier:   modifier(),
      scraper:    scraper(),
      parser:     parser(),
      encode_uri: encode_uri(),
    }, opts)
  end

  @doc """
  Takes the `url` argument and puts it in the `opts`.

  The `opts` map gets passed around internally and eventually gets stored in
  the registry.

  ## Examples

      iex> Options.assign_url(%{}, "http://options/")
      %{url: "http://options/"}

      iex> Options.assign_url(%{url: "http://example.com/"}, "http://options/")
      %{url: "http://options/"}
  """
  def assign_url(%{encode_uri: true} = opts, url) do
  #IO.puts "Url is1 "
  #IO.puts "1" <> url
  
  Map.merge(opts, %{url: URI.encode(url)})
  #indexingfunc(opts,URI.encode(url))
  end
  def assign_url(opts, url) do
   # IO.puts "2" <> url
    
    #{:ok,abc} = Map.fetch(opts,:urlusage)
    #IO.puts abc
    #def = abc <> "," <> url
   # defn = Map.put(opts, :urlusage,def)
  # indexingfunc(opts,url)
    Map.merge(opts, %{url: url})
  end
  
  def indexingfunc(opts,url) do
    Application.ensure_all_started(:inets)

    # We should start `ssl` application also,
    # if we want to make secure requests:
    Application.ensure_all_started(:ssl)
 # IO.puts "Url is2 "
  
 
  {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, _body1}} = :httpc.request(:get, {'#{url}', []}, [], [])
  #IO.puts "getting the url content type and last modified date"
#IO.puts body1
#IO.puts "header contenttype is"
#################contentType = getContentType(headers,0)
#lastmodified = getLastmodified(headers,0)
#IO.puts contentType
#IO.puts lastmodified
#userAgent = opts.user_agent
#IO.puts userAgent
#IO.puts opts.token
type = 'application/json'
  #body = "{\"name\":\"foo.example.com\"}"
  #body = "{\"customerId\":\"" <> customerId <> "\",\"collectionNames\":[\"" <> colname <> "\"],\"config\":{}}"
  #body = "{\"customerID\":\"" <> opts.customerId <> "\",\"url\":\"" <> url <> "\",\"useragent\":\"searchblox\",\"description\":" <> opts.descrip <> "}"
  body = "{\"customerID\":\"" <> opts.customerId <> "\",\"url\":\"" <> url <> "\",\"useragent\":\"" <> opts.user_agent <> "\",\"description\":\"meta\"}"
  #body = "username=" <> authUsr <> "&password=" <> authPwd <> "&rememberMe=true"
  hTTPOptions = []
  options = []
 # IO.puts body
  #IO.puts "WWWW"
  authcode = 'Bearer #{opts.token}'
  #IO.puts authcode
  {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers2, body2}}= :httpc.request(:post, {'http://35.190.153.15:9000/parser/api/v1/parse', [{'Authorization', authcode}], type, body}, hTTPOptions, options)
  #IO.puts body2
  json2 = Poison.decode!(body2)
  #json = Poison.decode!(body1)
  title = json2["title"]
  content1 = json2["content"]
  #IO.puts "content1"
  #IO.puts content1
  c1 = String.replace(content1,"\n","\\n")
  #IO.puts c1
  #content = "Twitter. It's what's happening.We've detected that JavaScript is disabled in your browser. Would you like to proceed to legacy"
  #keyword = json2["keyword"]
  keyword = "breaking news, news online, U.S. news, world news, developing story, news video, CNN news, weather, business, money, politics, law, technology, entertainment, education, travel, health, special reports, autos, CNN TV"
  #size = json2["size"]
  description = json2["description"]
  canonicalTags = json2["canonicalTags"]
  #category = json2["category"]
  #author = json2["author"]
  #subject = json2["subject"]
  #robotsMetaTags = json2["robotsMetaTags"]
  #meta = json2["meta"]
  #  "collectionName": "col1",
  #  "userId": 201,
  #  "filename": [],
  #  "lastmodified": "16 Aug 2018 10:12:52 UTC",
  #  "indexdate": "16 Aug 2018 10:12:53 UTC",
  #  "creationdate": "16 Aug 2018 10:12:53 UTC",
  #  "urllen": "24",
  
  # start indexing
  #"\",\"author\":\"" <> author <> "\",\"subject\":\"" <> subject <>
  #
  #"\",\"category\":\"" <> category <>  
  #"\",\"size\":\"" <> size <> 
  #"\",\"meta\":" <> meta <> 
  bodynew = "{\"customerId\":\"" <> opts.customerId <> "\",\"url\":\"" <> url <> "\",\"userId\":201,\"collectionName\":\"" <> opts.collectionName <> "\",\"contenttype\":\"HTML\",\"content\":\"" <> c1 <> "\",\"title\":\"" <> title <> "\",\"language\":\"en\",\"description\":\"" <> description <> "\",\"keywords\":\"" <> keyword <> "\",\"uid\":\"" <> url <> "\",\"canonicalTags\":\"" <> canonicalTags <> "\"}"
  #body = "username=" <> authUsr <> "&password=" <> authPwd <> "&rememberMe=true"
  #IO.puts bodynew

  #{:ok, {{'HTTP/1.1', 200, 'OK'}, _headers3, body3}}= :httpc.request(:post, {'http://35.190.153.15:9000/indexmanager/api/v1/collection/index/doc/add', [{'Authorization', authcode}], type, bodynew}, hTTPOptions, options)
  
  {:ok, {{'HTTP/1.1',_returnCode, _state}, _headers3, _body3}}= :httpc.request(:post, {'http://35.190.153.15:9000/indexmanager/api/v1/collection/index/doc/add', [{'Authorization', authcode}], type, bodynew}, hTTPOptions, options)
  #IO.puts returnCode
 #IO.puts body3
 #IO.puts url
  end
  def getContentType(headers,n) do
 #   IO.puts "in get"
  #  IO.puts n
   # IO.puts elem(Enum.at(headers,n),0)
    if elem(Enum.at(headers,n),0) == 'content-type' do
    #  IO.puts "trueeeeeeeeeeee"
    contentType = elem(Enum.at(headers,n),1)
      contentType
    else
      getContentType(headers,n+1)
  end
end
def getLastmodified(headers,n) do
  #IO.puts "in get last"
  #IO.puts n
  #IO.puts elem(Enum.at(headers,n),0)
  if elem(Enum.at(headers,n),0) == 'last-modified' do
   # IO.puts "trueeeeeeeeeeee"
  contentType = elem(Enum.at(headers,n),1)
    contentType
  else
    getLastmodified(headers,n+1)
end
end
  defp assets,     do: Application.get_env(:crawler, :assets,     @assets)
  defp save_to,    do: Application.get_env(:crawler, :save_to,    @save_to)
  defp workers,    do: Application.get_env(:crawler, :workers,    @workers)
  defp interval,   do: Application.get_env(:crawler, :interval,   @interval)
  defp max_depths, do: Application.get_env(:crawler, :max_depths, @max_depths)
  defp allowpaths, do: Application.get_env(:crawler, :allowpaths, @allowpaths)
  defp token,      do: Application.get_env(:crawler, :token, @token)
  defp descrip,    do: Application.get_env(:crawler, :descrip, @descrip)
  defp urlusage,    do: Application.get_env(:crawler, :urlusage, @urlusage)
  defp customerId, do: Application.get_env(:crawler, :customerId, @customerId)
  defp userId,     do: Application.get_env(:crawler, :userId, @userId)
  defp collectionName, do: Application.get_env(:crawler, :collectionName, @collectionName)
  defp timeout,    do: Application.get_env(:crawler, :timeout,    @timeout)
  defp user_agent, do: Application.get_env(:crawler, :user_agent, @user_agent)
  defp url_filter, do: Application.get_env(:crawler, :url_filter, @url_filter)
  defp retrier,    do: Application.get_env(:crawler, :retrier,    @retrier)
  defp modifier,   do: Application.get_env(:crawler, :modifier,   @modifier)
  defp scraper,    do: Application.get_env(:crawler, :scraper,    @scraper)
  defp parser,     do: Application.get_env(:crawler, :parser,     @parser)
  defp encode_uri, do: Application.get_env(:crawler, :encode_uri, @encode_uri)
end
