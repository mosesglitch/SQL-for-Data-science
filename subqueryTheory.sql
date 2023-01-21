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

-- Fundamentals to Know about Subqueries:
-- Subqueries must be fully placed inside parentheses.
-- Subqueries must be fully independent and can be executed on their own
-- Subqueries have two components to consider:
-- Where it’s placed
-- Dependencies with the outer/larger query

-- When a subquery, typically in the form of a nested or inline subquery, is correlated to its outer query, it cannot run independently. 
-- This is most certainly an edge case since correlated subqueries are rarely implemented compared to standalone, simple subqueries.

-- Placement:
-- With
-- Nested
-- Inline
-- Scalar

-- , the decision of which placement to leverage stems from 
-- (1) the problem at hand and 
-- (2) the readability of the query.

-- Subquery Placement:
-- With: This subquery is used when you’d like to “pseudo-create” a table from an existing table and visually scope the temporary table at the top of the larger query.

-- Nested: This subquery is used when you’d like the temporary table to act as a filter within the larger query, which implies that it often sits within the where clause.

-- Inline: This subquery is used in the same fashion as the WITH use case above. However, instead of the temporary table sitting on top of the larger query, it’s embedded within the from clause.

-- Scalar: This subquery is used when you’d like to generate a scalar value to be used as a benchmark of some sort.

-- Readability: With and Nested subqueries are most advantageous for readability.

-- Performance: Scalar subqueries are advantageous for performance and are often used on smaller datasets.