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

## The other: With

query_with <- "WITH ABOVE_AVG AS (
SELECT * FROM EPEX_12_20_12_13 WHERE PRICE > (SELECT AVG(PRICE) FROM EPEX_12_20_12_13))
SELECT * FROM ABOVE_AVG"

dbGetQuery(con, query_with)

# Now we turn to the other topic: JOIN

## Inner Join

query_inner <- "SELECT * FROM EPEX_12_20_12_13 AS A 
INNER JOIN EPEX_USER AS B ON A.ID = B.ID"
dbGetQuery(con, query_inner)

query_inner_bad <- "SELECT EPEX_12_20_12_13.QUANTITY 
FROM EPEX_12_20_12_13 
INNER JOIN EPEX_USER 
ON EPEX_12_20_12_13.ID = EPEX_USER.ID "

dbGetQuery(con, query_inner_bad)

query_inner_good <- "SELECT A.QUANTITY 
FROM EPEX_12_20_12_13 AS A 
INNER JOIN EPEX_USER AS B 
ON A.ID = B.ID  "

dbGetQuery(con, query_inner_good)

## Left Join 

query_left <- "SELECT * 
FROM EPEX_12_20_12_13 AS A 
LEFT JOIN EPEX_USER AS B ON A.ID = B.ID"
dbGetQuery(con, query_left)

query_left_name <- "SELECT A.ID, B.NAME 
FROM EPEX_12_20_12_13 AS A 
LEFT JOIN EPEX_USER AS B 
ON A.ID = B.ID "

dbGetQuery(con, query_left_name)
