select * from retail
select count(*) from retail


-- Data Cleaning 
select * from retail
where transactions_id is null

select * from retail
where 
     transactions_id is null
     or 
     sale_date is null
     or
     gender is null 
     or
     category is null
     or 
     quantiy is null
     or 
     total_sale is null

-- 
Delete from  retail
where 
     transactions_id is null
     or 
     sale_date is null
     or
     gender is null 
     or
     category is null
     or 
     quantiy is null
     or 
     total_sale is null

-- Data Exploration
-- how many sales we have 
select count(*) as total_sales from retail

-- how many unqiue customers we have 
select count(distinct customer_id) as total_customers from retail

-- Data Analysis & Business key Problems & answers

-- Q1 write a sql query to retrieve all columns for sales on 2022-11-05
select * 
from retail
where sale_date ='2022-11-05'

--Q2 write a sql query to retrieve all transactions where the category is clothing and then quantiy sold is more than 10 in 
-- the month of nv-2022

select *
from retail
where category='clothing' 
and 
quantiy>=4
and
year(sale_date)=2022
and month(sale_date)=11

--Q3 write a sql query to calculate the total sales for each category 
select category,sum(total_sale) as total_sales
from retail
group by category

--Q4 write a sql query to find average age of customers who purchased items from the 'beauty category'

select round(avg(age),2) as customer_avg_age
from retail 
where category ='Beauty'

--Q5 write a sql query to find all transcations where total_sales is greather than 1000

select *
from retail
where total_sale>1000

-- Q6  write a sql query to find the total number of transcations made by each geneder in each category

select category,gender,count(*) as transactions
from retail 
group by category,gender

-- Q7 write a sql query to calculate the average sale for each month.find out best selling month in each year


WITH ctc AS (
    SELECT 
        YEAR(sale_date) AS year_avg,
        MONTH(sale_date) AS month_sales,
        AVG(total_sale) AS avg_sales,
        RANK() OVER (
            PARTITION BY YEAR(sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rank_1
    FROM retail
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT *
FROM ctc
WHERE rank_1 = 1;

-- Q8 write a sql query to find 5 customers based on the highest total sales

SELECT TOP 5 customer_id,
sum(total_sale) as total_sales
FROM retail
group by customer_id
ORDER BY total_sales DESC;

--Q9 write a sql query to find the number of unique customers who purchased items from each category
select category, count(distinct customer_id) as unique_customers
from retail
group by category

--Q10 write a sql query  to create each shift and number of orders (example mrng<=12,afternoon between 12&13,evng >17)

with ctc as(SELECT *,
       CASE 
           WHEN DATEPART(HOUR, sale_time) <= 12 THEN 'Morning'
           WHEN DATEPART(HOUR, sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS shift_1
FROM retail)
select shift_1,count(transactions_id) as total_orders
from ctc
group by shift_1;

;
-- end project

