defmodule Weather.CLI do
  require Logger
  import Weather.TableFormatter, only: [ print_table_for_columns: 2]
  @moduledoc """
  Handles the command line parsing and the 
  dispatch to various functions
  """
  def main(argv) do
    argv
      |> parse_args
      |> process
  end
  
  @doc """
  `argv` can be -h or --help, which returns :help
  otherwise, it is the airport shortname that we want weather for
  ## Examples
      iex> Weather.CLI.parse_args(["-h", "anything"])
      :help
      iex> Weather.CLI.parse_args(["--help", "anything"])
      :help
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases:  [h:    :help   ])
    case parse do
      { [ help: true], _, _}
      -> :help
      {_, [ airport ], _ }
      -> {airport}
      _ -> :help
    end
  end
  
  @doc """
  Calls the library method to do the work
  ## Examples
      iex> Weather.CLI.process(:help)
      "usage: weather <airport code>"
  """
  def process(:help) do
    IO.puts """
    usage: weather <airport code>
    """
    System.halt(0)
  end
  
  def process({airport}) do
    Weather.GovApi.fetch(airport)
      |> decode_response
      |> convert_to_hashdict
      |> print_table_for_columns([:location,:weather,:temperature])
  end
  
  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    Logger.error "Error fetching from Gov API: #{message}"
    System.halt(2)
  end
  
  def convert_to_hashdict doc do
    location = Exml.get doc, "location"
    weather = Exml.get doc, "weather"
    temp = Exml.get doc, "temp_f"
    Logger.debug "location: #{location}"
    [[{:location, location}, {:weather, weather}, {:temperature, temp}]]
      |> Enum.map(&Enum.into(&1,HashDict.new))
  end
end
