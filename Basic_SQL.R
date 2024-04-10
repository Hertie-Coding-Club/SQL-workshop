library(RSQLite)
con <- dbConnect(SQLite(), dbname="data/trades.sqlite")

# We can see table list in a database.
dbListTables(con)

# Select all rows from the table "epex_12_20_12_13"
dbGetQuery(con, "")

# Calculate average price 
dbGetQuery(con, "")




# WHERE conditions

# Select only trades with a price greater than 10
dbGetQuery(con, "")

# Select only trades with a price greater than 13, on the buy side
dbGetQuery(con, "")


# How many trades have a quantity below 15?
dbGetQuery(con, "")





# Use "group by" function and aggregate functions

# What's the average price for trades that follow strategy1?
dbGetQuery(con, "")

# What is the highest price on a trade, on the sell side, with a quantity of over 13? Which one is it?
dbGetQuery(con, "")

# Order all trades on the sell side, extracting quantity, price and id, in descending order.
dbGetQuery(con, "")




