{{ config(materialized='table') }}

SELECT
  DATE_TRUNC(date_date, MONTH) AS datemonth,
  SUM(ads_margin) AS ads_margin,
  SUM(average_basket) AS average_basket,
  SUM(operational_margin) AS operational_margin,
  SUM(ads_cost) AS ads_cost,
  SUM(ads_impression) AS ads_impression,
  SUM(ads_clicks) AS ads_clicks,
  SUM(quantity) AS quantity,
  SUM(revenue) AS revenue,
  SUM(purchase_cost) AS purchase_cost,
  SUM(margin) AS margin,
  SUM(shipping_fee) AS shipping_fee,
  SUM(logcost) AS logcost
FROM {{ ref('finance_campaigns_day') }}
GROUP BY datemonth
ORDER BY datemonth DESC
