#Parallel.exs
# Matthew Ahrens
# Ch1 pg 2 - data transformation in parallel example
defmodule Parallel do
  def pmap(collection,func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
    end
end

"""
#run with:
iex > import_file "Parallel.exs"
iex > Parallel.pmap 1..1000, &(&1*&1)
#returns list of squares from 1 to 1000, computing in parallel and using all of your cores
