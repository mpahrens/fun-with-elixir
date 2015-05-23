#Heads and Tails
#Matthew Ahrens
#Chapter 7

#empty list
[]
#join with empty list
[3 | []]
#flatten a stupid amount of lists
[1|[2|[3|[4|[]]]]] #=> [1,2,3,4]

#pattern matching
[a,b,c] = [1,2,3]

[head | tail] = [1,2,3]

defmodule MyList do
  def len([]), do: 0
  def len([_head|tail]), do: 1+len(tail)
  def add_1([]), do: []
  def add_1([head|tail]), do: [head+1|add_1(tail)]
  def map([],_func), do: []
  def map([head|tail], func), do: [func.(head) | map(tail, func)]
  def sum(list), do: _sum(list,0)
  defp _sum([],total), do: total
  defp _sum([head|tail],total),do: _sum(tail,head+total)
  def reduce([],value,_), do: value
  def reduce([head|tail], value,func), do: reduce(tail,func.(head,value),func)
  #exercises
  def mapsum(list,func), do: _mapsum(list,func,0)
  defp _mapsum([],_func, total), do: total
  defp _mapsum([head|tail],func,total), do: _mapsum(tail,func,func.(head) + total)
  def max([head|tail]), do: _max([head|tail],head)
  defp _max([],it), do: it
  defp _max([head|tail],it) when head > it, do: _max(tail,head)
  defp _max([_head|tail],it), do: _max(tail,it)
  def caesar(string,num), do: map(string,&(rem(&1+num,122)))
  #Complex list patterns
  def swap([]), do: []
  def swap([a,b|tail]), do: [b,a|swap(tail)]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
  #List of lists exercises
  def span(from,to), do: _span(from,to,[])
  defp _span(from,to,list) when from < to, do: _span(from,to-1,[to|list])
  defp _span(from,_,list), do: [from|list]
end

#List of lists
defmodule WeatherStation do
  def for_location_27([]), do: []
  def for_location_27([ [time,27,temp,rain ]| tail]) do
    [[time, 27,temp,rain] | for_location_27(tail)]
  end
  def for_location_27([ _ | tail ]), do: for_location_27(tail)
end
