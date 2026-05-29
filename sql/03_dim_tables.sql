DROP TABLE IF EXISTS dim_customer;

CREATE TABLE dim_customer AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_address) AS customer_id,
    customer_address
FROM(SELECT DISTINCT customer_address
     FROM int_sales_orders);

DROP TABLE IF EXISTS dim_category;

CREATE TABLE dim_category AS
SELECT
    ROW_NUMBER() OVER (ORDER BY category_name) AS category_id,
    category_name
FROM (
    SELECT DISTINCT category_name
    FROM int_sales_orders);

DROP TABLE IF EXISTS dim_product;

CREATE TABLE dim_product AS
SELECT
    ROW_NUMBER() OVER (ORDER BY product_name) AS product_id,
    product_name
FROM (
    SELECT DISTINCT product_name
    FROM int_sales_orders);

DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date AS
WITH bounds AS (
    SELECT
        MIN(order_date) AS min_date,
        MAX(order_date) AS max_date
    FROM int_sales_orders
),
calendar AS (
    SELECT
        GENERATE_SERIES(
            (SELECT min_date FROM bounds),
            (SELECT max_date FROM bounds),
            INTERVAL '1 day'
        )::date AS date
)
SELECT
    date AS date_key,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(QUARTER FROM date) AS quarter,
    EXTRACT(MONTH FROM date) AS month,
    TO_CHAR(date, 'Month') AS month_name,
    EXTRACT(DAY FROM date) AS day,
    EXTRACT(DOW FROM date) AS day_of_week,
    TO_CHAR(date, 'Day') AS day_name,
    CASE WHEN EXTRACT(DOW FROM date) IN (0, 6) THEN TRUE ELSE FALSE END AS is_weekend
FROM calendar
ORDER BY date;