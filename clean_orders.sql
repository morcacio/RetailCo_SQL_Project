--clean and standardize orders data--
CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.orders_processed` AS
SELECT
 order_id,
  customer_id,
  product_id,

--Clean and validate date column--
COALESCE(
  SAFE.PARSE_DATE('%m/%d/%Y', order_date)
)
  AS order_date_cleaned,
  
 --Clean quantity column--
 CASE
 WHEN LOWER(TRIM(quantity)) = 'two' THEN 2
 ELSE CAST (quantity AS INT64)
 END
 AS quantity_cleaned,

--Clean order value--
SAFE_CAST(REGEXP_REPLACE(order_value,r'[^0-9\.]','')AS NUMERIC) AS order_value_cleaned
  FROM
  `maureen-amori-389118.RetailCo.orders_cleaned`
WHERE
order_id IS NOT NULL
AND customer_id IS NOT NULL
AND product_id IS NOT NULL
AND quantity IS NOT NULL
AND SAFE.PARSE_DATE('%m/%d/%Y', order_date) <=CURRENT_DATE();