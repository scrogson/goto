defmodule GotoWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "issues:*", GotoWeb.IssueChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user salt", token, max_age: 86400) do
      {:ok, user_id} ->
        user = Goto.UserManager.get_user(user_id)
        {:ok, assign(socket, :user, user)}
      {:error, _reason} ->
        :error
    end
  end

  def id(socket), do: "user_socket:#{socket.assigns.user.id}"
end
