#Times Modules
#Matthew Ahrens
#Ch 6
defmodule Times do
  def double(n), do: n * 2
  #extend exercises
  def triple(n), do: n * 3
  def quadruple(n), do: double double n
end
