-- MY FIRST PROJECT --
CREATE DATABASE SQL_project_P1;
USE SQL_project_p1;

CREATE TABLE RETAIL_SALES(
 transactions_id INT PRIMARY KEY,
 sale_date DATE,
 sale_time TIME,
 customer_id INT,
 gender VARCHAR(15),
 age INT,
 category VARCHAR(15),
 quantiy INT,
 price_per_unit FLOAT,
 cog FLOAT,
 total_sale FLOAT
);
SELECT * FROM RETAIL_SALES;

-- Data exploration--
-- How many sales we have --
SELECT COUNT(*) AS Total_sales FROM RETAIL_SALES;

-- How maney unique customers we have --
SELECT COUNT(DISTINCT  customer_id) AS Total_sales 
FROM RETAIL_SALES;

-- How maney unique category we have --
SELECT DISTINCT category AS Total_sales 
FROM RETAIL_SALES;

-- data analysis / business problems --

-- 1Q write a sql qurey to retrieve all columns for sales made on 2022-11-05 --
-- 2Q write a sql query to retrieve all transations where the category is 'Clothing' and the quantity sold is more than 3 in the month of nov-2022 --
-- 3Q write a sql query to calculate the total sales (total_sales) for each category --
-- 4Q write a sql query to find the average age of customer who purchase items from the 'beauty' category --
-- 5Q write a sql query to find all transactions where the total sales is greater than 1000 --
-- 6Q wite a sql query to find the total number of transations (transation_id) made by each gender in each category --
-- 7Q write a sql query to calculate the average sales for each month. find out best selling month in each year --
-- 8Q write a sql query to find the top five 5 customers based on highest sales --
-- 9Q write a sql query to find out the unique customers who purchased items from each category --
-- 10Q write a sql query to create each shift and numbers of orders (Example Morning <=12,Afternoon Between 12 & 17,Evening>17 --
 
 
 -- 1Q write a sql qurey to retrieve all columns for sales made on 2022-11-05 --
Select * from RETAIL_SALES
where sale_date =  "2022-11-05";

-- 2Q write a sql query to retrieve all transations where the category is 'Clothing' and the quantity sold is more than 3 in the month of nov-2022 --
SELECT * FROM RETAIL_SALES
WHERE category = 'Clothing'
AND quantiy >=3
AND DATE_FORMAT(sale_date,'%Y-%m') = '2022-11';

-- 3Q write a sql query to calculate the total sales (total_sales) for each category --
select category ,SUM(total_sale)
from RETAIL_SALES
GROUP BY category;

-- 4Q write a sql query to find the average age of customer who purchase items from the 'beauty' category --
SELECT 
round(AVG(age),2) as avg_age
FROM RETAIL_SALES
WHERE category = 'beauty';

-- 5Q write a sql query to find all transactions where the total sales is greater than 1000 --
SELECT * FROM RETAIL_SALES
WHERE total_sale > 1000;

-- 6Q wite a sql query to find the total number of transations (transation_id) made by each gender in each category --
SELECT 
category,
gender,
count(*) as total_transations
from RETAIL_SALES
GROUP BY category , gender;

-- 7Q write a sql query to calculate the average sales for each month. find out best selling month in each year --
SELECT 
year(sale_date) as year,
month(sale_date) as month,
ROUND(avg(total_sale),2) as avg_sales
from RETAIL_SALES
GROUP BY
year(sale_date),
month(sale_date)
ORDER BY
year(sale_date),
month(sale_date);

    -- BEST SELLING MONTH IN EACH YEAR --
    SELECT 
    year,
    month,
    total_sales
    FROM(
    SELECT
    year(sale_date) as year,
    month(sale_date) as month,
    SUM(total_sale) as total_sales,
    RANK() OVER (
    PARTITION BY year(sale_date)
    ORDER BY SUM(total_sale) DESC ) AS rnk
    FROM RETAIL_SALES
    GROUP BY 
    year(sale_date),
    month(sale_date)
    ) AS t
    WHERE rnk = 1;
    
 -- 8Q write a sql query to find the top five 5 customers based on highest sales --
SELECT customer_id, SUM(total_sale) as total_sales 
FROM RETAIL_SALES
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;
    
-- 9Q write a sql query to find out the unique customers who purchased items from each category --
SELECT 
category,
COUNT(DISTINCT(customer_id)) AS unique_customer
FROM RETAIL_SALES
GROUP BY category;

-- 10Q write a sql query to create each shift and numbers of orders (Example Morning <=12,Afternoon Between 12 & 17,Evening>17 --
SELECT
    CASE
    WHEN HOUR(sale_time)<12 THEN'MORNING'
    WHEN HOUR(sale_time) between 12 AND 17 THEN 'AFTERNOON'
    ELSE 'EVENING'
	END AS shift,
    COUNT(*) AS number_of_orders    
FROM RETAIL_SALES
GROUP BY shift;
 
-- END OF PROJECT --

    