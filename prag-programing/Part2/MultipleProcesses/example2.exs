defmodule TokenPasser do
  def reply(sender) do
    receive do
      token ->
        send sender, token
    end
  end
  
  def run() do
    pid1 = spawn(TokenPasser, :reply, [self])
    pid2 = spawn(TokenPasser, :reply, [self])
    
    send pid1, "fred"
    send pid2, "betty"
    
    receive do
      name when is_bitstring(name) ->
        IO.puts "received: #{name}" 
    end
    
    receive do
      name when is_bitstring(name) ->
        IO.puts "received: #{name}" 
    end
  
  end
end
