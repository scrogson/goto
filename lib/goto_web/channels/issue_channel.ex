defmodule GotoWeb.IssueChannel do
  use GotoWeb, :channel

  alias Goto.Support
  alias GotoWeb.Presence

  def join("issues:" <> id, _payload, socket) do
    issue = Support.get_issue!(id)
    send(self(), :after_join)
    {:ok, assign(socket, :issue, issue)}
  end

  def handle_in("new_comment", payload, socket) do
    user = socket.assigns.user
    issue = socket.assigns.issue

    {:ok, comment} = Support.create_comment(issue, user, payload)
    formatted_comment = format_comment(comment)

    broadcast socket, "new_comment", formatted_comment

    {:reply, {:ok, formatted_comment}, socket}
  end

  def handle_info(:after_join, socket) do
    user = socket.assigns.user
    issue = socket.assigns.issue

    comments =
      issue
      |> Support.list_comments()
      |> Enum.map(&format_comment/1)

    push socket, "current_user_data", user_data(user)
    push socket, "comment_history", %{comments: comments}
    push socket, "presence_state", Presence.list(socket)

    Presence.track(socket, user.id, user_data(user))

    {:noreply, socket}
  end

  defp format_comment(comment) do
    %{id: comment.id,
      from: comment.user.name,
      avatarUrl: avatar_url(comment.user, s: 128),
      body: comment.body}
  end

  defp user_data(user) do
    %{name: user.name, avatarUrl: avatar_url(user, s: 128)}
  end
end
