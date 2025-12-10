--Joining all tables into one for analysis--
CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.Analysis_table` AS
SELECT
    cust.customer_id,
    cust.gender_cleaned,
    cust.age_group,
    cust.join_date_cleaned,
    cust.churn_status_cleaned,

    -- Aggregations
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT comp.complaint_id) AS total_complaints,
    COUNT(DISTINCT prod.product_id) AS total_products,
    SUM(o.order_value_cleaned) AS total_order_value,
    ROUND(AVG(o.order_value_cleaned),2) AS avg_order_value,
    SUM(o.quantity_cleaned) AS total_quantity,
    SUM(comp.resolution_time_days_cleaned) AS total_resolution_time,
    ROUND(AVG(comp.resolution_time_days_cleaned),2) AS avg_resolution_time,
    
    -- Sample complaint info
    ANY_VALUE(comp.complaint_type_cleaned) AS sample_complaint_type,
    ANY_VALUE(comp.complaint_status_cleaned) AS sample_complaint_status

FROM `maureen-amori-389118.RetailCo.customers_processed` cust

LEFT JOIN `maureen-amori-389118.RetailCo.complaints_processed` comp
    ON cust.customer_id = comp.customer_id

LEFT JOIN `maureen-amori-389118.RetailCo.orders_processed` o
    ON cust.customer_id = o.customer_id

LEFT JOIN `maureen-amori-389118.RetailCo.products_processed` prod
    ON o.product_id = prod.product_id

GROUP BY
    cust.customer_id,
    cust.gender_cleaned,
    cust.age_group,
    cust.join_date_cleaned,
    cust.churn_status_cleaned;
