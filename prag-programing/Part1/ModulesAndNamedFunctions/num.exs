#Exercises
#Matthew Ahrens
#Chapter 6
defmodule Num do
  #Sum
  def sum(1), do: 1
  def sum(n), do: n + sum(n-1)

  #GCD
  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y,rem(x,y))
end
