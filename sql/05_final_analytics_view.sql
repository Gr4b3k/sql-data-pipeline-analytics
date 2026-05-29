CREATE OR REPLACE VIEW vw_sales_analysis AS
SELECT
    f.order_id,
    f.product_id,
    f.category_id,
    f.customer_id,
    f.date_key,
    f.order_date,
    p.product_name,
    c.category_name,
    cu.customer_address,
    f.quantity,
    f.price_each,
    f.cost_price,
    (f.quantity * f.price_each) AS turnover,
    (f.price_each - f.cost_price) * f.quantity AS margin,
	((f.price_each - f.cost_price) * f.quantity) / (f.quantity * f.price_each) AS margin_pct,
    (f.price_each - f.cost_price) AS unit_margin,
	(f.price_each - f.cost_price) / f.cost_price AS markup_pct,
    d.year,
    d.month,
    d.month_name,
    d.quarter,
    NOT d.is_weekend AS is_weekday,
    CASE 
        WHEN ROW_NUMBER() OVER (
            PARTITION BY cu.customer_id 
            ORDER BY f.order_date
        ) > 1 THEN TRUE
        ELSE FALSE
    END AS is_returning_customer

FROM fact_sales f
JOIN dim_product p ON f.product_id  = p.product_id
JOIN dim_category c ON f.category_id = c.category_id
JOIN dim_customer cu ON f.customer_id = cu.customer_id
JOIN dim_date d ON f.date_key = d.date_key;