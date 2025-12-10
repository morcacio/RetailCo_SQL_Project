--Create staging copy for orders table--
CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.orders_cleaned` AS
SELECT 
       order_id,
       customer_id,
       order_date,
       product_id,
       quantity,
       order_value
FROM `maureen-amori-389118.RetailCo.orders`
WHERE order_id IS NOT NULL
AND customer_id IS NOT NULL
AND product_id IS NOT NULL;
