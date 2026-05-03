DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(	
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

			)
SELECT * FROM retail_sales
LIMIT 10
SELECT COUNT(*) FROM retail_sales
--REMOVING NULL VALUES(DATA CLEANING)
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
--DATA EXPLORATION
--HOW MANY SALES WE HAVE
SELECT COUNT(*) as total_sales FROM RETAIL_SALEs
--HOW MANY UNIQUE CUSTOMERS WE HAVE
SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_SALES FROM RETAIL_SALES
--TOTAL CUSTOMERS
SELECT COUNT(*) AS CUSTOMER_ID FROM RETAIL_SALES
--TOTAL CATEGORIES COUNT
SELECT COUNT(*) AS CATEGORY FROM RETAIL_SALES
--TOTAL CATEGORIES
SELECT CATEGORY FROM RETAIL_SALES
--UNIQUE CATEGORIES
SELECT DISTINCT CATEGORY AS TOTAL_SALES FROM RETAIL_SALES
--UNIQUE CATEGORY COUNT
SELECT COUNT(DISTINCT CATEGORY) AS TOTAL_SALES FROM RETAIL_SALES

--DATA ANALYSIS & BUSINESS KEY PROBLEMS


--Q1)WRITE SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MODE ON'2022-11-05'
SELECT * 
FROM RETAIL_SALES
WHERE SALE_date='2022-11-05';
--Q2)write a sql query to retrive all transactions where the category is 'clothing' and the quantity sold is more than 4in the month of nov-2022
select *
from retail_sales
where 
	category='Clothing'
	AND
	TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11'
	AND
	quantiy>=4
--Q3)write sql query to calculate the total sales for each caterory
select 
		category,
		sum(total_sale) as net_sale,
		count(*) as total_orders
from retail_sales
group by 1
--Q4)write sql query to fnd the average age of customers who purchased items from the 'Beauty' category
select Round(AVG(age),2) as avg_age 
from retail_sales
where category ='Beauty'
--Q5)write a sql query to find all transactions where the total_sale is greater than 1000
select * from retail_sales
where total_sale>1000
--Q6)write a sql query to find the total number of transactions (transction_id) made by each gender in each category
select
	category,
	gender,
	count(*) as total_transactions
from retail_sales
group 
	by
	category,
	gender
order by 1
--Q.7 write a sql query to calculate the average sale for each month.find out best selling month in each year
 select
 		year,
		month,
		avg_total_sale
from
(
		select
 		Extract(year from sale_date) as year,
		Extract(month from sale_date) as month,
		avg(total_sale) as avg_total_sale,
		RANK() OVER(PARTITION BY Extract(year from sale_date) order by avg(total_sale)DESC) as rank
 from  retail_sales
 group by 1,2
 ) as t1
 where rank = 1
 --order by 1,3 DESC
--Q.8 write a sql query to find the top 5 customers based on the highest total sales
select
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
Group by 1
order by 2 desc
limit 5
--Q.9 write a sql query to find the number of unique customers who purchased items for each category.
select
	category,
	COUNT(DISTINCT Customer_id) as int_unique_cs

from retail_sales
Group by category

--Q.10 write a sql query to create each shift and number of orders(Example Morning <12,Afternoon Between 12,afternoon between 12 & 17,evening > 17 )
with hourly_sales
AS(
Select *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time)< 12 THEN 'Morning'
		WHEN  EXTRACT(HOUR FROM sale_time)BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift
from retail_sales
)
select
	shift,
	count(*) as total_orders
From hourly_sales
GROUP BY shift

--end of project

