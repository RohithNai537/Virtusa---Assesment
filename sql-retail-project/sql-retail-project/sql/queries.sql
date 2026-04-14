-- ============================================================
--  Online Retail Sales Analysis Database
--  queries.sql  –  Business Intelligence Queries
-- ============================================================

-- ──────────────────────────────────────────────────────────
-- Q1. Top-Selling Products  (by total units sold)
-- ──────────────────────────────────────────────────────────
SELECT
    p.product_id,
    p.name                              AS product_name,
    p.category,
    p.price,
    SUM(oi.quantity)                    AS total_units_sold,
    SUM(oi.quantity * p.price)          AS total_revenue
FROM   Order_Items oi
JOIN   Products    p  ON p.product_id = oi.product_id
GROUP  BY p.product_id
ORDER  BY total_units_sold DESC
LIMIT  10;

-- ──────────────────────────────────────────────────────────
-- Q2. Most Valuable Customers  (by total spend)
-- ──────────────────────────────────────────────────────────
SELECT
    c.customer_id,
    c.name                                  AS customer_name,
    c.city,
    COUNT(DISTINCT o.order_id)              AS total_orders,
    SUM(oi.quantity * p.price)              AS total_spent
FROM   Customers   c
JOIN   Orders      o  ON o.customer_id  = c.customer_id
JOIN   Order_Items oi ON oi.order_id    = o.order_id
JOIN   Products    p  ON p.product_id   = oi.product_id
GROUP  BY c.customer_id
ORDER  BY total_spent DESC
LIMIT  10;

-- ──────────────────────────────────────────────────────────
-- Q3. Monthly Revenue  (all months, ordered chronologically)
-- ──────────────────────────────────────────────────────────
SELECT
    strftime('%Y-%m', o.date)       AS year_month,
    COUNT(DISTINCT o.order_id)      AS orders_placed,
    SUM(oi.quantity * p.price)      AS monthly_revenue
FROM   Orders      o
JOIN   Order_Items oi ON oi.order_id  = o.order_id
JOIN   Products    p  ON p.product_id = oi.product_id
GROUP  BY year_month
ORDER  BY year_month;

-- ──────────────────────────────────────────────────────────
-- Q4. Category-Wise Sales Analysis
-- ──────────────────────────────────────────────────────────
SELECT
    p.category,
    COUNT(DISTINCT p.product_id)        AS products_in_category,
    SUM(oi.quantity)                    AS units_sold,
    SUM(oi.quantity * p.price)          AS category_revenue,
    ROUND(
        100.0 * SUM(oi.quantity * p.price) /
        SUM(SUM(oi.quantity * p.price)) OVER (),
    2)                                  AS revenue_share_pct
FROM   Order_Items oi
JOIN   Products    p  ON p.product_id = oi.product_id
GROUP  BY p.category
ORDER  BY category_revenue DESC;

-- ──────────────────────────────────────────────────────────
-- Q5. Inactive Customers  (no orders in the last 180 days)
--     (reference date: 2025-01-01)
-- ──────────────────────────────────────────────────────────
SELECT
    c.customer_id,
    c.name,
    c.city,
    MAX(o.date)   AS last_order_date,
    CAST(
        julianday('2025-01-01') - julianday(MAX(o.date))
    AS INTEGER)   AS days_since_last_order
FROM   Customers c
JOIN   Orders    o ON o.customer_id = c.customer_id
GROUP  BY c.customer_id
HAVING days_since_last_order > 180
ORDER  BY days_since_last_order DESC;

-- ──────────────────────────────────────────────────────────
-- Q6. (Bonus) Average Order Value per City
-- ──────────────────────────────────────────────────────────
SELECT
    c.city,
    COUNT(DISTINCT o.order_id)                      AS total_orders,
    ROUND(AVG(order_totals.order_value), 2)         AS avg_order_value
FROM   Customers c
JOIN   Orders    o  ON o.customer_id = c.customer_id
JOIN (
    SELECT
        oi.order_id,
        SUM(oi.quantity * p.price) AS order_value
    FROM   Order_Items oi
    JOIN   Products    p ON p.product_id = oi.product_id
    GROUP  BY oi.order_id
)  order_totals ON order_totals.order_id = o.order_id
GROUP  BY c.city
ORDER  BY avg_order_value DESC;

-- ──────────────────────────────────────────────────────────
-- Q7. (Bonus) Products Never Ordered
-- ──────────────────────────────────────────────────────────
SELECT
    p.product_id,
    p.name       AS product_name,
    p.category,
    p.price
FROM   Products p
WHERE  p.product_id NOT IN (SELECT DISTINCT product_id FROM Order_Items)
ORDER  BY p.category, p.name;
