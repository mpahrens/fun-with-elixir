#Pipes!
#Matthew Ahrens
#Chapter 6
(1..10)
  |> Enum.map(&(&1*&1))
  |> Enum.filter(&(&1 < 40))
  
