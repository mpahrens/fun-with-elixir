defmodule Issues.TableFormatter do

  import Enum, only: [each: 2, map: 2, map_join: 3, max: 1 ]

  @doc """
  Takes a list of row data, where each row is a HashDict, and a list of
  headers. Prints a table to STDOUT of the data from each row
  identified by each header. E.g. each header identifies a column,
  and those columns are extracted and printed from the rows.
  We calculate the width of each column to fit the longest element
  in that column.
  """
  def print_table_for_columns(rows, headers) do
    data_by_columns  = split_into_columns(rows,headers)
    columns_width = widths_of(data_by_columns)
    format = format_for(columns_width)

    puts_one_line_in_columns headers, format
    IO.puts                  separator(columns_width)
    puts_in_columns          data_by_columns, format
  end

  @doc """
  Given a list of rows, where each row contains a keyed list
  of columns, return a list containing lists of the data in
  each column. The `headers` parameter contains the list 
  of columns to extracted
  
  ## Examples
  
  
      iex> list = [Enum.into([{"a", "1"}, {"b","2"}, {"c", "3"}], HashDict.new),
      ...>         Enum.into([{"a", "4"}, {"b","5"}, {"c", "6"}], HashDict.new)]
      iex> Issues.TableFormatter.split_into_columns(list, ["a", "b", "c" ])
      [ ["1", "4"], ["2","5"], ["3", "6"] ]
    
    
  """
  def split_into_columns(rows,headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header])
    end
  end
  @doc """
  Return a binary (string) version of our parameter.
  
  ## Examples
  
      iex> Issues.TableFormatter.printable("a")
      "a"
      iex> Issues.TableFormatter.printable(99)
      "99"
    
  """
  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  @doc """
  Given a list containing sublists, where each sublist contains the data for
  a column, return a list containing the maximum width of each column
  
  ## Examples
  
      iex> data = [ [ "cat", "wombat", "elk"], ["mongoose", "ant", "gnu"] ]
      iex> Issues.TableFormatter.widths_of(data)
      [6, 8 ]
    
  """
  def widths_of(columns) do
    for column <- columns, do: column |> map(&String.length/1) |> max
  end

  @doc """
  Return a format string that hard codes the widths of a set of columns.
  We put `" |"` between each column.
  
  ## Examples
  
      iex> widths = [5,6,99]
      iex> Issues.TableFormatter.format_for(widths)
      "~-5s | ~-6s | ~-99s~n"
    
  """
  def format_for(columns_width) do
    map_join(columns_width, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  @doc """
  Given a list containing rows of data, a list containing the header selectors,
  and a format string, write the extracted data under control of the format string.
  
  ## Examples
  
      iex> widths = [5,6,9]
      iex> Issues.TableFormatter.separator(widths)
      "------+--------+----------"
    
  """
  def separator(columns_width) do
    map_join(columns_width, "-+-", fn width -> List.duplicate("-", width) end )
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
      |> List.zip
      |> map(&Tuple.to_list/1)
      |> each(&puts_one_line_in_columns(&1,format))
  end
  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
