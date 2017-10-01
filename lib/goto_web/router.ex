defmodule GotoWeb.Router do
  use GotoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GotoWeb.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GotoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    resources "/issues", IssueController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GotoWeb do
  #   pipe_through :api
  # end
end
