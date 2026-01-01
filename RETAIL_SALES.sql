-- Database Creation 
CREATE DATABASE SQL_PROJECT_1;
USE SQL_PROJECT_1;

-- Table Creation
CREATE TABLE RETAIL_SALES (
transactions_id INT PRIMARY KEY,
 sale_date DATE,
 sale_time TIME,
 customer_id INT,
 gender VARCHAR(15),
 age INT,
 category VARCHAR(50),
 quantiy INT,
 price_per_unit FLOAT, 
 cogs FLOAT, 
 total_sale float
);

-- Record Count
SELECT COUNT(*) FROM RETAIL_SALES;

-- Customer Count
SELECT COUNT(DISTINCT customer_id) FROM RETAIL_SALES;

-- Category Count
SELECT COUNT(DISTINCT CATEGORY) AS CATEGORIES_COUNT FROM RETAIL_SALES;
-- Null Value Check: Check for any null values in the dataset and delete records with missing data.
SELECT * FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL OR SALE_DATE IS NULL OR 
CUSTOMER_ID IS NULL OR GENDER IS NULL OR AGE IS NULL OR CATEGORY IS NULL OR quantiy IS NULL
OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;

DELETE FROM RETAIL_SALES WHERE TRANSACTIONS_ID IS NULL OR SALE_DATE IS NULL OR 
CUSTOMER_ID IS NULL OR GENDER IS NULL OR AGE IS NULL OR CATEGORY IS NULL OR quantiy IS NULL
OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM RETAIL_SALES WHERE SALE_DATE = '2022-11-05';

-- Write a SQL query to retrieve all transactions 
-- where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM RETAIL_SALES WHERE
CATEGORY='CLOTHING' AND QUANTIY>4 AND
SALE_DATE BETWEEN '2022-11-1' AND '2022-11-30';
-- TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11';

-- Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT CATEGORY,SUM(TOTAL_SALE) AS TOTAL_SAL FROM RETAIL_SALES
GROUP BY  CATEGORY;

Write a -- SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT CATEGORY,AVG(AGE) AS AVG_AGE FROM RETAIL_SALES 
GROUP BY CATEGORY
HAVING CATEGORY='BEAUTY';

-- WITH WHERE 
SELECT AVG(AGE) FROM RETAIL_SALES 
WHERE CATEGORY='BEAUTY';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.: 
SELECT* FROM RETAIL_SALES 
WHERE TOTAL_SALE>1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT CATEGORY,GENDER,COUNT(*) AS TOTAL_TRANS
FROM RETAIL_SALES 
GROUP BY CATEGORY,GENDER
ORDER BY 1; 

-- Write a SQL query to calculate the average sale for each
--  month. Find out best selling month in each year:
SELECT 
	EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
    EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
    AVG(TOTAL_SALE) AS AVG_SALE
FROM RETAIL_SALES
GROUP BY YEAR,MONTH
ORDER BY YEAR,AVG_SALE DESC;
   
--   **Write a SQL query to find the top 5 customers based on the highest total sales **:  
SELECT CUSTOMER_ID ,SUM(TOTAL_SALE) FROM RETAIL_SALES
GROUP BY CUSTOMER_ID
ORDER BY SUM(TOTAL_SALE) DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT CATEGORY,COUNT(DISTINCT CUSTOMER_ID) FROM RETAIL_SALES
GROUP BY CATEGORY; 


-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT * ,
CASE 
WHEN EXTRACT(HOUR FROM SALE_TIME )<12 THEN 'MORNING'
WHEN EXTRACT(HOUR FROM SALE_TIME )BETWEEN 12 AND 17 THEN 'AFTERNOON'
ELSE 'EVENING'
END AS SHIFT
FROM RETAIL_SALES;

