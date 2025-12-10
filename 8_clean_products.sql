CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.products_processed` AS
SELECT
product_id,
INITCAP(TRIM(product_name)) AS product_name_cleaned,
--clean and correct category names using pattern matching--
CASE
WHEN LOWER(TRIM(category)) LIKE 'el%' THEN 'Electronics'
WHEN LOWER(TRIM(category)) LIKE 'fas%' THEN 'Fashion'
WHEN LOWER(TRIM(category)) LIKE 'gro%' THEN 'Grocery'
WHEN LOWER(TRIM(category)) LIKE 'auto%' THEN 'Automative'
ELSE INITCAP(TRIM(category))
END AS category_cleaned,
SAFE_CAST(price AS FLOAT64) AS price_cleaned
FROM `maureen-amori-389118.RetailCo.products_cleaned`
WHERE product_id IS NOT NULL;
