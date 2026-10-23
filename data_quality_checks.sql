SELECT * FROM olist_analytics.order_items;

USE olist_analytics;

SHOW VARIABLES LIKE 'local_infile';
USE olist_analytics;

SELECT COUNT(*) FROM order_items;
USE olist_analytics;

CREATE TABLE order_items_test
LIKE order_items;

SELECT COUNT(*) AS total_rows
FROM order_items;

DESCRIBE order_items_test;

USE olist_analytics;

SELECT COUNT(*) AS order_items_rows FROM order_items_test;

SELECT COUNT(*) AS customers_rows FROM customers;

SELECT COUNT(*) AS products_rows FROM products;

USE olist_analytics;

RENAME TABLE order_items TO order_items_old,
             order_items_test TO order_items;
             
SELECT COUNT(*) AS total_rows
FROM customers;
CREATE TABLE customers_test LIKE customers;
CREATE TABLE products_test LIKE products;
SELECT COUNT(*) AS total_rows
FROM products_test;

USE olist_analytics;
SHOW TABLES;

USE olist_analytics;

SELECT 'orders' AS table_name, COUNT(*) AS total_rows FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_items_old', COUNT(*) FROM order_items_old
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'customers_test', COUNT(*) FROM customers_test
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'products_test', COUNT(*) FROM products_test
UNION ALL
SELECT 'category_translation', COUNT(*) FROM customers_test;

DROP TABLE customers_test;
DROP TABLE products_test;
DROP TABLE order_items_old;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customer_ids
FROM customers;

SELECT
    customer_id,
    COUNT(*) AS occurrences
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC
LIMIT 10;

SELECT *
FROM customers
LIMIT 5;

DESCRIBE customers;

SELECT COUNT(*) AS distinct_rows
FROM (
    SELECT DISTINCT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    FROM customers
) AS unique_customers;
CREATE TABLE customers_clean AS
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM customers;

SELECT COUNT(*) AS total_rows
FROM customers_clean;
RENAME TABLE
    customers TO customers_backup,
    customers_clean TO customers;
    
    SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers;

DROP TABLE customers_backup;

select count(*) from customers_test;

DROP TABLE customers_test;
select count(*) from products;
DROP TABLE products_test;

SELECT COUNT(*) AS total_orders
FROM orders;

-- Check total order items
SELECT COUNT(*) AS total_order_items
FROM order_items;

-- Check total customers
SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_products
FROM products;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_products
FROM products;

SELECT
    product_id,
    COUNT(*) AS occurrences
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

SELECT *
FROM products
WHERE product_id IN (
    'a2e2851eae0aebb8ee4df32348b42e2b',
    'a5bc1334f1762ce0a844f3f694dc08e1',
    '701ff123e9085dcc9c2f833efded6374',
    '73b499a2f5002c0a2158a478cc5a096c',
    '47969dd948e918289f809be899ddfb4c',
    '0e40b1ed4cfd3da1962ec91913e54ba8',
    'ac1290e4432c1f2662b71ac47da47691',
    'dfa872802d781798321a10f1ddadea82',
    'ae6476ef6cf588ccb0bd009b62359b97',
    '5b4341a1e617e4d33c3305158ff03c69',
    '9e3fb85220e7c0d45fab9a93288ec717',
    'c8aa3a6754ab1ad362858eca26f58c8b',
    '4a0c2a56e65c941a0bb9874c47dd66d8',
    '98bf9f3941be6afbca9ea37f8eb0c466',
    '1fd95182c672cf5b10c82207ca5dab97',
    'ac01b71ddb644fe8806e71a6030accf9'
)
ORDER BY product_id;

USE olist_analytics;

CREATE TABLE products_clean AS
SELECT DISTINCT *
FROM products;

-- Check products table after removing exact duplicate rows
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_product_ids
FROM products_clean;

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    SUM(order_id IS NULL) AS null_order_ids
FROM orders;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id, order_item_id) AS unique_order_items,
    SUM(order_id IS NULL) AS null_order_ids,
    SUM(product_id IS NULL) AS null_product_ids
FROM order_items;

SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) AS unique_customer_ids,
    SUM(customer_id IS NULL) AS null_customer_ids
FROM customers;

SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_id) AS unique_product_ids,
    SUM(product_id IS NULL) AS null_product_ids,
    SUM(product_category_name IS NULL) AS null_categories
FROM products_clean;