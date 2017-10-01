defmodule GotoWeb.PageView do
  use GotoWeb, :view
  alias Goto.UserManager.User

  def greeting(nil),
    do: gettext "Welcome to %{name}!", name: "GOTO CPH!"
  def greeting(%User{name: name}),
    do: gettext "Welcome %{name}!", name: name
end
