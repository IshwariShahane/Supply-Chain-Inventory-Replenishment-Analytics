CREATE TABLE inventory_data (
    date DATE,
    store_id VARCHAR(20),
    product_id VARCHAR(20),
    category VARCHAR(50),
    region VARCHAR(50),
    inventory NUMERIC,
    units_sold NUMERIC,
    units_ordered NUMERIC,
    price NUMERIC,
    discount NUMERIC,
    weather_condition VARCHAR(50),
    promotion VARCHAR(20),
    competitor_pricing NUMERIC,
    seasonality VARCHAR(50),
    epidemic VARCHAR(20),
    demand NUMERIC
);

SELECT COUNT(*) AS total_records
FROM inventory_data;

SELECT *
FROM inventory_data
LIMIT 10;

SELECT 
    SUM(units_sold * price) AS total_sales_value
FROM inventory_data;

--Find Total Units Sold
SELECT 
    SUM(units_sold) AS total_units_sold
FROM inventory_data;

--Sales by Product
SELECT
    product_id,
    SUM(units_sold * price) AS total_sales
FROM inventory_data
GROUP BY product_id
ORDER BY total_sales DESC;

--Sales by Category
SELECT
    category,
    SUM(units_sold * price) AS total_sales
FROM inventory_data
GROUP BY category
ORDER BY total_sales DESC;

--Sales by Region
SELECT
    region,
    SUM(units_sold * price) AS total_sales
FROM inventory_data
GROUP BY region
ORDER BY total_sales DESC;

--Find Out-of-Stock Records
SELECT
    COUNT(*) AS oos_records
FROM inventory_data
WHERE inventory = 0;

--Calculate OOS Percentage in SQL
SELECT
    COUNT(*) FILTER (WHERE inventory = 0) * 100.0 / COUNT(*) AS oos_percentage
FROM inventory_data;

--Find OOS by Product
SELECT
    product_id,
    COUNT(*) AS oos_records
FROM inventory_data
WHERE inventory = 0
GROUP BY product_id
ORDER BY oos_records DESC;

--OOS by Category
SELECT
    category,
    COUNT(*) AS oos_records
FROM inventory_data
WHERE inventory = 0
GROUP BY category
ORDER BY oos_records DESC;

--Units Sold vs Units Ordered by Category
SELECT
    category,
    SUM(units_sold) AS total_units_sold,
    SUM(units_ordered) AS total_units_ordered
FROM inventory_data
GROUP BY category
ORDER BY total_units_sold DESC;

--Average Product Price by Category
SELECT
    category,
    ROUND(AVG(price), 2) AS average_price
FROM inventory_data
GROUP BY category
ORDER BY average_price DESC;

--Inventory by Category
SELECT
    category,
    SUM(inventory) AS total_inventory
FROM inventory_data
GROUP BY category
ORDER BY total_inventory DESC;

--Find the Top 5 Products by Sales
SELECT
    product_id,
    SUM(units_sold * price) AS total_sales
FROM inventory_data
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 5;

--Average Inventory by Product
SELECT
    product_id,
    ROUND(AVG(inventory), 2) AS average_inventory
FROM inventory_data
GROUP BY product_id
ORDER BY average_inventory DESC;

--Find Products with OOS Problems
SELECT
    product_id,
    SUM(units_sold * price) AS total_sales,
    COUNT(*) FILTER (WHERE inventory = 0) AS oos_records
FROM inventory_data
GROUP BY product_id
ORDER BY oos_records DESC;

CREATE TABLE product_info (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(50),
    supplier VARCHAR(50)
);

--Add Product Information
INSERT INTO product_info (product_id, product_name, supplier)
SELECT DISTINCT
    product_id,
    'Product ' || product_id,
    'Supplier ' || RIGHT(product_id, 2)
FROM inventory_data;

SELECT *
FROM product_info
ORDER BY product_id;

--First SQL JOIN 
SELECT
    i.product_id,
    p.product_name,
    p.supplier,
    i.category,
    i.inventory
FROM inventory_data i
JOIN product_info p
    ON i.product_id = p.product_id
LIMIT 10;

--JOIN + Sales Analysis
SELECT
    p.product_id,
    p.product_name,
    p.supplier,
    SUM(i.units_sold * i.price) AS total_sales
FROM inventory_data i
JOIN product_info p
    ON i.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.supplier
ORDER BY total_sales DESC;

--Replenishment Priority Analysis
WITH product_analysis AS (
    SELECT
        product_id,
        SUM(units_sold * price) AS total_sales,
        COUNT(*) AS total_records,
        COUNT(*) FILTER (WHERE inventory = 0) AS oos_records
    FROM inventory_data
    GROUP BY product_id
)
SELECT
    product_id,
    ROUND(total_sales, 2) AS total_sales,
    oos_records,
    ROUND(oos_records * 100.0 / total_records, 2) AS oos_percentage
FROM product_analysis
ORDER BY oos_records DESC, total_sales DESC;

--Replenishment Priority
SELECT
    product_id,
    ROUND(SUM(units_sold * price), 2) AS total_sales,
    ROUND(
        COUNT(*) FILTER (WHERE inventory = 0) * 100.0 / COUNT(*),
        2
    ) AS oos_percentage,
    CASE
        WHEN COUNT(*) FILTER (WHERE inventory = 0) * 100.0 / COUNT(*) >= 0.80
             THEN 'High Priority'
        WHEN COUNT(*) FILTER (WHERE inventory = 0) * 100.0 / COUNT(*) >= 0.50
             THEN 'Medium Priority'

			 
        ELSE 'Low Priority'
    END AS replenishment_priority
FROM inventory_data
GROUP BY product_id
ORDER BY oos_percentage DESC, total_sales DESC;

--Validation
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT product_id) AS total_products,
    COUNT(*) FILTER (WHERE inventory = 0) AS oos_records
FROM inventory_data;