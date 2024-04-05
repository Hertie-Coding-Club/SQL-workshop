library(RSQLite)
con <- dbConnect(SQLite(), dbname="data/trades.sqlite")

# Here, we are going to solve only one question
# Question: Select rows of which price is higher than average price 
# We will approach the question with two ways

## One: Subquery

query_sub <- "SELECT * FROM EPEX_12_20_12_13 WHERE PRICE > 
(SELECT AVG(PRICE) FROM EPEX_12_20_12_13)
"
dbGetQuery(con, query_sub)

## The other: WITH 

query_with <- "WITH ABOVE_AVG AS (
SELECT * FROM EPEX_12_20_12_13 WHERE PRICE > (SELECT AVG(PRICE) FROM EPEX_12_20_12_13))
SELECT * FROM ABOVE_AVG"

dbGetQuery(con, query_with)
