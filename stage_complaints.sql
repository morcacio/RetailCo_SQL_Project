--create staging copy of complaint table--
CREATE OR REPLACE TABLE `maureen-amori-389118.RetailCo.complaints_cleaned` AS
SELECT complaint_id,
       customer_id ,
       complaint_date,
       complaint_type,
       resolution_time_days,
       complaint_status
FROM `maureen-amori-389118.RetailCo.complaints`;