--Create staging copy for products table--
CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.products_cleaned` AS
SELECT
 product_id,
       product_name,
       category,
       price
FROM `maureen-amori-389118.RetailCo.products`
WHERE product_id IS NOT NULL;
