WITH sales AS (
    SELECT * FROM {{ ref('stg_raw__sales') }}
),
products AS (
    SELECT * FROM {{ ref('stg_raw__product') }}
)

SELECT
    sales.date_date,
    sales.orders_id,
    sales.products_id,
    sales.revenue,
    sales.quantity,
    products.purchase_price,
    sales.quantity * products.purchase_price AS purchase_cost,
    sales.revenue - (sales.quantity * products.purchase_price) AS margin
FROM sales
LEFT JOIN products
    ON sales.products_id = products.products_id
