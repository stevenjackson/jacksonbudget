defmodule Budgets.BalanceView do
  use Budgets.Web, :view

   def render("balance.json", %{balance: balance}) do
     %{
       category: balance.category,
       budget: balance.budget,
       balance: balance.balance
     }
   end
end

