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

-- SELECT
--     op.order_id AS order_id,
--     COUNT(DISTINCT(op.product_id)) AS n_distinct_products,
--     SUM(p.price * op.qty) AS order_amount_spent
-- FROM customer c
-- INNER JOIN customer_order co
--     ON c.customer_id = co.customer_id
-- INNER JOIN order_product op
--     ON co.order_id = op.order_id
-- INNER JOIN product p
--     ON op.product_id = p.product_id
-- WHERE c.customer_id = 1026
-- GROUP BY op.order_id;

-- 5. Get the 10 customers that have spent the most. Give the customer_id and amount spent

-- SELECT
--     c.customer_id AS customer_id,
--     SUM(p.price * op.qty) AS order_amount_spent
-- FROM customer c
-- INNER JOIN customer_order co
--     ON c.customer_id = co.customer_id
-- INNER JOIN order_product op
--     ON co.order_id = op.order_id
-- INNER JOIN product p
--     ON op.product_id = p.product_id
-- GROUP BY c.customer_id
-- ORDER BY order_amount_spent DESC
-- LIMIT 10;

-- 6. Repeat the previous question, but include the customer's name, address, and state,
-- in addition to the customer id and total amount spent

-- SELECT
--     c.customer_id AS customer_id,
--     c.name AS cust_name,
--     c.address AS cust_address,
--     c.state AS cust_state,
--     SUM(p.price * op.qty) AS order_amount_spent
-- FROM customer c
-- INNER JOIN customer_order co
--     ON c.customer_id = co.customer_id
-- INNER JOIN order_product op
--     ON co.order_id = op.order_id
-- INNER JOIN product p
--     ON op.product_id = p.product_id
-- GROUP BY c.customer_id
-- ORDER BY order_amount_spent DESC
-- LIMIT 10;

-- 7. Find the 10 customers that spent the most in 2017. Give the name and amount spent.
-- Take the date to be the order date (not the delivery date)

SELECT
    c.customer_id AS customer_id,
    c.name AS cust_name,
    EXTRACT(YEAR FROM co.date_ordered) AS year_ordered,
    SUM(p.price * op.qty) AS order_amount_spent
FROM customer c
INNER JOIN customer_order co
    ON c.customer_id = co.customer_id
INNER JOIN order_product op
    ON co.order_id = op.order_id
INNER JOIN product p
    ON op.product_id = p.product_id
WHERE EXTRACT(YEAR FROM co.date_ordered) = 2017
GROUP BY
    c.customer_id,
    c.name,
    EXTRACT(YEAR FROM co.date_ordered)
ORDER BY order_amount_spent DESC
LIMIT 10;