CREATE DATABASE sql_project;
use sql_project;
drop table retail_sales;
create table retail_sales(
	transactions_id INT PRIMARY KEY,
    sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';




select * from retail_sales where transactions_id = 679;

SELECT COUNT(*) FROM retail_sales;

-- data cleaning --
Select * from retail_sales 
where transactions_id is NULL
	OR
    sale_date is NULL
    OR
    sale_time is NULL
    OR
    gender is NULL
    OR 
    category is NULL
    or 
    quantiy is NULL
    OR 
    cogs is NULL
    OR 
    total_sale is NULL
;
set sql_safe_updates = 0;

DELETE from retail_sales
where transactions_id is NULL
	OR
    sale_date is NULL
    OR
    sale_time is NULL
    OR
    gender is NULL
    OR 
    category is NULL
    or 
    quantiy is NULL
    OR 
    cogs is NULL
    OR 
    total_sale is NULL;
    
    
-- DATA EXPLORATION ---

-- How many sales we have?
SELECT COUNT(*) as total_sale from retail_sales;

-- How many unique customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale from retail_sales;

-- How many distinct category we have
SELECT COUNT(DISTINCT category) as total_sale from retail_sales; 

select Distinct category as total_category from retail_sales;

-- Data Analyst & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

--  Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from retail_sales where category = 'Clothing' AND DATE_FORMAT(sale_date,'%Y-%m')= '2022-11' AND quantiy>=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select Category, SUM(total_sale) as Net_sale,COUNT(*) as total_orders from retail_sales group by Category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select ROUND(Avg(age),2) as avg_age from retail_sales where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category ,gender, COUNT(transactions_id) as total_trans  from retail_sales group by gender,category order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sale
        from retail_sales
        GROUP BY 1, 2
        ORDER BY 1,3 DESC;
        
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, SUM(total_sale) as total_sale from retail_sales group by 1 order by 2 desc limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,COUNT(DISTINCT customer_id) from retail_sales group by category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
  CASE
    WHEN sale_time <= '12:00:00' THEN 'Morning'
    WHEN sale_time <= '17:00:00' THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY shift;
