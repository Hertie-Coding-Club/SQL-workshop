# SQL Workshop

Date: 10th, Apr, 2024  
Time: 14:00 pm - 16:00 pm  
Place: Maker Space  

* [Background](#Background)
* [Session](#Solution)
  * [Preparation](#Preparation)
  * [Data](#Data)
  * [Session 1](#Session-1)   
  * [Session 2](#Session-2)


## Background.
Hosted by Hertie Coding Club, the SQL Workshop aims for introducing basic SQL to the student.  
With R and Python, SQL is also one of the most important programming languages in data relevant fields (data scientist, data analytics). Therefore, we decided to hold this workshop. 

## Session 
The workshop consists of two sessions. The first is **basic SQL**, and the second is **Advanced SQL**.

### Preparation 
Originally, for learning SQL, installing DataBase Management System (DBMS) is preferable. But it takes too long and the file size is also too large. So, for a smooth workshop, we will use **R programming** together. That is, this workshop is based on **SQL** and **R**. Therefore, installing R studio is necessary.

### Data 
During the session, we handle `trades.sqlite` database. And in the database, only one table exists: `epex_12_20_12_13`. **This table is about selling and buying a unit of electricty.** 
|      id|  quantity|price |side |strategy  |
|--------|----------|------|-----|----------|
| trade_1|        5 |   20 | buy |strategy_1|
| trade_2|       17 |   10 |sell |strategy_1|
| trade_3|       15 |    8 | buy |strategy_1|
| trade_4|       13 |   35 |sell |strategy_2|
| trade_5|       23 |   11 |sell |strategy_2|
| trade_6|        8 |   20 | buy |strategy_2|

The schema is as follow: 

```sqlite
id TEXT PRIMARY KEY,
quantity INTEGER NOT NULL,
price REAL NOT NULL,
side TEXT NOT NULL CHECK (side IN ('buy', 'sell')),
strategy TEXT NOT NULL
```

### Session 1 

#### 1. SELECT * FROM {table name}
This is a basic of basic. If you want to see all rows, just select all(*) from table. For example,
```sqlite
SELECT * FROM epex_12_20_12_13
```

Or if you want to calculate something (e.g. average of price), you can calculate like below.

```sqlite
SELECT AVG(PRICE) FROM EPEX_12_20_12_13
```

As you already saw, the SQL doesn't discern between a capital letter and a small letter. So you can type "EPEX_12_20_12_13" instead of "epex_12_20_12_13"   

#### 2. SELECT * FROM {table name} WHERE {condition}  
If you want to add condition, use "WHERE" sentence. For example, 
```sqlite
SELECT * FROM EPEX_12_20_12_13 WHERE SIDE = "buy"
```
This query results in rows of which side is "buy."

#### 3. SELECT {criterion}, {calculation} FROM {table name} WHERE {condition} GROUP BY {criterion}

If you want to see the sum of quantity when buying electricity in each strategy, the query is following 

```sqlite
SELECT STRATEGY, SUM(QUANTITY) FROM EPEX_12_20_12_13 
WHERE SIDE = 'buy' GROUP BY STRATEGY
```

### Session 2 

If you want to do more complicate query, `Subquery` and `With` statements are inevitable.  
For example, for solving the next question, we can use subquery way (1) and with statements way (2)  

Question: Select rows which have price is higher than average price

#### 1. Subquery  

You can think the below query for solving the above question, but unfortuately it doesn't work (At thie time, SQL is inconvenient)

```sqlite
SELECT * FROM EPEX_12_20_12_13 WHERE PRICE > AVG(PRICE)
```
So, we need subquery. Subquery means literally "query in query". In the session 1, we got the average price in the table

`SELECT AVG(PRICE) FROM EPEX_12_20_12_13`

We use the query for solving the session 2 question like below

```sqlite
SELECT * FROM EPEX_12_20_12_13 WHERE PRICE > 
(SELECT AVG(PRICE) FROM EPEX_12_20_12_13)
```

#### 2. With

Besides of putting the query into the query, we can make temporary table using `with` statements. For example, we can make an interim table names `ABOVE_AVG` in which all rows are higher than average price

```sqlite
WITH ABOVE_AVG AS (
SELECT * FROM EPEX_12_20_12_13 WHERE PRICE > (SELECT AVG(PRICE) FROM EPEX_12_20_12_13)
)

```

And we just select all rows from `ABOVE_AVG`. The result is our answer for session 2 question


```sqlite
WITH ABOVE_AVG AS (
SELECT * FROM EPEX_12_20_12_13 WHERE PRICE > (SELECT AVG(PRICE) FROM EPEX_12_20_12_13))

SELECT * FROM ABOVE_AVG
```

