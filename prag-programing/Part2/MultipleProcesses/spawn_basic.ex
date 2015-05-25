defmodule SpawnBasic do
  def greet do
    IO.puts "Hello"
  end
end

#in iex>
# >c("spawn_basic.ex")
# >SpawnBasic.greet
#Hello
#:ok
#
# >spawn(SpawnBasic, :greet, [])
#Hello
#PID<0.##.0>
