defmodule Budgets.TextFileLoader do
  def load_balances do
    load_balances("balances.txt")
  end

  def load_balances(filename) do
    File.open!(filename)
    |> IO.stream(:line)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    to_balance(String.split(line))
  end

  defp to_balance([category, balance]) do
    to_balance([category, 0, balance])
  end

  defp to_balance([category, budget, balance]) do
     %{
       category: category,
       budget: budget,
       balance: balance
     }
  end
end
