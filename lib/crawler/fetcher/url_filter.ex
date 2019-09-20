defmodule Crawler.Fetcher.UrlFilter do
  @moduledoc """
  A placeholder module that lets all URLs pass through.
  """

  defmodule Spec do
    @moduledoc """
    Spec for defining an url filter.
    """

    @type url  :: String.t
    @type opts :: map

    @callback filter(url, opts) :: {:ok, boolean} | {:error, term}
  end

  @behaviour __MODULE__.Spec

  @doc """
  Whether to pass through a given URL.

  - `true` for letting the url through
  - `false` for rejecting the url
  """
  #def filter("https://www.searchblox.com" <> _, _opts), do: {:ok, true}
  #def filter(url, opts) do
	#	res = cond do
	#		String.starts_with?(url, ".") -> true
	#		String.starts_with?(url, "/") -> true
	#		Map.get(opts, :referrer_url) === nil -> true
	#		true ->
	#			URI.parse(opts.referrer_url) |> Map.get(:host) == URI.parse(url) |> Map.get(:host)
	#	end
	#	{:ok, res}
  #end
  def print_multiple_times(n,opts,url) when n <= 0 do
    if  String.starts_with?(url,value2(Enum.at(value1(String.split(opts.allowpaths,",")),n-1))) do
      #IO.puts "true in print func"
    true
    else
     # IO.puts "false in print func11"
      false
    end
 end

 def print_multiple_times(n,opts,url) do
    if String.starts_with?(url,value2(Enum.at(value1(String.split(opts.allowpaths,",")),n-1))) do
      #IO.puts "true in print func"  
    true
      else
        #IO.puts "false in print func22"
       print_multiple_times(n - 1,opts,url)
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
  def filter(url, opts) do
    
    #IO.puts "inside filter func"
   if print_multiple_times(Kernel.length(value1(String.split("#{opts.allowpaths}",","))),opts,url) do
     # IO.puts "condition is true inside filter returing true"
     IO.puts "yes " <> url
     #Crawler.Options.indexingfunc(opts,url)
    {:ok, true}
    else 
      IO.puts "no " <> url
      #Crawler.Options.indexingfunc(opts,url)
     # IO.puts "condition is false inside filter returingin false"
    {:ok, false}
    end
  end
  #def filter(_, _), do: {:ok, false}
end
