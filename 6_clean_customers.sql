-- clean and standardize customer data--
CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.customers_processed` AS
SELECT
  customer_id,
  INITCAP(TRIM(name)) AS name_cleaned,  -- trim and capitalize names

  -- Clean gender column
  CASE 
    WHEN gender = 'm' THEN 'Male'
    WHEN gender = 'f' THEN 'Female'
    WHEN gender = 'Fem' THEN 'Female'
    ELSE 'Unknown'
  END AS gender_cleaned,

  -- Age groups
  CASE
    WHEN age is NULL THEN 'Unknown'
    WHEN age >= 18 AND age < 30 THEN '18-29'
    WHEN age >= 30 AND age < 40 THEN '30-39'
    WHEN age >= 40 AND age < 50 THEN '40-49'
    ELSE 'Over 50'
  END AS age_group,

  -- Parse join date safely and filter out future dates
  COALESCE(
SAFE.PARSE_DATE('%m/%d/%Y', join_date),
SAFE.PARSE_DATE('%m-%d-%y', join_date),
  SAFE.PARSE_DATE('%m/%d/%y', join_date),
  SAFE.PARSE_DATE('%m-%d-%y', join_date),
  SAFE.PARSE_DATE('%d/%m/%Y', join_date),
  SAFE.PARSE_DATE('%d-%m-%y', join_date),
  SAFE.PARSE_DATE('%d/%m/%y', join_date),
  SAFE.PARSE_DATE('%d-%m-%y', join_date),
  SAFE.PARSE_DATE('%Y/%m/%d', join_date),
   SAFE.PARSE_DATE('%y/%m/%d', join_date),
    SAFE.PARSE_DATE('%Y-%m-%d', join_date)
) AS join_date_cleaned,

  -- Clean churn status
  CASE
    WHEN LOWER(TRIM(churn_status)) IN ('1','true','yes','y','Yes','churned') THEN 'Churned'
    WHEN LOWER(TRIM(churn_status)) IN ('0','false','no','n','active','No') THEN 'Active'
    ELSE NULL
  END AS churn_status_cleaned

FROM `maureen-amori-389118.RetailCo.customers_cleaned`
WHERE 
  customer_id IS NOT NULL
  AND age >= 18 AND age<=100
  AND(join_date IS NULL OR
COALESCE(
SAFE.PARSE_DATE('%m/%d/%Y', join_date),
SAFE.PARSE_DATE('%m-%d-%y', join_date),
  SAFE.PARSE_DATE('%m/%d/%y', join_date),
  SAFE.PARSE_DATE('%m-%d-%y', join_date),
  SAFE.PARSE_DATE('%d/%m/%Y', join_date),
  SAFE.PARSE_DATE('%d-%m-%y', join_date),
  SAFE.PARSE_DATE('%d/%m/%y', join_date),
  SAFE.PARSE_DATE('%d-%m-%y', join_date),
  SAFE.PARSE_DATE('%Y/%m/%d', join_date),
   SAFE.PARSE_DATE('%y/%m/%d', join_date),
    SAFE.PARSE_DATE('%Y-%m-%d', join_date)
)
   <= CURRENT_DATE()
  );
