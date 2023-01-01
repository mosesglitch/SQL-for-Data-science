--  The LIMIT statement is useful when you want to see just the first few rows of a table

SELECT *
FROM orders
LIMIT 10;

-- The ORDER BY statement allows us to sort our results using the data in any column.
-- ORDER BY in a SQL query only has temporary effects, for the results of that query,

SELECT *
FROM orders
ORDER BY occurred_at
LIMIT 1000

-- DESC can be added after the column in your ORDER BY statement to sort in descending order, as the default is to sort in ascending order
-- When you provide a list of columns in an ORDER BY command, the sorting occurs using the leftmost

SELECT  account_id,
        total_amt_usd
FROM orders
ORDER By total_amt_usd DESC, account_id

-- Using the WHERE statement, we can display subsets of tables based on conditions that must be met. You can also think of the WHERE command as filtering the data.
-- Common symbols used in WHERE statements include:

-- > (greater than)

-- < (less than)

-- >= (greater than or equal to)

-- <= (less than or equal to)

-- = (equal to)

-- != (not equal to)

SELECT *
FROM orders
WHERE account_id = 4251
ORDER BY occurred_at
LIMIT 1000;
-- The WHERE statement can also be used with non-numeric data. We can use the = and != operators here

SELECT *
FROM accounts
WHERE name = 'United Technologies'

SELECT *
FROM accounts
WHERE name != 'United Technologies'