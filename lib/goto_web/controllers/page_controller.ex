defmodule GotoWeb.PageController do
  use GotoWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
