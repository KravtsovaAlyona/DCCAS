DROP VIEW IF EXISTS dm_v15_otd_monthly;
CREATE VIEW dm_v15_otd_monthly AS
SELECT
    purchase_month AS month,
    region,
    COUNT(*) AS delivered_orders,
    SUM(CASE WHEN is_late = 0 THEN 1 ELSE 0 END) AS on_time_orders,
    SUM(CASE WHEN is_late = 1 THEN 1 ELSE 0 END) AS late_orders,
    SUM(CASE WHEN is_late = 1 THEN delay_days ELSE 0 END) AS late_days_sum
FROM core_order
WHERE order_status = 'delivered'
  AND purchase_month BETWEEN '2017-01-01' AND '2018-08-01'
  AND delivered_ts IS NOT NULL
  AND estimated_date IS NOT NULL
  AND region IS NOT NULL
GROUP BY purchase_month, region;
