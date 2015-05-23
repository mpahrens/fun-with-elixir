defmodule Simple do
import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  def init(options) do
    # initialize options

    options
  end

  get "/hello" do
    IO.puts conn
  end
end

# Run with mix run --no-halt lib/sse.ex
IO.puts "starting..."
Plug.Adapters.Cowboy.http Simple, [], port: 4000
