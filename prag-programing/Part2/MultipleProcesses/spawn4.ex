defmodule Spawn4 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello, #{msg}"}
        greet # recursively restart greet receiver
    end
  end
end

#client
pid = spawn(Spawn4, :greet, [])
send pid, {self, "World!"}
receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self, "Kermit!"}
receive do
  {:ok, message} ->
    IO.puts message
  after 500 ->
    IO.puts "The greeter has gone away"
end

#iex> c("spawn4.ex")
#recursion does not have an overhead in elixir because of tail-call optimization
# calling itself must be the last thing a function does to get this benefit
  
