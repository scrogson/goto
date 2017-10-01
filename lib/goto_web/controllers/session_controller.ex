defmodule GotoWeb.SessionController do
  use GotoWeb, :controller

  alias Goto.UserManager

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case UserManager.authenticate_with_email_and_password(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("Welcome back %{name}!", name: user.name))
        |> put_session(:current_user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: page_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, gettext("Incorrect email or password."))
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: page_path(conn, :index))
  end
end
