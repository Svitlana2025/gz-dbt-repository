select c.date_date,
 round((f.operational_margin - c.ads_cost), 1) AS ads_margin,
 f.average_basket,
 round(f.operational_margin, 1) AS operational_margin,
 c.ads_cost,
 c.ads_impression,
 c.ads_clicks,
 f.quantity,
 f.revenue,
 f.purchase_cost,
 f.margin,
 f.shipping_fee,
 f.logcost
FROM {{ref('int_campaigns_day')}} c
JOIN {{ref('finance_days')}} f
USING (date_date)