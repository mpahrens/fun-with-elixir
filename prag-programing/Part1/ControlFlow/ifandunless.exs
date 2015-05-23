"""
control flow
Matthew Ahrens
Chapter 12
"""
#if unless
if 1 == 1 do
  "yay"
else
  "no"
end
unless 1 == 1 do
  ":("
else
  ":)"
end

#cond
defmodule FizzBuzz do
  def upto(n) when n > 0, do: _upto(1,n,[])
  defp _upto(_current,0,result), do: Enum.reserve result
  defp _upto(current,left,result) do
    next_answer =
      cond do
        rem(current, 3) == 0 and rem(current,5) == 0 ->
          "FizzBuzz"
        rem(current, 3) == 0 ->
          "Fizz"
        rem(current, 5) == 0 ->
          "Buzz"
        true ->
          current
      end
      _upto(current+1, left-1, [next_answer | result ])
  end

  #transformation
  def upto2(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end
  defp fizzbuzz(n) do
    cond do
      rem(current, 3) == 0 and rem(current,5) == 0 ->
        "FizzBuzz"
      rem(current, 3) == 0 ->
        "Fizz"
      rem(current, 5) == 0 ->
        "Buzz"
      true ->
        n
      end
    end
end

#case
case File.open("ifandunless.exs") do
  {:ok, file} ->
    IO.puts "First line: #{IO.read(file, :line)}"
  {:error, reason} ->
    IO.puts "Failed to open file: #{reason}"
end

defmodules Users do
  matt = %{name: "Matt", job: "Research Assistant", state: "MA"}

  case matt do
    %{state: some_state} = person ->
      IO.puts "#{person.name} live in #{some_state}"
    _ ->
      IO.puts "No matches"
  end
end

#exceptions
#if it is fail-y
File.open("config_file.conf") do
  {:ok, file} ->
    process(file)
  {:error, message} ->
    IO.puts :stderr, "Couldn't open file, #{message}"
#if it should happen every time
File.open("config_file.conf") do
  {:ok, file} ->
    process(file)
  {:error, message} ->
    raise "Couldn't open file, #{message}"
#! lets us just kinda let elixir deal with it
File.open!("config_file.conf")

#exercise ok
def ok! {:ok, data}, do: data
def ok! {:error, message}, do: raise "Couldn't do thing, #{message}"
