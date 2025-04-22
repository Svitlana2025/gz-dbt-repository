WITH orders_margin AS (
    SELECT * FROM {{ ref('int_orders_margin') }}
),
shipping AS (
    SELECT * FROM {{ ref('stg_raw__ship') }}
)

SELECT
    orders_margin.orders_id,
    orders_margin.date_date,
    orders_margin.margin + shipping.shipping_fee - shipping.logcost - shipping.ship_cost AS operational_margin
FROM orders_margin
LEFT JOIN shipping
    ON orders_margin.orders_id = shipping.orders_id
