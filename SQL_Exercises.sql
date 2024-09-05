SELECT * FROM departments;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM customers;

-- EX 1
SELECT customer_id, customer_fname, customer_lname, COUNT(orders.order_id) AS customer_order_count 
FROM customers 
JOIN orders ON customers.customer_id = orders.order_customer_id 
WHERE extract(year from order_date) = '2014' 
GROUP BY customer_id ORDER BY customer_order_count DESC;

-- Ex 2
SELECT customer_id, customer_fname, customer_lname, COUNT(orders.order_id) AS customer_order_count 
FROM customers 
LEFT OUTER JOIN orders ON customers.customer_id = orders.order_customer_id 
WHERE extract(year from order_date) = '2014' 
GROUP BY customer_id ORDER BY customer_order_count ;

-- Ex 3 
SELECT customer_id, customer_fname, customer_lname, 
SUM(CASE WHEN order_items.order_item_subtotal IS NULL THEN 0 ELSE order_items.order_item_subtotal END) AS total_revnew
FROM customers
LEFT OUTER JOIN orders ON customers.customer_id = orders.order_customer_id AND extract(year from order_date) = '2014' 
LEFT OUTER JOIN order_items ON orders.order_id = order_items.order_item_order_id
GROUP BY customer_id  ORDER BY customer_id ASC;


-- Ex 4
SELECT categories.*  ,
SUM(order_items.order_item_subtotal) AS total_revnew
FROM orders
JOIN order_items ON orders.order_id = order_items.order_item_order_id AND extract(year from order_date) = '2014' 
JOIN products ON products.product_id = order_items.order_item_product_id
JOIN categories ON products.product_category_id = categories.category_id
GROUP BY categories.category_id ;

-- Ex 5

SELECT departments.*, COUNT(products.product_id) AS product_count
FROM departments
JOIN categories ON categories.category_department_id = departments.department_id
JOIN products ON categories.category_id = products.product_category_id
GROUP BY departments.department_id ORDER BY departments.department_id ASC;






























