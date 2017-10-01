defmodule GotoWeb.CurrentUser do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    user = get_user_from_session(conn)

    conn
    |> assign(:current_user, user)
  end

  defp get_user_from_session(conn) do
    case get_session(conn, :current_user_id) do
      nil -> nil
      val -> Goto.UserManager.get_user(val)
    end
  end
end
