USE pizza_db

SELECT * FROM pizza_sales;

#  TOTAL REVENUE 

select sum(total_price) as total_revenue
from pizza_sales

#	AVERAGE ORDER VALUE

select sum(total_price) 
/ count(distinct order_id) as avg_order_value
from pizza_sales;

#  TOTAL PIZZAS SOLD
select sum(quantity) as total_sales
from pizza_sales;

# TOTAL ORDERS
select count(distinct order_id) as total_orders 
from pizza_sales;

# AVG PIZZAS PER ORDER 
select 
format ( sum(quantity)
/ count(distinct order_id), 2) as avg_per_order
from pizza_sales;

#DAILY TREND FOR ORDERS
/*str_to_date*/
select dayname(str_to_date(order_date, '%d-%m-%Y')) as day_week,
	count(distinct order_id) as daily_orders
from pizza_sales
group by dayname(str_to_date(order_date, '%d-%m-%Y'))
order by field(day_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

#MONTHLY TREND OF ORDERS
select monthname(str_to_date(order_date, '%d-%m-%Y')) as month_name,
	count(distinct order_id) as monthly_orders
from pizza_sales
group by monthname(str_to_date(order_date, '%d-%m-%Y'))
order by field(month_name, 'January','February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

select monthname(str_to_date(order_date, '%d-%m-%Y')) as month_name,
	count(distinct order_id) as monthly_orders
from pizza_sales
group by monthname(str_to_date(order_date, '%d-%m-%Y'))
order by monthly_orders DESC;

#PERCENTAGE OF SALES BY PIZZA CATEGORY
select pizza_category, sum(total_price)*100 
/ 
(select sum(total_price)
from pizza_sales) as percent_sales
from pizza_sales
group by pizza_category; 

#YOU COULD APPLY FILTER TO MONTH QUARTER WEEK TO ABOVE QUERY ---> WHERE MONTH = 1

select pizza_size, sum(total_proce) as decimal(10,2) as total_sales ... 

#PERCENTAGE OF SALES BY PIZZA SIZE
select pizza_size, cast(sum(total_price)*100 
/ 
(select sum(total_price)
from pizza_sales) as decimal (10,2)) as percent_sales
from pizza_sales
group by pizza_size
order by percent_sales DESC; 

#TOP 5 BEST SELLERS BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS
select pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue DESC limit 5; 

select pizza_name, count(distinct order_id) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity DESC limit 5;

select pizza_name, sum(quantity) as total_pizzas
from pizza_sales
group by pizza_name
order by total_pizzas DESC limit 5;



