library(RSQLite)
con <- dbConnect(SQLite(), dbname="data/trades.sqlite")

# We can see table list in a database.
dbListTables(con)

# Select all rows 
dbGetQuery(con, "SELECT * FROM epex_12_20_12_13")

# Set condition using "WHERE"
# Because it's bothering to change capital letter to small, you can JUST USE CAPITAL LETTERS. 

dbGetQuery(con, "SELECT * FROM EPEX_12_20_12_13 WHERE SIDE = 'buy' ")

# Use "group by" function 
# If the query length is getting longer, you can type it separately.
query <- "SELECT COUNT(*) FROM EPEX_12_20_12_13 GROUP BY STRATEGY"
dbGetQuery(con, query)
# But you can't see what strategy corresponds to each value

# You can solve it by adding "STRATEGY" column like below 
query <- "SELECT STRATEGY, COUNT(*) FROM EPEX_12_20_12_13 GROUP BY STRATEGY"
dbGetQuery(con, query)

