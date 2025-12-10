--create staging copy of customer table--
CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.customers_cleaned`AS
SELECT 
       customer_id,
       name,
       gender,
       SAFE_CAST(age AS INT64) AS age,
       join_date,
       churn_status

FROM `maureen-amori-389118.RetailCo.customers`
WHERE customer_id IS NOT NULL;
