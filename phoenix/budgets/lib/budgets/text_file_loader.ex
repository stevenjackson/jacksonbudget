defmodule Budgets.TextFileLoader do
  def load_balances do
    download_file
    |> load_balances
  end

  def download_file do
    bucket = "jackson-budget-1519498484201-uploads"
    key = "balances.txt"
    {:ok, token} = Goth.fetch(Budgets.Goth)
    conn = GoogleApi.Storage.V1.Connection.new(token.token)
    # alt:media gives us contents, otherwise nada
    case GoogleApi.Storage.V1.Api.Objects.storage_objects_get(conn, bucket, key, alt: "media") do
      {:error, %Tesla.Env{body: <<"No such object:", _rest::binary>>}} -> {:error, :file_not_found}
      {:ok, %Tesla.Env{body: body}} -> {:ok, body}
    end
  end

  def load_balances({:ok, body}) do
    body
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&blank?/1)
    |> Enum.map(&parse_line/1)
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

  defp to_balance([category]) do
    to_balance([category, 0])
  end

  defp to_balance([category, budget, balance]) do
     %{
       category: category,
       budget: budget,
       balance: balance
     }
  end

  defp blank?(str) do
    case str do
      nil -> true
      "" -> true
      " " <> r -> blank?(r)
      _ -> false
    end
  end
end
