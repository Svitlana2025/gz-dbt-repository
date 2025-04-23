{{ config(materialized='table') }}

WITH orders_margin AS (
    SELECT * FROM {{ ref('int_orders_margin') }}
),
operational AS (
    SELECT * FROM {{ ref('int_orders_operational') }}
),
shipping AS (
    SELECT * FROM {{ ref('stg_raw__ship') }}
),
joined AS (
    SELECT
        om.date_date,
        om.orders_id,
        om.revenue,
        om.quantity,
        om.purchase_cost,
        om.margin,
        op.operational_margin,
        s.shipping_fee,
        s.logcost
    FROM orders_margin om
    LEFT JOIN operational op ON om.orders_id = op.orders_id
    LEFT JOIN shipping s ON om.orders_id = s.orders_id
)

SELECT
    date_date,
    COUNT(DISTINCT orders_id) AS nb_transactions,
    SUM(revenue) AS revenue,
    ROUND(SUM(revenue) / COUNT(DISTINCT orders_id), 2) AS average_basket,
    SUM(margin) AS margin,
    SUM(operational_margin) AS operational_margin,
    SUM(purchase_cost) AS purchase_cost,
    SUM(shipping_fee) AS shipping_fee,
    SUM(logcost) AS logcost,
    SUM(quantity) AS quantity
FROM joined
GROUP BY date_date
ORDER BY date_date
