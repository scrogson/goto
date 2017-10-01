defmodule Goto.Support.Issue do
  use Ecto.Schema
  import Ecto.Changeset
  alias Goto.Support.{Comment, Issue}


  schema "issues" do
    field :status, :string
    field :subject, :string

    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(%Issue{} = issue, attrs) do
    issue
    |> cast(attrs, [:subject])
    |> validate_required([:subject])
  end
end
