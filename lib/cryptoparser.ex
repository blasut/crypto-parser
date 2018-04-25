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
    path = Path.expand("~/Documents/Crypto Tax/localbtc transactions/Transactions for 36Wt5w from 01-06-2015 to 30-06-2015.csv")

    File.stream!(path) |> CSV.decode |> Enum.take(5)


    # file = File.open!("test.csv", [:write, :utf8])
    # table_data |> CSV.encode |> Enum.each(&IO.write(file, &1))

    table_data = [
      ['Type','Buy','Cur.','Sell','Cur.','Fee','Cur.','Exchange','Group','Comment','Date'],
      # [Withdrawal,,,1299.90000000,AEON,,,Bittrex,,,2018-04-03 07:20:19 ]
    ]

    table_data |> CSV.encode
  end
end
