--clean and standardize complaints data--
CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.complaints_processed` AS
SELECT
   complaint_id,
   customer_id,
/*converting complaint date column from string to date type*/
COALESCE(
SAFE.PARSE_DATE('%d/m/%Y',complaint_date), --dd/mm/yyyy--
SAFE.PARSE_DATE('%d/m/%y',complaint_date), --dd/mm/yy--
SAFE.PARSE_DATE('%m/d/%Y',complaint_date), --mm/dd/YYYY--
SAFE.PARSE_DATE('%m/d/%y',complaint_date) --mm/dd/yy--
)
 AS complaint_date_cleaned,

/*converting resolution time days from string to interger*/
CASE
WHEN SAFE_CAST(resolution_time_days AS INT64)>= 0 THEN SAFE_CAST(resolution_time_days AS INT64)
ELSE NULL
END AS resolution_time_days_cleaned,

/*clean complaint type and complaint status*/
/* Trim and capitalize complaint type and status*/
CASE
WHEN LOWER(TRIM(complaint_type)) ='damagd product' THEN 'Damaged Product'
WHEN LOWER(TRIM(complaint_type)) ='late delivary' THEN 'Late Delivery'
WHEN LOWER(TRIM(complaint_type)) ='Lost item' THEN 'Lost Item'
WHEN LOWER(TRIM(complaint_type)) = 'pendng' THEN 'Pending'
ELSE INITCAP(TRIM(complaint_type))
END AS complaint_type_cleaned,
INITCAP(TRIM(complaint_status)) AS complaint_status_cleaned
FROM `maureen-amori-389118.RetailCo.complaints_cleaned`
WHERE 
complaint_id IS NOT NULL
AND customer_id IS NOT NULL;