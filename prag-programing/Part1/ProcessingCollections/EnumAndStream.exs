"""
Enum and Stream
Matthew Ahrens
Chapter 10
"""
#All collectionsa are iterable (implement the Enumerable protocol)

#Enum

#convert to list
list = Enum.to_list 1..5

#concatenate collections
Enum.concat([1,2,3],[4,5,6])

#generate collections based on function of original collection
Enum.map(list, &(&1 * 10))
Enum.map(list,&String.duplicate("*",&1))

#Select
Enum.at(10..20,3)
Enum.at(10..20,100) #nil
Enum.at(10..20,100,:default_value) #:default_value

Enum.filter(list,&(&1 > 2))
require Integer
Enum.reject(list,&Integer.is_even/1)

#Sort and Compare
Enum.sort ["I", "am", "a", "cat"]
Enum.sort ["I", "am", "a", "cat"], &(String.length(&1) <= String.length(&2))

Enum.max ["I", "am", "a", "cat"]
Enum.max_by ["I", "am", "a", "cat"], &String.length/1

#Split a collection
Enum.take(list,3)
Enum.take_every list,2
Enum.take_while list, &(&1 < 4)
Enum.split(list,3)
Enum.split_while(list,&(&1 < 4 ))

#Join
Enum.join(list)
Enum.join(list,", ")

#Predicate operations (checks)
Enum.all?(list, &(&1 < 2))
Enum.any?(list,&(&1 < 4))
Enum.member?(list,2)
Enum.empty?(list)

#Merge collections
Enum.zip(list,[:a,:b,:c])
Enum.with_index(["once","upon","a","time"])

#Fold elements into a single value
Enum.reduce(1..100,&(&1+&2))

#Exercises
defmodule MyEnum do
  #def all
  def all?([], _), do: true
  def all?([head|tail], func), do: func.(head) and all?(tail,func)
  #def each
  def each([head|tail],func),do: func.(head) and each(tail,func)
  #def filter
  def filter(list,func), do: _filter(list,[],func)
  defp _filter([],filtered,_), do: filtered
  defp _filter([head|tail],filtered,func) do
    if func.(head) do
      _filter(tail,[head|filtered],func)
    else
      _filter(tail,filtered,func)
    end
  end
  #def split
  #def take
end

#Streams

#Enums are greedy, processing the entire collection

#Could use Lazy enumeration:

#this reads the whole file, :(
IO.puts File.read!("/some/text/file")
  |> String.split
  |> Enum.max_by(&String.length/1)
#Composible enumeration
_s = Stream.map [1,3,5,7], &(&1 + 1)

#composition
[1,2,3,4]
  |> Stream.map(&(&1*&1))
  |> Stream.map(&(&1+1))
  |> Stream.filter(fn x -> rem(x,2) == 1 end)
  |> Enum.to_list

#example
IO.puts File.open!("/some/file")
  |> IO.stream(:line)
  |> Enum.max_by(&String.length/1)

#Infinite Streams
Enum.map(1..10_000_000,&(&1+1)) |> Enum.take(5) #elixir creates the huuuuge list, then runs enum
Stream.map(1..10_000_000, &(&1+1)) |> Enum.take(5) #once take gets 5 values, map stops producing them

#creating our own streams
#cycle
Stream.cycle(~w{green white})
  |> Stream.zip(1..5)
  |> Enum.map(fn {class, value}->
        ~s{<tr class="#{class}"><td>#{value}</td></tr>|n} end)
  |> IO.puts

#repeatedly
Stream.repeatedly(fn -> true end) |> Enum.take(3)
Stream.repeatedly(&:random.uniform/0) |> Enum.take(3)

#iterate
Stream.iterate([],&[&1]) |> Enum.take(5)

#unfold, like iterate with more options
#general form fn state -> {stream_value,new_state} end

#example, fib
Stream.unfold({0,1}, fn {f1,f2} -> {f1,{f2, f1+f2}} end) |> Enum.take(15)

#resource, external resources
#Stream.resource(init function, retreive function, end/close function)
Stream.resource(fn -> File.open("/some/file") end,
                fn file ->
                  case IO.read(file, :line) do
                    line when is_binary(line) -> { [line], file }
                    _ -> {:halt, file}
                  end
                end,
                fn file -> File.close!(file) end
              )
#Collectable protocol, Enum.into
#Comprehensions
#form: result = for generator or filter... [,into: value], do: expression
for x <- [1,2,3,4,5], do: x*x
for x <- [1,2,3,4,5], x < 4, do: x*x
