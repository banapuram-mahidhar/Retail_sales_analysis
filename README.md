# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`
![image alt](https://github.com/banapuram-mahidhar/Retail_sales_analysis/blob/793ba611d9f10312ddd6074720a54fb7e4bae1f9/Retail%20Sales%20Analysis%20SQL%20Project_img.png)

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
-- How many sales we have --
SELECT COUNT(*) AS Total_sales FROM RETAIL_SALES;

-- How maney unique customers we have --
SELECT COUNT(DISTINCT  customer_id) AS Total_sales 
FROM RETAIL_SALES;

-- How maney unique category we have --
SELECT DISTINCT category AS Total_sales 
FROM RETAIL_SALES;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
Select * from RETAIL_SALES
where sale_date =  "2022-11-05";

```

2. **write a sql query to retrieve all transations where the category is 'Clothing' and the quantity sold is more than 3 in the month of nov-2022**:
```sql
SELECT * FROM RETAIL_SALES
WHERE category = 'Clothing'
AND quantiy >=3
AND DATE_FORMAT(sale_date,'%Y-%m') = '2022-11';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category ,SUM(total_sale)
from RETAIL_SALES
GROUP BY category;

```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
round(AVG(age),2) as avg_age
FROM RETAIL_SALES
WHERE category = 'beauty';

```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM RETAIL_SALES
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
category,
gender,
count(*) as total_transations
from RETAIL_SALES
GROUP BY category , gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
    FROM (SELECT
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
    
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id, SUM(total_sale) as total_sales 
FROM RETAIL_SALES
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
category,
COUNT(DISTINCT(customer_id)) AS unique_customer
FROM RETAIL_SALES
GROUP BY category;
```

**10Q write a sql query to create each shift and numbers of orders (Example Morning <=12,Afternoon Between 12 & 17,Evening>17 **
```sql
SELECT
    CASE
    WHEN HOUR(sale_time)<12 THEN'MORNING'
    WHEN HOUR(sale_time) between 12 AND 17 THEN 'AFTERNOON'
    ELSE 'EVENING'
	END AS shift,
    COUNT(*) AS number_of_orders    
FROM RETAIL_SALES
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


## Thank you for your support, and I look forward to connecting with you!

