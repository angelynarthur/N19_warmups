-- Get a list of the 3 long-standing customers for each country

WITH customer_info AS (SELECT customers.customer_id, orders.order_date, customers.country 
FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id),

top_3_customers AS (SELECT *, RANK() OVER (PARTITION BY country ORDER BY order_date) FROM customer_info
)

SELECT * from top_3_customers
WHERE rank <= 3;

-- Modify the previous query to get the 3 newest customers in each each country.

WITH customer_info AS (SELECT customers.customer_id, orders.order_date, customers.country 
FROM customers INNER JOIN orders ON orders.customer_id = customers.customer_id),

top_3_customers AS (SELECT *, RANK() OVER (PARTITION BY country ORDER BY order_date desc) FROM customer_info
				
)

SELECT * from top_3_customers
WHERE rank <= 3;


-- Get the 3 most frequently ordered products in each city

WITH product_info AS (SELECT customers.customer_id, orders.order_date, customers.city, order_details.quantity, products.product_name
FROM customers inner join orders on customers.customer_id = orders.customer_id
inner join order_details on order_details.order_id = orders.order_id 
inner join products on products.product_id = order_details.product_id),


top_3_orders AS (SELECT *, RANK() OVER (PARTITION BY city ORDER BY quantity desc) FROM product_info
				
)

SELECT * from top_3_orders
WHERE rank <= 3;

-- FOR SIMPLICITY, we're interpreting "most frequent" as 
-- "highest number of total units ordered within a country"
-- hint: do something with the quanity column