#Default Parameters
#Matthew Ahrens
#Chapter 6
defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1,p2,p3,p4]
  end

  #def badfun(p1,p2 \\ 123) do
  #  IO.inspect [p1,p2]
  #end
  #def badfun(p1,99) do
  #  IO.puts "you said 99"
  #end

  def goodfun(p1,p2 \\ 123)

  def goodfun(p1,99) do
    IO.puts "you said 99"
  end
  def goodfun(p1,p2) do
    IO.inspect [p1,p2]
  end
end
