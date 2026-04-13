
-- ================================================
-- E-Commerce Cohort & Revenue Analysis — SQL Queries
-- Author: Parshwa Shah
-- Dataset: Brazilian E-Commerce by Olist
-- ================================================

-- Query 1: Monthly Revenue Trend
SELECT
    STRFTIME('%Y-%m', order_purchase_timestamp) AS month,
    COUNT(DISTINCT order_id)                    AS total_orders,
    ROUND(SUM(payment_value), 2)                AS total_revenue,
    ROUND(AVG(payment_value), 2)                AS avg_order_value,
    COUNT(DISTINCT customer_id)                 AS unique_customers
FROM ecommerce
GROUP BY month
ORDER BY month;

-- Query 2: Top 10 Product Categories by Revenue
SELECT
    COALESCE(product_category_name_english, 'Unknown') AS category,
    COUNT(DISTINCT order_id)      AS total_orders,
    ROUND(SUM(payment_value), 2)  AS total_revenue,
    ROUND(AVG(payment_value), 2)  AS avg_order_value
FROM ecommerce
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 3: Revenue by Customer State
SELECT
    customer_state              AS state,
    COUNT(DISTINCT order_id)    AS total_orders,
    ROUND(SUM(payment_value),2) AS total_revenue,
    ROUND(AVG(payment_value),2) AS avg_order_value
FROM ecommerce
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 4: Payment Method Breakdown
SELECT
    payment_type,
    COUNT(*)                      AS total_transactions,
    ROUND(SUM(payment_value), 2)  AS total_value,
    ROUND(AVG(payment_value), 2)  AS avg_value,
    ROUND(COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(), 2)  AS pct_of_transactions
FROM payments
GROUP BY payment_type
ORDER BY total_value DESC;

-- Query 5: Top 10 Sellers by Revenue
SELECT
    seller_id,
    seller_state,
    COUNT(DISTINCT order_id)    AS total_orders,
    ROUND(SUM(payment_value),2) AS total_revenue,
    ROUND(AVG(payment_value),2) AS avg_order_value
FROM ecommerce
GROUP BY seller_id, seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 6: Weekday vs Weekend Orders
SELECT
    CASE
        WHEN CAST(STRFTIME('%w', order_purchase_timestamp) AS INTEGER)
             IN (0,6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(DISTINCT order_id)      AS total_orders,
    ROUND(SUM(payment_value), 2)  AS total_revenue,
    ROUND(AVG(payment_value), 2)  AS avg_order_value
FROM ecommerce
GROUP BY day_type;
