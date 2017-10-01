defmodule GotoWeb.GravatarHelper do
  def avatar_url(user, opts \\ []) do
    opts =
      opts
      |> Keyword.put_new(:s, 256)
      |> Keyword.put_new(:d, "retro")

    Exgravatar.gravatar_url(user.email, opts)
  end
end
