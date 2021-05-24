-- 1. List the 10 most expensive products for sale, and their prices

-- SELECT
--     *
-- FROM product
-- ORDER BY price DESC
-- LIMIT 10;

-- 2. Which states have more than 5 customers? Use the state column on the customer table.
-- Count each customer on the table, regardless of whether they have ever bought anything.

-- SELECT
--     state,
--     COUNT(customer_id) AS count
-- FROM customer
-- GROUP BY state
-- HAVING COUNT(customer_id) > 5;

-- 3. Get the 17 customers that have made the largest number of orders.
-- Include the name, address, state, and number of orders made.

-- customer_name | cust_address | cust_state | n_orders

-- SELECT 
--     c.name AS name,
--     c.address AS address,
--     c.state AS state,
--     COUNT(co.order_id) as n_orders
-- FROM
--     customer c INNER JOIN customer_order co
--         ON c.customer_id = co.customer_id
-- GROUP BY
--     c.name,
--     c.address,
--     c.state
-- ORDER BY n_orders DESC
-- LIMIT 17;

-- 4. Get all orders by customer 1026.
-- Include the amount spent in each order, the order id, and the total number of distinct products purchased.
-- Hint: you may want to create views.

amount_spent | order_id | n_distinct

