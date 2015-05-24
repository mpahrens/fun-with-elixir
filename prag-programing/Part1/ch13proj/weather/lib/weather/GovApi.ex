defmodule Weather.GovApi do
  require Logger
  @user_agent [ { "User-agent", "Elixir matthew.ahrens@tufts.edu"}]
  @weather_url Application.get_env(:weather, :gov_url)
  def fetch(airport) do
    weather_url(airport)
      |> HTTPoison.get(@user_agent)
      |> handle_response
  end
  def weather_url(airport) do
    "#{@weather_url}/#{airport}.xml"
  end
  def handle_response({:ok, %{status_code: 200, body: body}}) do 
    Logger.info("GovApi Successful Response")
    {:ok, Exml.parse(body)}
  end
  def handle_response({_, %{status_code: status, body: body}}) do 
    Logger.error("GovApi Error level: #{status}")
    {:error, Exml.parse(body)}
  end
end
