create database if not exists bmw_market_analysis;

use bmw_market_analysis;

SELECT 
    COUNT(*)
FROM
    bmw_sales_data;

SELECT 
    *
FROM
    bmw_sales_data;

alter table bmw_sales_data
add column Vehicle_Age INT;

SET SQL_SAFE_UPDATES = 0;

UPDATE bmw_sales_data 
SET 
    Vehicle_Age = 2026 - year;
SELECT 
    *
FROM
    bmw_sales_data;

ALTER TABLE bmw_sales_data
ADD COLUMN price_category VARCHAR(20);

UPDATE bmw_sales_data 
SET 
    price_category = CASE
        WHEN Price_USD < 50000 THEN 'Entry'
        WHEN Price_USD <= 80000 THEN 'Mid'
        ELSE 'Premium'
    END;
    
ALTER TABLE bmw_sales_data
ADD COLUMN mileage_category VARCHAR(20);

UPDATE bmw_sales_data 
SET 
    mileage_category = CASE
        WHEN Mileage_KM <= 60000 THEN 'Low'
        WHEN Mileage_KM <= 130000 THEN 'Medium'
        ELSE 'High'
    END;
    
SELECT 
    *
FROM
    bmw_sales_data;
  
-- Top selling models
SELECT 
    Model, SUM(Sales_Volume) AS total_sales
FROM
    bmw_sales_data
GROUP BY Model
ORDER BY total_sales DESC;

-- EV vs Non-EV performance
SELECT 
    Fuel_Type,
    AVG(Price_USD) AS avg_price,
    SUM(Sales_Volume) AS total_sales
FROM
    bmw_sales_data
GROUP BY Fuel_Type;

-- Premium vs Entry performance
SELECT 
    price_category,
    COUNT(*) AS models,
    SUM(Sales_Volume) AS total_sales
FROM
    bmw_sales_data
GROUP BY price_category;


-- Region-wise market performance
SELECT
    Region,
    SUM(Sales_Volume) AS total_sales,
    AVG(Price_USD) AS avg_price
FROM bmw_sales_data
GROUP BY Region
ORDER BY total_sales DESC;


-- Sales by vehicle age group
SELECT
    CASE
        WHEN Vehicle_Age <= 3 THEN 'New'
        WHEN Vehicle_Age <= 7 THEN 'Mid-age'
        ELSE 'Old'
    END AS vehicle_age_group,
    SUM(Sales_Volume) AS total_sales
FROM bmw_sales_data
GROUP BY vehicle_age_group
ORDER BY total_sales DESC;

-- High vs Low sales comparison
SELECT
    Sales_Classification,
    COUNT(*) AS model_count,
    SUM(Sales_Volume) AS total_sales
FROM bmw_sales_data
GROUP BY Sales_Classification;

-- Electric vehicle market share
SELECT
    Fuel_Type,
    ROUND(SUM(Sales_Volume) * 100.0 /
          (SELECT SUM(Sales_Volume) FROM bmw_sales_data), 2) AS sales_percentage
FROM bmw_sales_data
GROUP BY Fuel_Type;





