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
  @disallowpaths ""
  @allowformats ""
  @token      ""
  @descrip    ""
  @urlusage    ""
  @customerId ""
  @userId ""
  @parserUrl ""
  @indexUrl ""
  @collectionName ""
  @timeout    5_000
  @user_agent "Crawler/#{Mixfile.project[:version]} (https://github.com/fredwu/crawler)"
  @url_filter Crawler.Fetcher.UrlFilter
  @retrier    Crawler.Fetcher.Retrier
  @modifier   Crawler.Fetcher.Modifier
  @scraper    Crawler.Scraper
  @parser     Crawler.Parser
  @encode_uri false
  @queue      nil

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
      disallowpaths: disallowpaths(),
      allowformats: allowformats(),
      token: token(),
      descrip: descrip(),
      urlusage: urlusage(),
      customerId: customerId(),
      userId: userId(),
      parserUrl: parserUrl(),
      indexUrl: indexUrl(),
      collectionName: collectionName(),
      timeout:    timeout(),
      user_agent: user_agent(),
      url_filter: url_filter(),
      retrier:    retrier(),
      modifier:   modifier(),
      scraper:    scraper(),
      parser:     parser(),
      encode_uri: encode_uri(),
      queue: queue(),
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
  def getdescrip(description) do
    if description == "" do
      body = "meta"
      body
    else
      description
    end
  end
  def getContent(contentType) do
    #b = ""
    b = {}
    #IO.puts "content typ is " <> "#{contentType}"
    if contentType == nil do
      b
    else
      map = %{'audio/aac' => {"aac"}, 'text/html' => {"htm", "html"}, 'application/x-abiword' => {"abw"}, 'video/x-msvideo' => {"avi"}, 'application/vnd.amazon.ebook' => {"azw"}, 'application/octet-stream' => {"bin", "arc"}, 'image/bmp' => {"bmp"}, 'application/x-bzip' => {"bz"}, 'application/x-bzip2' => {"bz2"}, 'application/x-csh' => {"csh"}, 'text/css' => {"css"}, 'text/csv' => {"csv"}, 'application/msword' => {"doc"}, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => {"docx"}, 'application/vnd.ms-fontobject' => {"eot"}, 'application/epub+zip' => {"epub"}, 'application/ecmascript' => {"es"}, 'image/gif' => {"gif"}, 'image/x-icon' => {"ico"}, 'text/calendar' => {"ics"}, 'application/java-archive' => {"jar"}, 'image/jpeg' => {"jpeg", "jpg"}, 'application/javascript' => {"js"}, 'application/json' => {"json"}, 'audio/midi' => {"mid", "midi"}, 'audio/x-midi' => {"mid", "midi"}, 'video/mpeg' => {"mpeg"}, 'application/vnd.apple.installer+xml' => {"mpkg"}, 'application/vnd.oasis.opendocument.presentation' => {"odp"}, 'application/vnd.oasis.opendocument.spreadsheet' => {"ods"}, 'application/vnd.oasis.opendocument.text' => {"odt"}, 'audio/ogg' => {"oga"}, 'video/ogg' => {"ogv"}, 'application/ogg' => {"ogx"}, 'font/otf' => {"otf"}, 'image/png' => {"png"}, 'application/pdf' => {"pdf"}, 'application/vnd.ms-powerpoint' => {"ppt"}, 'application/vnd.openxmlformats-officedocument.presentationml.presentation' => {"pptx"}, 'application/x-rar-compressed' => {"rar"}, 'application/rtf' => {"rtf"}, 'application/x-sh' => {"sh"}, 'image/svg+xml' => {"svg"}, 'application/x-shockwave-flash' => {"swf"}, 'application/x-tar' => {"tar"}, 'image/tiff' => {"tif", "tiff"}, 'application/typescript' => {"ts"}, 'font/ttf' => {"ttf"}, 'text/plain' => {"txt"}, 'application/vnd.visio' => {"vsd"}, 'audios/wav' => {"wav"}, 'audio/webm' => {"weba"}, 'video/webm' => {"webm"}, 'image/webp' => {"webp"}, 'font/woff' => {"woff"}, 'font/woff2' => {"woff2"}, 'application/xhtml+xml' => {"xhtml"}, 'application/vnd.ms-excel' => {"xls"}, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => {"xlsx"}, 'application/vnd.openxmlformats-officedocument.spreadsheetml.template' => {"xltx"}, 'application/xml' => {"xml"}, 'application/vnd.mozilla.xul+xml' => {"xul"}, 'application/zip' => {"zip"}, 'video/3gpp' => {"3gp"}, 'video/3gpp2' => {"3g2"}, 'audio/3gpp' => {"3gp"}, 'audio/3gpp2' => {"3g2"}, 'application/x-7z-compressed' => {"7z"}, 'application/x-gzip' => {"gz"}, 'message/rfc822' => {"eml"}, 'application/vnd.ms-word.document.macroenabled.12' => {"docm"}, 'application/vnd.ms-word.template.macroenabled.12' => {"dotm"}, 'application/vnd.openxmlformats-officedocument.wordprocessingml.template' => {"dotx"}, 'application/vnd.ms-powerpoint.template.macroenabled.12' => {"potm"}, 'application/vnd.openxmlformats-officedocument.presentationml.template' => {"potx"}, 'application/vnd.ms-powerpoint.addin.macroenabled.12' => {"ppam"}, 'application/vnd.ms-powerpoint.slideshow.macroenabled.12' => {"ppsm"}, 'application/vnd.openxmlformats-officedocument.presentationml.slideshow' => {"ppsx"}, 'application/vnd.ms-powerpoint.presentation.macroenabled.12' => {"pptm"}, 'application/vnd.ms-excel.addin.macroenabled.12' => {"xlam"}, 'application/vnd.ms-excel.sheet.binary.macroenabled.12' => {"xlsb"}, 'application/vnd.ms-excel.sheet.macroenabled.12' => {"xlsm"}, 'application/vnd.ms-excel.template.macroenabled.12' => {"xltm"}, 'application/vnd.ms-xpsdocument' => {"xps"}, 'image/vnd.dwg' => {"dwg"}, 'video/mp4' => {"mp4"}, 'audio/mpeg' => {"mp3"}, 'audio/x-aiff' => {"aiff"}, 'video/x-flv'=> {"flv"}, 'application/vnd.wordperfect' => {"wpd"}, 'image/vnd.adobe.photoshop' => {"psd"}, 'audio/x-wav' => {"wav"}}
      cont = Enum.at(value1(String.split("#{contentType}",";")),0)
      a = map['#{cont}']
      si = tuple_size(a)
      if si >= 2 do
        elem(a,1)
      else 
        if si == 1 do
          elem(a,0)
        else
          b
        end
      end
    end
  end
  def getContentNew(contentType) do
    #b = ""
    b = {}
    #IO.puts "content typ is " <> "#{contentType}"
    if contentType == nil do
      b
    else
      map = %{'audio/aac' => {"aac"}, 'text/html' => {"htm", "html"}, 'application/x-abiword' => {"abw"}, 'video/x-msvideo' => {"avi"}, 'application/vnd.amazon.ebook' => {"azw"}, 'application/octet-stream' => {"bin", "arc"}, 'image/bmp' => {"bmp"}, 'application/x-bzip' => {"bz"}, 'application/x-bzip2' => {"bz2"}, 'application/x-csh' => {"csh"}, 'text/css' => {"css"}, 'text/csv' => {"csv"}, 'application/msword' => {"doc"}, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => {"docx"}, 'application/vnd.ms-fontobject' => {"eot"}, 'application/epub+zip' => {"epub"}, 'application/ecmascript' => {"es"}, 'image/gif' => {"gif"}, 'image/x-icon' => {"ico"}, 'text/calendar' => {"ics"}, 'application/java-archive' => {"jar"}, 'image/jpeg' => {"jpeg", "jpg"}, 'application/javascript' => {"js"}, 'application/json' => {"json"}, 'audio/midi' => {"mid", "midi"}, 'audio/x-midi' => {"mid", "midi"}, 'video/mpeg' => {"mpeg"}, 'application/vnd.apple.installer+xml' => {"mpkg"}, 'application/vnd.oasis.opendocument.presentation' => {"odp"}, 'application/vnd.oasis.opendocument.spreadsheet' => {"ods"}, 'application/vnd.oasis.opendocument.text' => {"odt"}, 'audio/ogg' => {"oga"}, 'video/ogg' => {"ogv"}, 'application/ogg' => {"ogx"}, 'font/otf' => {"otf"}, 'image/png' => {"png"}, 'application/pdf' => {"pdf"}, 'application/vnd.ms-powerpoint' => {"ppt"}, 'application/vnd.openxmlformats-officedocument.presentationml.presentation' => {"pptx"}, 'application/x-rar-compressed' => {"rar"}, 'application/rtf' => {"rtf"}, 'application/x-sh' => {"sh"}, 'image/svg+xml' => {"svg"}, 'application/x-shockwave-flash' => {"swf"}, 'application/x-tar' => {"tar"}, 'image/tiff' => {"tif", "tiff"}, 'application/typescript' => {"ts"}, 'font/ttf' => {"ttf"}, 'text/plain' => {"txt"}, 'application/vnd.visio' => {"vsd"}, 'audios/wav' => {"wav"}, 'audio/webm' => {"weba"}, 'video/webm' => {"webm"}, 'image/webp' => {"webp"}, 'font/woff' => {"woff"}, 'font/woff2' => {"woff2"}, 'application/xhtml+xml' => {"xhtml"}, 'application/vnd.ms-excel' => {"xls"}, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => {"xlsx"}, 'application/vnd.openxmlformats-officedocument.spreadsheetml.template' => {"xltx"}, 'application/xml' => {"xml"}, 'application/vnd.mozilla.xul+xml' => {"xul"}, 'application/zip' => {"zip"}, 'video/3gpp' => {"3gp"}, 'video/3gpp2' => {"3g2"}, 'audio/3gpp' => {"3gp"}, 'audio/3gpp2' => {"3g2"}, 'application/x-7z-compressed' => {"7z"}, 'application/x-gzip' => {"gz"}, 'message/rfc822' => {"eml"}, 'application/vnd.ms-word.document.macroenabled.12' => {"docm"}, 'application/vnd.ms-word.template.macroenabled.12' => {"dotm"}, 'application/vnd.openxmlformats-officedocument.wordprocessingml.template' => {"dotx"}, 'application/vnd.ms-powerpoint.template.macroenabled.12' => {"potm"}, 'application/vnd.openxmlformats-officedocument.presentationml.template' => {"potx"}, 'application/vnd.ms-powerpoint.addin.macroenabled.12' => {"ppam"}, 'application/vnd.ms-powerpoint.slideshow.macroenabled.12' => {"ppsm"}, 'application/vnd.openxmlformats-officedocument.presentationml.slideshow' => {"ppsx"}, 'application/vnd.ms-powerpoint.presentation.macroenabled.12' => {"pptm"}, 'application/vnd.ms-excel.addin.macroenabled.12' => {"xlam"}, 'application/vnd.ms-excel.sheet.binary.macroenabled.12' => {"xlsb"}, 'application/vnd.ms-excel.sheet.macroenabled.12' => {"xlsm"}, 'application/vnd.ms-excel.template.macroenabled.12' => {"xltm"}, 'application/vnd.ms-xpsdocument' => {"xps"}, 'image/vnd.dwg' => {"dwg"}, 'video/mp4' => {"mp4"}, 'audio/mpeg' => {"mp3"}, 'audio/x-aiff' => {"aiff"}, 'video/x-flv'=> {"flv"}, 'application/vnd.wordperfect' => {"wpd"}, 'image/vnd.adobe.photoshop' => {"psd"}, 'audio/x-wav' => {"wav"}}
      cont = Enum.at(value1(String.split("#{contentType}",";")),0)
      a = map['#{cont}']
      si = tuple_size(a)
      #if si >= 2 do
       # elem(a,1)
      #else 
       # if si == 1 do
        #  elem(a,0)
        #else
#          b
        #end
      #end
      if si >= 1 do
        a
      else
        b
      end
    end
  end
  @spec value1(list) :: list
  def value1(x) do
    x
  end
  @spec value2(String.t()) :: String.t()
  def value2(x) do
    x
  end
  def indexingfunc(opts,url) do
    Application.ensure_all_started(:inets)

    # We should start `ssl` application also,
    # if we want to make secure requests:
    Application.ensure_all_started(:ssl)
    # IO.puts "Url is2 "
    urlnew = String.replace("#{url}"," ","%20")
    IO.puts "AAAAAAAAAAAAAAAAA"
    {:ok, {{'HTTP/1.1', returnCodep, _statep}, headers, _body1}} = :httpc.request(:get, {'#{urlnew}', []}, [], [])
    if returnCodep == 200 do
      IO.puts "BBBBBBBBBBB"
     #IO.puts "getting the url content type and last modified date"
    #IO.puts body1
    #IO.puts "header contenttype is"
    if headers != nil do
      IO.puts "CCCCCCCCCCCCC"
      contentType = getContentType(headers,0)
      lastmodified = getLastmodified(headers,0)
      cont = getContent(contentType)
      contnew = getContentNew(contentType)
      IO.puts opts.allowformats
      if checkFormat(opts,contnew) do
        IO.puts "DDDDDDDDDDD"
        #IO.puts contentType
        #IO.puts lastmodified
        #userAgent = opts.user_agent
        #IO.puts userAgent
        #IO.puts opts.token
        type = 'application/json'
        #body = "{\"name\":\"foo.example.com\"}"
        #body = "{\"customerId\":\"" <> customerId <> "\",\"collectionNames\":[\"" <> colname <> "\"],\"config\":{}}"
        #body = "{\"customerID\":\"" <> opts.customerId <> "\",\"url\":\"" <> url <> "\",\"useragent\":\"searchblox\",\"description\":" <> opts.descrip <> "}"
        descrip = getdescrip(opts.descrip)
  
        bodypar1 = "{\"customerID\":\"" <> opts.customerId <> "\",\"url\":\"" <> urlnew <> "\",\"useragent\":\"" <> opts.user_agent <> "\",\"description\":\"" <> descrip <> "\"}"
        body = checkContentType(cont,bodypar1,url)
        #body = "username=" <> authUsr <> "&password=" <> authPwd <> "&rememberMe=true"
        hTTPOptions = []
        options = []
        #IO.puts "WWWW"
        authcode = 'Bearer #{opts.token}'
        #IO.puts authcode
        {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers2, body2}}= :httpc.request(:post, {'#{opts.parserUrl}', [{'Authorization', authcode}], type, body}, hTTPOptions, options)
        #IO.puts body2
        IO.puts "EEEEEEEEEEEEEEEEEE"
        json2 = Poison.decode!(body2)
        #json = Poison.decode!(body1)
        title = json2["title"]
        content1 = json2["content"]
        #IO.puts "content1"
        c2 = String.replace(content1,"\n","\\\\n")
        #c3 = String.replace(c2,"(","")
        #c4 = String.replace(c3,")","")
        c1 = String.replace(c2,"\"","'")
        #IO.puts c4
        #c2 = String.replace(content1,"\"","\"")

   
        #IO.puts ~c(this is a string with "double" quotes, not 'single' ones)
        #IO.puts content1
        #c1 = ~s(#{c4})
        #c1 = String.replace(c2,"\n","\\\\n")
        #content = "Twitter. It's what's happening.We've detected that JavaScript is disabled in your browser. Would you like to proceed to legacy"
        keyword = json2["keyword"]
        #t1 = :calendar.local_time()
        #keyword = String.replace(keyword1,"\n","\\n")
        #keyword = "breaking news, news online, U.S. news, world news, developing story, news video, CNN news, weather, business, money, politics, law, technology, entertainment, education, travel, health, special reports, autos, CNN TV"
        size = json2["size"]
        size1 = "#{size}"
        description1 = json2["description"]
        description = String.replace(description1,"\"","'")
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
  
        #,\"indexdate\":\"" <> "#{t1}" <> "\",\"creationdate\":\"" <> t1 <> "\"
        bodynew1 = "{\"customerId\":\"" <> opts.customerId <> "\",\"url\":\"" <> url <> "\",\"userId\":" <> "#{opts.userId}" <> ",\"collectionName\":\"" <> opts.collectionName <> "\",\"contenttype\":\"" <> cont <> "\",\"title\":\"" <> title <> "\",\"language\":\"en\",\"uid\":\"" <> url <> "\",\"size\":\"" <> size1 <> "\"}"
        bodynew2 = checkkeyword(keyword,bodynew1)
        bodynew3 = checklastmodified(lastmodified,bodynew2)
        bodynew4 = checkdescription(description,bodynew3)
        bodynew5 = checkcanonicaltags(canonicalTags,bodynew4)
        bodynew = checkcontent(c1,bodynew5)
        #body = "username=" <> authUsr <> "&password=" <> authPwd <> "&rememberMe=true"
        #IO.puts bodynew

        #{:ok, {{'HTTP/1.1', 200, 'OK'}, _headers3, body3}}= :httpc.request(:post, {'http://35.190.153.15:9000/indexmanager/api/v1/collection/index/doc/add', [{'Authorization', authcode}], type, bodynew}, hTTPOptions, options)

        #IO.puts bodynew
        {:ok, {{'HTTP/1.1',_returnCode, _state}, _headers3, _body3}}= :httpc.request(:post, {'#{opts.indexUrl}', [{'Authorization', authcode}], type, bodynew}, hTTPOptions, options)

        IO.puts "Indexed: " <> url
        #IO.puts body3
        #IO.puts url
      end
    end
  else
    
    IO.puts "Skipped: " <> "#{returnCodep}" <> " " <> url
    
  end
  end
  def checkFormat(opts,cont) do
    n = Kernel.length(value1(String.split("#{opts.allowformats}",",")))
    if n > 0 && value2(Enum.at(value1(String.split(opts.allowformats,",")),n-1)) != "" do
      a = checkNew(Kernel.length(value1(String.split("#{opts.allowformats}",","))),tuple_size(cont),opts,cont,tuple_size(cont))
      a
    else
      true
    end
  end
  def checkNew(m,n,opts,cont,l) do
    a = value2(Enum.at(value1(String.split(opts.allowformats,",")),m-1))
    b = elem(cont,n-1)
    if a == b do
      true
    else
      if n-1 == 0 do
        checkNew(m-1,l,opts,cont,l)
      else
        checkNew(m,n-1,opts,cont,l)
      end
    end
  end
  def getContentType(headers,n) do
    #   IO.puts "in get"
    #  IO.puts n
    # IO.puts elem(Enum.at(headers,n),0)
    len1 = length(headers)
    if n < len1 do
      if elem(Enum.at(headers,n),0) == 'content-type' do
        #  IO.puts "trueeeeeeeeeeee"
        contentType = elem(Enum.at(headers,n),1)
        contentType
      else
        getContentType(headers,n+1)
      end
    end
  end
  def checklastmodified(lastmodified,bodynew1) do
    if lastmodified == "" do
      bodynew1
    else
      bodynew = String.replace(bodynew1,"}",",\"lastmodified\":\"" <> "#{lastmodified}" <> "\"}")
      bodynew
    end
  end
  def checkContentType(content,bodynew1,url) do
    if content != "" do
      bodynew = String.replace(bodynew1,"}",",\"type\":\"" <> content <> "\"}")
      bodynew
    else
      type1 = String.split(url,"/")
      s1 = length(type1)
      cont = Enum.at(value1(type1),s1-1)
      type2 = String.split(cont,".")
      s2 = length(type2)
      if s2 == 2 do
        bodynew = String.replace(bodynew1,"}",",\"type\":\"" <> Enum.at(value1(type2),1) <> "\"}")
        bodynew
      else
        bodynew = String.replace(bodynew1,"}",",\"type\":\"html\"}")
        bodynew
      end
    end

  end
  def checkdescription(description,bodynew1) do
    if description == "" do
      bodynew1
    else
      bodynew = String.replace(bodynew1,"}",",\"description\":\"" <> description <> "\"}")
      bodynew
    end

  end
  def checkcanonicaltags(canonicaltags,bodynew1) do
    if canonicaltags == nil do
      bodynew1
    else
      bodynew = String.replace(bodynew1,"}",",\"canonicalTags\":\"" <> canonicaltags <> "\"}")
      bodynew
    end
  end
  def checkcontent(content,bodynew1) do
    if content == "" do
      bodynew1
    else
      bodynew = String.replace(bodynew1,"}",",\"content\":\"" <> content <> "\"}")
      bodynew
    end

  end
  def checkkeyword(keyword,bodynew1) do
    if keyword == nil do

      bodynew1
    else

      bodynew = String.replace(bodynew1,"}",",\"keywords\":\"" <> keyword <> "\"}")
      bodynew
    end

  end
  def getLastmodified(headers,n) do
    len1 = length(headers)
    if n < len1 do
      if elem(Enum.at(headers,n),0) == 'last-modified' do
        # IO.puts "trueeeeeeeeeeee"
        contentType = elem(Enum.at(headers,n),1)
        contentType
      else
        getLastmodified(headers,n+1)
      end
    end
  end

  defp assets,     do: Application.get_env(:crawler, :assets,     @assets)
  defp save_to,    do: Application.get_env(:crawler, :save_to,    @save_to)
  defp workers,    do: Application.get_env(:crawler, :workers,    @workers)
  defp interval,   do: Application.get_env(:crawler, :interval,   @interval)
  defp max_depths, do: Application.get_env(:crawler, :max_depths, @max_depths)
  defp allowpaths, do: Application.get_env(:crawler, :allowpaths, @allowpaths)
  defp disallowpaths, do: Application.get_env(:crawler, :disallowpaths, @disallowpaths)
  defp allowformats, do: Application.get_env(:crawler, :allowformats, @allowformats)
  defp token,      do: Application.get_env(:crawler, :token, @token)
  defp descrip,    do: Application.get_env(:crawler, :descrip, @descrip)
  defp urlusage,    do: Application.get_env(:crawler, :urlusage, @urlusage)
  defp customerId, do: Application.get_env(:crawler, :customerId, @customerId)
  defp userId,     do: Application.get_env(:crawler, :userId, @userId)
  defp parserUrl,     do: Application.get_env(:crawler, :parserUrl, @parserUrl)
  defp indexUrl,     do: Application.get_env(:crawler, :indexUrl, @indexUrl)
  defp collectionName, do: Application.get_env(:crawler, :collectionName, @collectionName)
  defp timeout,    do: Application.get_env(:crawler, :timeout,    @timeout)
  defp user_agent, do: Application.get_env(:crawler, :user_agent, @user_agent)
  defp url_filter, do: Application.get_env(:crawler, :url_filter, @url_filter)
  defp retrier,    do: Application.get_env(:crawler, :retrier,    @retrier)
  defp modifier,   do: Application.get_env(:crawler, :modifier,   @modifier)
  defp scraper,    do: Application.get_env(:crawler, :scraper,    @scraper)
  defp parser,     do: Application.get_env(:crawler, :parser,     @parser)
  defp encode_uri, do: Application.get_env(:crawler, :encode_uri, @encode_uri)
  defp queue, do: Application.get_env(:crawler, :queue, @queue)
end
