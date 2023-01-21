SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
      SELECT MAX(total_amt)
      FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
              FROM sales_reps s
              JOIN accounts a
              ON a.sales_rep_id = s.id
              JOIN orders o
              ON o.account_id = a.id
              JOIN region r
              ON r.id = s.region_id
              GROUP BY r.name) sub);

-- Subquery Tradeoffs
-- Readability: How easy it is to determine what the code is doing. 
-- Performance: How quickly the code runs. 
-- Query Plan: What happens under the hood.[Better one time execution]

-- Determine if a subquery is needed (or a join/aggregation function will suffice).
-- If a subquery is needed, determine where you’ll need to place it.
-- Run the subquery as an independent query first: is the output what you expect?
-- Call it something! If you are working with With or Inline subquery, you’ll most certainly need to name it.
-- Run the entire query -- both the inner query and outer query.

-- Use Case for With subquery:
-- When a user wants to create a version of an existing table to be used in a larger query (e.g., aggregate daily prices to an average price table).
-- It is advantageous for readability purposes.
WITH average_price as
( SELECT brand_id, AVG(product_price) as brand_avg_price
  FROM product_records
),
SELECT a.brand_id, a.total_brand_sales, b.brand_avg_price
FROM brand_table a
JOIN average_price b
ON b.brand_id = a.brand_id
ORDER BY a.total_brand_sales desc;


-- Use Case for With subquery:
-- When a user wants to create a version of an existing table to be used in a larger query (e.g., aggregate daily prices to an average price table).
-- It is advantageous for readability purposes.

WITH average_price as
( SELECT brand_id, AVG(product_price) as brand_avg_price
  FROM product_records
),
SELECT a.brand_id, a.total_brand_sales, b.brand_avg_price
FROM brand_table a
JOIN average_price b
ON b.brand_id = a.brand_id
ORDER BY a.total_brand_sales desc;

SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;

WITH events AS (
          SELECT DATE_TRUNC('day',occurred_at) AS day, 
                        channel, COUNT(*) as events
          FROM web_events 
          GROUP BY 1,2)

WITH table1 AS (
          SELECT *
          FROM web_events),

     table2 AS (
          SELECT *
          FROM accounts)


SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;

WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;

WITH t1 AS (
   SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY r.name), 
t2 AS (
   SELECT MAX(total_amt)
   FROM t1)
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

WITH t1 AS (
  SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1), 
t2 AS (
  SELECT a.name
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1
  HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;

WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;

WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 10)
SELECT AVG(tot_spent)
FROM t1;

WITH t1 AS (
   SELECT AVG(o.total_amt_usd) avg_all
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id),
t2 AS (
   SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
   FROM orders o
   GROUP BY 1
   HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
SELECT AVG(avg_amt)
FROM t2;
