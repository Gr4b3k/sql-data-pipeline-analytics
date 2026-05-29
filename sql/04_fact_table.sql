DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales AS
SELECT
    s.order_id,
	cu.customer_id,
    p.product_id,
    c.category_id,
    d.date_key,
    s.quantity,
    s.price_each,
    s.cost_price,
    s.order_date	

FROM int_sales_orders s
JOIN dim_product p ON s.product_name = p.product_name
JOIN dim_category c ON s.category_name = c.category_name
JOIN dim_date d ON s.order_date::date = d.date_key
JOIN dim_customer cu ON s.customer_address = cu.customer_address;