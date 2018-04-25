
{:ok, {:ok, dep_row}} = Enum.fetch(Enum.take(decoded, 10), 0)
{:ok, {:ok, with_row}} = Enum.fetch(Enum.take(decoded, 10), 1)


parse_row.(dep_row)
parse_row.(with_row)


str = "2017-01-07T14:51:09+00:00"

parse_date.(str)


path = Path.expand("~/Documents/Crypto Tax/ct-custom-import-bittrex-transactions.csv")
decoded = File.stream!(path) |> CSV.decode |> Enum.to_list

["Type",       "Buy", "Cur.", "Sell",          "Cur.", "Fee", "Cur.", "Exchange",      "Group", "Comment", "Date"]
["Withdrawal", "",    "",     "1299.90000000", "AEON", "",    "",     "Bittrex",       "",      "", "2018-04-03 07:20:19"]
["Withdrawal", "",    "",     amount,          "BTC",  "",    "",     "LocalBitcoins", "",      "", parse_date(date)]
