defmodule Budgets.Router do
  use Budgets.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Budgets do
    pipe_through :api

    get "/dashboard", DashboardController, :index
  end
end
