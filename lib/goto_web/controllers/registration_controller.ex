defmodule GotoWeb.RegistrationController do
  use GotoWeb, :controller

  alias Goto.UserManager
  alias UserManager.User

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => params}) do
    case UserManager.create_user(params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You're in!")
        |> put_session(:current_user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
