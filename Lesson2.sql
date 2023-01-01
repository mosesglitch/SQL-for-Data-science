-- Creating a new column that is a combination of existing columns is known as a derived column (or "calculated" or "computed" column).
--  Usually, you want to give a name, or "alias," to your new column using the AS keyword.
-- f you are deriving the new column from existing columns using a mathematical expression, then these familiar mathematical operators will be useful:

-- * (Multiplication)
-- + (Addition)
-- - (Subtraction)
-- / (Division)

SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
FROM orders
LIMIT 10;
-- Introduction to Logical Operators
-- In the next concepts, you will be learning about Logical Operators. Logical Operators include:

-- LIKE This allows you to perform operations similar to using WHERE and =, but for cases when you might not know exactly what you are looking for.

-- IN This allows you to perform operations similar to using WHERE and =, but for more than one condition.

-- NOT This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.

-- AND & BETWEEN These allow you to combine operations where all combined conditions must be true.

-- OR This allows you to combine operations where at least one of the combined conditions must be true.

SELECT name
FROM accounts
WHERE name LIKE '%one%';

-- The IN operator is useful for working with both numeric and text columns. 

SELECT *
FROM orders
WHERE account_id IN (1001,1021);

-- The NOT operator is an extremely useful operator for working with the previous two operators we introduced: IN and LIKE. 
-- By specifying NOT LIKE or NOT IN, we can grab all of the rows that do not meet particular criteria.

SELECT sales_rep_id, 
       name
FROM accounts
WHERE sales_rep_id NOT IN (321500,321570)
ORDER BY sales_rep_id

SELECT *
FROM accounts
WHERE website NOT LIKE '%com%';

-- The AND operator is used within a WHERE statement to consider more than one logical clause at a time

WHERE column >= 6 AND column <= 10
WHERE column BETWEEN 6 AND 10

SELECT *
FROM orders
WHERE occurred_at BETWEEN '2016-04-01' AND '2016-10-01'
ORDER BY occurred_at

--OR= Either statement is true

SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty
FROM orders
WHERE standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0

SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty
FROM orders
WHERE (standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0)
AND occurred_at = '2016-10-01'