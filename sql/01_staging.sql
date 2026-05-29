DROP TABLE IF EXISTS stg_sales_orders;
CREATE TABLE stg_sales_orders (
    order_date TIMESTAMP,
    order_id VARCHAR,
    product VARCHAR,
    product_ean VARCHAR(20),
    category VARCHAR,
    customer_address VARCHAR,
    quantity INTEGER,
    price_each NUMERIC(10,2),
    cost_price NUMERIC(10,2),
    turnover NUMERIC(10,2),
    margin NUMERIC(10,2)
);

COPY stg_sales_orders
FROM 'C:\project_sales\data\sales_data.csv'
DELIMITER ','
CSV HEADER;