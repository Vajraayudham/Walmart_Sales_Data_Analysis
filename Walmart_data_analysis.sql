select * from sales;

-- "Feature Engineering " 
-- time_of_day (New table created from time )
select	time,( case 
				when time between "00:00:00" and "12:00:00" then "Morning"
				when time between "12:01:00" and "16:00:00" then "Afternoon"
				else "Evening" 
			   end
			) as time_of_day
from sales;    
alter table sales add column time_of_day varchar(20);
update sales 
set time_of_day = (
	case 
		when time between "00:00:00" and "12:00:00" then "Morning"
        when time between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening" 
	end
);
--  -----------------------------------------------------------------------
-- Adding Day_name column & month_name column 
alter table sales add column day_name varchar(15);
update sales 
set day_name = dayname(date);

alter table sales add column month_name varchar(15);
update sales 
set month_name = monthname(date);
---------------------------------------------------------------------------
-- how many unique cities the data have:
select distinct city, branch from sales;

-- -------------------Products----------------------------------------------
-- How many unique products lines does data have ?
select count(distinct product_line) as NoOfProductLine from sales;

--  what is the most common payment method ?
select 
	payment,
    count(payment) as Frequency
from sales
group by payment
order by Frequency desc;

-- what is the most selling product line?
select 
	product_line,
    count(product_line) as Frequency
from sales
group by product_line
order by Frequency desc;

-- what is the total revenue by month
select 
	month_name as Month,
    sum(total) as Revenue
from sales
group by month_name
order by Revenue desc;

-- what month had the largest COGS
select 
	month_name Month,
	sum(cogs) COGS
from sales
group by month_name
order by COGS desc;

-- what product line has the largest revenue
select 
	product_line,
	sum(total) as Revenue
from sales
group by product_line
order by Revenue desc;

-- what is the city with the largest revenue?
select 
	branch,
	city,
	sum(total) as Revenue
from sales
group by city,branch
order by Revenue desc;

-- what product line had the largest VAT?
select 
	product_line,
	avg(tax_pct) avg_tax
from sales
group by product_line
order by avg_tax desc;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

-- Which branch sold more products than average product sold?
select 
	branch Branch,
    sum(quantity) Quantity
from
	sales
group by branch
having sum(quantity) > (select avg(quantity) from sales);

-- What is the most common product line by gender?
select 
	gender Gender,
    product_line,    
    count(gender) as Frequency
from 
	sales
group by gender,product_line
order by Frequency desc;

-- What is the average rating of each product line? 
select 
	product_line,
	round((rating),2) AverageRating
from
	sales
group by product_line
order by AverageRating desc;

### Sales
-- 1. Number of sales made in each time of the day per weekday
select
	time_of_day,
    count(*) NumberOfSales
from 
	sales
where day_name = "Monday"
group by time_of_day
order by NumberOfSales desc;

-- 2. Which of the customer types brings the most revenue?
select
	customer_type,
    sum(total) Revenue
from
	sales
group by customer_type
order by Revenue;

-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
select 
	city,
    avg(tax_pct) vat
from sales
group by city
order by vat desc;

-- 4. Which customer type pays the most in VAT?
select 
	customer_type,
    round(avg(tax_pct),2) VAT
from
	sales
group by customer_type
order by VAT desc;

### Customer

-- 1. How many unique customer types does the data have?
select 
	distinct customer_type
from sales;
-- 2. How many unique payment methods does the data have?
select 
	distinct payment
from sales;
-- 3. Which customer type buys the most?
select 
	 customer_type,
     count(*) Frequency
from sales
group by customer_type
order by Frequency;
-- 4. What is the gender of most of the customers?
select 
	gender,
    count(gender) Frequency
from sales
group by gender;
-- 5. What is the gender distribution per branch?
select 
	branch,
	gender,
    count(*) Frequency
from sales
group by gender, branch
order by branch;
-- 6. Which time of the day do customers give most ratings?
select 
	time_of_day,
    round(avg(rating),2) Frequency
from sales
group by time_of_day
order by Frequency desc;
-- 7. Which time of the day do customers give most ratings per branch?
select 
	branch,
	time_of_day,
    round(avg(rating),2) Frequency
from sales
group by time_of_day,branch
order by branch;
-- 8. Which day fo the week has the best avg ratings?
select 
	day_name,
    round(avg(rating),2) Avg_rating
from sales
group by day_name
order by Avg_rating desc;
-- 9. Which day of the week has the best average ratings per branch?
select 
	branch,
	day_name,
    round(avg(rating),2) Avg_rating
from sales
group by day_name,branch
order by Avg_rating desc;





