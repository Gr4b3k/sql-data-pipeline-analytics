SELECT 
    order_id, product,
    COUNT(*) AS cnt
FROM stg_sales_orders
GROUP BY order_id, product
HAVING COUNT(*) > 1
ORDER BY order_id;

SELECT COUNT(*) AS rows_with_nulls
FROM stg_sales_orders
WHERE 
    order_date IS NULL OR
    order_id IS NULL OR
    product IS NULL OR
    product_ean IS NULL OR
    category IS NULL OR
    customer_address IS NULL OR
    quantity IS NULL OR
    price_each IS NULL OR
    cost_price IS NULL OR
    turnover IS NULL OR
    margin IS NULL;

SELECT *
FROM stg_sales_orders
WHERE quantity <= 0;

SELECT *
FROM stg_sales_orders
WHERE price_each < 0 OR cost_price < 0;

SELECT *
FROM stg_sales_orders
WHERE turnover <> quantity * price_each;

SELECT *
FROM stg_sales_orders
WHERE margin <> turnover - (cost_price * quantity);
--margin do poprawy

SELECT *
FROM stg_sales_orders
WHERE price_each > 100000;

SELECT product_name, COUNT(DISTINCT category) AS unique_prices
FROM int_sales_orders
GROUP BY product_name
HAVING COUNT(DISTINCT category) > 1;

SELECT product_name, COUNT(DISTINCT price_each) AS unique_prices
FROM int_sales_orders
GROUP BY product_name
HAVING COUNT(DISTINCT price_each) > 1;

DROP TABLE IF EXISTS int_sales_orders;

CREATE TABLE int_sales_orders (
    order_date          TIMESTAMP,
    order_id            VARCHAR,
    product_name        VARCHAR(150),
    product_ean         VARCHAR(13),
    category_name       VARCHAR(50),
    customer_address    TEXT,
    quantity            INT,
    price_each          NUMERIC(10,2),
    cost_price          NUMERIC(10,2),
    turnover            NUMERIC(10,2)
);

INSERT INTO int_sales_orders
SELECT
    order_date,
    order_id,
    TRIM(product)::VARCHAR(150) AS product_name,
    CAST(SPLIT_PART(TRIM(product_ean), '.', 1) AS VARCHAR(13)) AS product_ean,
    CASE
        WHEN product IN ('Macbook Pro Laptop', 'ThinkPad Laptop')
            THEN 'Computers & Laptops'
        WHEN product IN ('iPhone', 'Google Phone', 'Vareebadd Phone',
                         'Lightning Charging Cable', 'USB-C Charging Cable')
            THEN 'Phones & Accessories'
        WHEN product IN ('Apple Airpods Headphones',
                         'Bose SoundSport Headphones', 'Wired Headphones')
            THEN 'Audio'
        WHEN product IN ('20in Monitor', '27in 4K Gaming Monitor',
                         '27in FHD Monitor', '34in Ultrawide Monitor', 'Flatscreen TV')
            THEN 'Monitors & TVs'
        WHEN product IN ('LG Dryer', 'LG Washing Machine')
            THEN 'Home Appliances'
        WHEN product IN ('AA Batteries (4-pack)', 'AAA Batteries (4-pack)')
            THEN 'Power & Batteries'
        ELSE 'Other'
    END::VARCHAR(50) AS category_name,
    TRIM(customer_address) AS customer_address,
    quantity,
    price_each,
    cost_price,
    turnover
FROM stg_sales_orders;