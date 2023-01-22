AGGREGATE_FUNCTION (column_1) OVER
 (PARTITION BY column_2 ORDER BY column_3)
  AS new_column_name;

  PARTITION BY: A subclause of the OVER clause. I like to think of PARTITION BY as the GROUP BY equivalent in window functions
  OVER: This syntax signals a window function and precedes the details of the window function itself.

  An aggregation function (e.g., sum, count, or average) + the column you’d like to track
OVER
PARTITION BY + the column you’d like to “group by”
ORDER BY (optional and is often a date column)
AS + the new column name

SELECT standard_amt_usd,
       SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders

SELECT standard_amt_usd,
       DATE_TRUNC('year', occurred_at) as year,
       SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders


SELECT order_id,
       order_total,
       order_price,
       SUM(order_total) OVER
           (PARTITION BY month(order_date) ORDER BY order_date) AS running_monthly_sales,
       COUNT(order_id) OVER
           (PARTITION BY month(order_date) ORDER BY order_date) AS running_monthly orders,
       AVG(order_price) OVER
           (PARTITION BY month(order_date) ORDER BY order_date) AS average_monthly_price
FROM  amazon_sales_db
WHERE order_date < '2017-01-01';

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS sum_standard_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS count_standard_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS avg_standard_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS min_standard_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at)) AS max_standard_qty
FROM orders


--Ranking window functions
-- Row_number(): Ranking is distinct amongst records even with ties in what the table is ranked against.
-- Rank(): Ranking is the same amongst tied values and ranks skip for subsequent values.
-- Dense_rank(): Ranking is the same amongst tied values and ranks do not skip for subsequent values.

SELECT ROW_NUMBER() OVER(ORDER BY date_time) AS rank,
       date_time
FROM   db;
SELECT RANK() OVER(ORDER BY date_time) AS rank,
       date_time
FROM   db;
SELECT DENSE_RANK() OVER(ORDER BY date_time) AS rank,
       date_time
FROM   db;