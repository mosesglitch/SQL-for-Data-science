-- A subquery is a query within a query.
-- The subquery that sits nested inside a larger query is called an INNER QUERY.

-- Use Cases:
-- Subquery: When an existing table needs to be manipulated or aggregated to then be joined to a larger table.

-- Joins: A fully flexible and discretionary use case where a user wants to bring two or more tables together and select and filter as needed.

-- Subqueries:
-- Output: Either a scalar (a single value) or rows that have met a condition. 
-- Use Case: Calculate a scalar value to use in a later part of the query (e.g., average price as a filter). 
-- Dependencies: Stand independently and be run as complete queries themselves.

-- Joins:
-- Output: A joint view of multiple tables stitched together using a common “key”. 
-- Use Case: Fully stitch tables together and have full flexibility on what to “select” and “filter from”. 
-- Dependencies: Cannot stand independently.



