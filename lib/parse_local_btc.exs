path = "~/Documents/Crypto Tax/localbtc transactions/Transactions for 36Wt5w from 01-06-2015 to 30-06-2015.csv"

File.stream!(path) |> CSV.decode |> Enum.take(2)
