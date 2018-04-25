defmodule Cryptoparser do
  @moduledoc """
  Documentation for Cryptoparser.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cryptoparser.hello
      :world

  """
  def parse do
    # To use the localbtc csv files:
    # open each in openoffice and re-save it to fix the formatting. The file is missing a comma at the end of each row
    table_header = [["Type","Buy","Cur.","Sell","Cur.","Fee","Cur.","Exchange","Group","Comment","Date"]]

    folder_path = Path.expand("~/Documents/Crypto Tax/localbtc transactions/")
    {:ok, files } = File.ls(folder_path)

    rows = Enum.map(files, fn (file) -> Path.join(folder_path, file) end)
    |> Stream.flat_map(fn (fp) -> parse_file(fp) end)

    rows_with_header = Stream.concat(table_header, rows)

    file = File.open!("localbtc-transactions.csv", [:write, :utf8])

    rows_with_header
    |> CSV.encode
    |> Enum.each(&IO.write(file, &1))
  end

  def parse_file(path) do
    File.stream!(path)
    |> CSV.decode
    |> Stream.drop(1)
    |> Stream.map(fn({:ok, row}) -> parse_row(row) end)
    |> Stream.reject(fn(x) -> is_nil(x) end)
  end

  def parse_date(raw_date) do
    # 2017-01-07T14:51:09+00:00 -> 2018-04-03 07:20:19
    raw_date
    |> String.replace("T", " ")
    |> String.replace("+00:00", "")
  end

  def parse_row([_, datetime, _, amount, "Withdraw", _, _]) do
    ["Withdrawal", "", "", amount, "BTC", "", "", "LocalBitcoins", "", "", parse_date(datetime)]
  end
  def parse_row([_, datetime, amount, _, "Deposit", _, _]) do
    ["Deposit", amount, "BTC", "", "", "", "", "LocalBitcoins", "", "", parse_date(datetime)]
  end
  def parse_row(_), do: nil

end
