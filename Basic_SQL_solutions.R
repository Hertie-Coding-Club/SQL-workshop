library(RSQLite)
con <- dbConnect(SQLite(), dbname="data/trades.sqlite")

# We can see table list in a database.
dbListTables(con)

# Select all rows from the table "epex_12_20_12_13"
dbGetQuery(con, "SELECT * FROM epex_12_20_12_13")

# Calculate average price 
dbGetQuery(con, "SELECT AVG(price) FROM epex_12_20_12_13")

# WHERE conditions

# Select only trades with a price greater than 10
dbGetQuery(con, "SELECT id, price FROM epex_12_20_12_13 WHERE price > 10")

# Select only trades with a price greater than 13, on the buy side
dbGetQuery(con, "SELECT id, price FROM epex_12_20_12_13 WHERE price > 10 AND side = 'buy'")


# How many trades have a quantity below 15?
dbGetQuery(con, "SELECT COUNT(id) AS n_below_15 FROM epex_12_20_12_13 WHERE quantity < 15")








# Use "group by" function and aggregate functions

# What's the average price for trades that follow strategy1?
dbGetQuery(con, "SELECT AVG(price) FROM epex_12_20_12_13 WHERE strategy = 'strategy_1'")

# What is the highest price on a trade, on the sell side, with a quantity of over 13? Which one is it?
dbGetQuery(con, "SELECT id, MAX(price) FROM epex_12_20_12_13 WHERE side = 'sell' AND quantity > 13")

# Order all trades on the sell side, extracting quantity, price and id, in descending order
dbGetQuery(con, "SELECT * FROM epex_12_20_12_13 ORDER BY id DESC")



