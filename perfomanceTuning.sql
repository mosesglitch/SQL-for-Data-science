-- One way to make a query run faster is to reduce the number of calculations that need to be performed. Some of the high-level things that will affect the number of calculations a given query will make include:

-- Table size
-- Joins
-- Aggregations

-- Other users running queries concurrently on the database
-- Database software and optimization (e.g., Postgres is optimized differently than Redshift)

-- The second thing you can do is to make joins less complicated, that is, reduce the number of rows that need to be evaluated. 
-- It is better to reduce table sizes before joining them.
--  This can be done by creating subqueries and joining them to an outer query. 
--  Aggregating before joining will improve query speed; however, be sure that what you are doing is logically consistent. 
-- Accuracy is more important than run speed.

SELECT DATE_TRUNC('day', o.occurred_at) AS date,
       COUNT(DISTINCT a.sales_rep_id) AS active_sales_reps,
       COUNT(DISTINCT o.id) AS orders,
       COUNT(DISTInct we.id) AS web_visits
FROM   accounts a
JOIN   orders o
ON     o.account_id = a.id
JOIN   web_events we
ON     DATE_TRUNC('day', we.occurred_at) = DATE_TRUNC('day', o.occurred_at)
GROUP BY 1
ORDER BY 1 DESC

SELECT o.occurred_at AS date,
       a.sales_rep_id,
       o.id AS order_id,
       we.id AS web_event_id
FROM   accounts a
JOIN   orders o
ON     o.account_id = a.id
JOIN   web_events we
ON     DATE_TRUNC('day', we.occurred_at) = DATE_TRUNC('day', o.occurred_at)
ORDER BY 1 DESC

SELECT DATE_TRUNC('day', o.occurred_at) AS date,
       orders.active_sales_reps
       COUNT(a.sales_rep_id) AS active_sales_reps,
       COUNT(DISTINCT o.id) AS orders
FROM   accounts a
JOIN   orders o
ON     o.account_id = a.id
JOIN   web_events we
ON     DATE_TRUNC('day', we.occurred_at) = DATE_TRUNC('day', o.occurred_at)
GROUP BY 1
ORDER BY 1 DESC

SELECT DATE_TRUNC('day', o.occurred_at) AS date,
       COUNT(DISTINCT a.sales_rep_id) AS active_sales_reps,
       COUNT(DISTINCT o.id) AS orders
FROM   accounts a
JOIN   orders o
ON     o.account_id = a.id
GROUP BY 1

SELECT DATE_TRUNC('day', we.occurred_at) AS date,
       COUNT(we.id) AS web_visits
FROM   web_events we
GROUP BY 1

SELECT COALESCE(orders.date, web_events.date) AS date,
       orders.active_sales_reps,
       orders.orders,
       web_events.web_visits
FROM(  
   SELECT DATE_TRUNC('day', o.occurred_at) AS date,
          COUNT(DISTINCT a.sales_rep_id) AS active_sales_reps,
          COUNT(DISTINCT o.id) AS orders
   FROM   accounts a
   JOIN   orders o
   ON     o.account_id = a.id
   GROUP BY 1) AS orders

FULL JOIN(
   SELECT DATE_TRUNC('day', we.occurred_at) AS date,
          COUNT(we.id) AS web_visits
   FROM   web_events we
   GROUP BY 1) AS web_events

ON orders.date = web_events.date
ORDER BY 1 DESC