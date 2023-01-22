-- When exactly do you use window functions

-- When you want to measure trends or changes over rows or records in your data.
-- When you want to rank a column for outreach or prioritization.
-- e.g

-- Window Function: A window function is a calculation across a set of rows in a table that are somehow related to the current row. This means we’re typically:

-- Calculating running totals that incorporate the current row or,
-- Ranking records across rows, inclusive of the current one

-- A window function is similar to aggregate functions combined with group by clauses but have one key difference: 
-- Window functions retain the total number of rows between the input table and the output table (or result). 
-- Behind the scenes, the window function is able to access more than just the current row of the query result.

-- When window functions are used, you’ll notice new column names like the following:
-- Average running price
-- Running total orders
-- Running sum sales
-- Rank
-- Percentile

-- SELECT order_id,
--        order_date,
--        SUM(order_total) OVER
--           (PARTITION BY month(order_date) ORDER BY order_date)
--           AS running_monthly_sales
-- FROM amazon_db
-- WHERE order_date>'2017-01-01';

-- Partition by: A subclause of the OVER clause. Similar to GROUP BY.
-- Over: Typically precedes the partition by that signals what to “GROUP BY”.
-- Aggregates: Aggregate functions that are used in window functions, too (e.g., sum, count, avg).
-- Row_number(): Ranking function where each row gets a different number.
-- Rank(): Ranking function where a row could get the same rank if they have the same value.
-- Dense_rank(): Ranking function similar to rank() but ranks are not skipped with ties.
-- Aliases: Shorthand that can be used if there are several window functions in one query.
-- Percentiles: Defines what percentile a value falls into over the entire table.
-- Lag/Lead: Calculating differences between rows’ values.


