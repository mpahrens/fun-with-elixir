#Exercises
#Matthew Ahrens
#Chapter 6
defmodule Chop do

  def guess(x,a..b) do
    hunch = div(b-a,2) + a
    IO.puts "Is it #{hunch}?"
    is_it(x,hunch,a..b)
  end

#private functions can only be called from inside the module that declares them
  defp is_it(x,y,_.._) when x == y, do: y
  defp is_it(x,y,a.._) when x < y, do: guess(x,a..y)
  defp is_it(x,y,_..b) when x > y, do: guess(x,y..b)

end
