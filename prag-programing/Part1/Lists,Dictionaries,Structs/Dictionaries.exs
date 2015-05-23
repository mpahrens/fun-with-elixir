"""
Maps, HashDicts, Sets, and Structures
Matthew Ahrens
Chapter 8
"""
defmodule Sum do
  def values(dict) do
    dict
      |> Dict.values
      |> Enum.sum
  end
end

#Sum a hashdict
hd = [one: 1, two: 2, three:3]
      |> Enum.into HashDict.new
IO.puts Sum.values(hd)

#Sum a map
map = %{four: 4, five: 5, six: 6}
IO.puts Sum.values(map)
#TODO, get familiar with Keyword module

#pattern matching
person = %{name: "Matt", height: "5'8\""}
%{name: a_name} = person #a_name = "Matt"
%{name: _, height: _} = person # %{height: "5'8"", name: "Matt"}
#search by a key
%{name: "Matt"} = person # %{height: "5'8"", name: "Matt"}

#list comprehension for queries
people = [
  %{name: "Matt", height: 1.1},
  %{name: "Clique", height: 2.2}
  ]
for some_person = %{height: height} <- people,
  height > 1.5, do: IO.inspect some_person

#Pattern matching can't bind keys
# %{ item => :ok } = %{1 => :ok, 2 => :error} # compile error

#Updating a map
map1 = %{a: 1, b: 2, c: 3}
map2 = %{map1 | a: "one"}
IO.inspect map1
IO.inspect map2
#this will not add a new key. use Dict.put_new for that
