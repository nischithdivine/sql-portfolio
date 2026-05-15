-- ANALYSIS 1 - Milestone
/*To simplify its financial reports, Amazon India needs to standardize payment values. 
Round the average payment values to integer (no decimal) for each payment type and 
display the results sorted in ascending order.

Output: payment_type, rounded_avg_payment */

SELECT payment_type, round(avg(payment_value),0) as rounded_avg_payment  FROM Payments
Group by payment_type
Order by rounded_avg_payment 

/*Q2 . To refine its payment strategy, Amazon India wants to know the distribution of orders 
by payment type. Calculate the percentage of total orders for each payment type, rounded 
to one decimal place, and display them in descending order

Output: payment_type, percentage_orders */

SELECT 
payment_type, 
round(count(payment_type)*100.0/(SELECT count(payment_type) FROM Payments),1) as percentage_orders
FROM payments
Group by payment_type
Order by percentage_orders DESC

/*Q3.Amazon India seeks to create targeted promotions for products within specific price ranges. 
Identify all products priced between 100 and 500 BRL that contain the word 'Smart' in their name.
Display these products, sorted by price in descending order.

Output: product_id, price */

SELECT p.product_id, o.price, p.product_category_name
FROM product p  
join order_items o
on p.product_id = o.product_id
Where o.price between 100 AND 500 
AND lower(p.product_category_name) like '%smart%'


/*Q4.To identify seasonal sales patterns, Amazon India needs to focus on the most successful months.
Determine the top 3 months with the highest total sales value, rounded to the nearest integer.

Output: month, total_sales */

SELECT extract(year from o1.order_purchase_timestamp) as year, extract(month from o1.order_purchase_timestamp) as month, sum(o2.price) as total_sales 
FROM orders o1
Join order_items o2
on o1.order_id = o2.order_id
Group by year,month
Order by total_sales DESC
Limit 3


/*Q5.Amazon India is interested in product categories with significant price variations. 
Find categories where the difference between the maximum and 
minimum product prices is greater than 500 BRL.

Output: product_category_name, price_difference*/

SELECT p.product_category_name, (max(o.price)-min(o.price)) as price_difference
FROM product as p join order_items as o
ON p.product_id = o.product_id
Group by p.product_category_name
Having (max(o.price)-min(o.price)) > 500


/*Q6.To enhance the customer experience, Amazon India wants to find which payment types 
have the most consistent transaction amounts. Identify the payment types with 
the least variance in transaction amounts, sorting by the smallest standard deviation first.

Output: payment_type, std_deviation*/

SELECT payment_type, stddev(payment_value) as std_deviation FROM payments
Group by payment_type
Order by std_deviation


/*Q7.Amazon India wants to identify products that may have incomplete name in order to fix it 
from their end. Retrieve the list of products where the product category name is missing or 
contains only a single character.

Output: product_id, product_category_name*/

SELECT product_id, product_category_name FROM product
Where 
length(trim(product_category_name)) = 1
OR
product_category_name is null


-- Analysis 2
/*Q1.Amazon India wants to understand which payment types are most popular across different 
order value segments (e.g., low, medium, high). 
Segment order values into three ranges: orders less than 200 BRL, between 200 and 1000 BRL, 
and over 1000 BRL. 
Calculate the count of each payment type within these ranges and 
display the results in descending order of count

Output: order_value_segment, payment_type, count*/

SELECT
case when payment_value <200 then 'low'
when payment_value between 200 and 1000 then 'medium'
else 'high' end as order_value_segment,
payment_type,count(payment_type) as count
FROM payments
GROUP BY order_value_segment, payment_type
ORDER BY count DESC

/*Q2.Amazon India wants to analyse the price range and average price for each product category.
Calculate the minimum, maximum, and average price for each category, 
and list them in descending order by the average price.

Output: product_category_name, min_price, max_price, avg_price*/

SELECT
p.product_category_name,
min(o.price)as min_price,max(o.price)as max_price
,round(avg(o.price),2)as avg_price
FROM product p
JOIN order_items o
ON o.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_price DESC

/* Q3 Amazon India wants to identify the customers who have placed multiple orders over time. 
Find all customers with more than one order, and display their customer unique IDs along with 
the total number of orders they have placed.

Output: customer_unique_id, total_orders */
SELECT distinct(c.customer_unique_id),
count(o.order_id) as total_orders
FROM customers c
join orders o on
o.customer_id=c.customer_id
group by distinct(c.customer_unique_id)
having count(o.order_id) >1
order by total_orders desc

/* Q4. Amazon India wants to categorize customers into different types 
('New – order qty. = 1' ;  'Returning' –order qty. 2 to 4;  'Loyal' – order qty. >4) 
based on their purchase history. Use a temporary table to define these categories and 
join it with the customers table to update and display the customer types.

Output: customer_id, customer_type */

With categorize_customers AS
(
SELECT customer_id,
CASE
WHEN COUNT(order_id) = 1 THEN 'New'
WHEN COUNT(order_id) BETWEEN 2 AND 4 THEN 'Returning'
ELSE 'Loyal'
END AS customer_type
FROM orders
GROUP BY customer_id
)
SELECT c.customer_id, t.customer_type
FROM customers c
JOIN categorize_customers t
ON t.customer_id = c.customer_id


/* Q5. Amazon India wants to know which product categories generate the most revenue. 
Use joins between the tables to calculate the total revenue for each product category. 
Display the top 5 categories.

Output: product_category_name, total_revenue */

SELECT p.product_category_name, sum(o.price) as total_revenue
FROM product p
JOIN order_items o
ON o.product_id = p.product_id
group by p.product_category_name
ORDER BY total_revenue desc
limit 5

--Analysis - III
/* Q1.The marketing team wants to compare the total sales between different seasons. 
Use a subquery to calculate total sales for each season (Spring, Summer, Autumn, Winter) 
based on order purchase dates, and display the results. 
Spring is in the months of March, April and May. 
Summer is from June to August and Autumn is between September and November and 
rest months are Winter. 

Output: season, total_sales */

SELECT seasons, sum(price) as total_sales 
FROM
(
SELECT 
o2.price,
Case 
When EXTRACT (month from order_purchase_timestamp) between 3 and 5 
then 'Spring'
When EXTRACT (month from order_purchase_timestamp) between 6 and 8 
then 'Summaer'
When EXTRACT (month from order_purchase_timestamp) between 9 and 11 
then 'Autumn'
else 'Winter'
END as seasons 
FROM 
Orders o1
Join Order_items o2
on o1.order_id = o2.order_id
)
Group by seasons


/* Q2.The inventory team is interested in identifying products that have sales volumes above 
the overall average. Write a query that uses a subquery to filter products with a total 
quantity sold above the average quantity.

Output: product_id, total_quantity_sold */
SELECT product_id, total_quantity_sold
FROM (
SELECT product_id, COUNT(order_item_id) AS total_quantity_sold
FROM order_items
GROUP BY product_id
)
product_sales
WHERE total_quantity_sold > (
SELECT AVG(product_count)
FROM (
SELECT COUNT(order_item_id) AS product_count
FROM order_items
GROUP BY product_id ) as avg_sales
);


/* Q3.To understand seasonal sales patterns, the finance team is analysing the monthly revenue 
trends over the past year (year 2018). 
Run a query to calculate total revenue generated each month and 
identify periods of peak and low sales. 
Export the data to Excel and create a graph to visually represent revenue changes 
across the months. 

Output: month, total_revenue */

SELECT EXTRACT(MONTH FROM order_purchase_timestamp) AS month, 
       SUM(oi.price)
FROM orders AS o
JOIN order_items AS oi
  ON o.order_id = oi.order_id
WHERE EXTRACT(YEAR FROM order_purchase_timestamp) = 2018
GROUP BY month;



/* Q4.A loyalty program is being designed  for Amazon India. 
Create a segmentation based on purchase frequency: ‘Occasional’ for customers with 1-2 orders, 
‘Regular’ for 3-5 orders, and ‘Loyal’ for more than 5 orders. 
Use a CTE to classify customers and their count and 
generate a chart in Excel to show the proportion of each segment.

Output: customer_type, count */

WITH customertype as(
select
case when count(order_id)<=2 then 'Occasional'
when count(order_id) between 3 and 5 then 'Regular'
else 'Loyal' end customer_type
,customer_id from orders
group by customer_id
)
select customer_type,count(customer_id) from customertype
group by customer_type

/* Q5.Amazon wants to identify high-value customers to target for an exclusive rewards program. 
You are required to rank customers based on their average order value (avg_order_value) 
to find the top 20 customers.

Output: customer_id, avg_order_value, and customer_rank */

select o.customer_id,
ROUND(avg(oi.price),0) as avg_order_value,
rank()over(order by avg(oi.price) desc) as customer_rank
from orders o
join
order_items oi
on oi.order_id=o.order_id
group by o.customer_id
order by avg_order_value desc
limit 20



/* Q6.Amazon wants to analyze sales growth trends for its key products over their lifecycle. 
Calculate monthly cumulative sales for each product from the date of its first sale. 
Use a recursive CTE to compute the cumulative sales (total_sales) for each product month by month.

Output: product_id, sale_month, and total_sales */

WITH sales AS (
SELECT
oi.product_id,
DATE_TRUNC('month', o.order_purchase_timestamp) AS sale_month,
SUM(oi.price) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY oi.product_id, sale_month
)
SELECT
product_id,
TO_CHAR(sale_month, 'YYYY-MM') AS sale_month,
ROUND(SUM(monthly_sales) OVER (PARTITION BY product_id ORDER BY sale_month), 2) AS total_sales
FROM sales
ORDER BY product_id, sale_month

/* Q7.To understand how different payment methods affect monthly sales growth, 
Amazon wants to compute the total sales for each payment method and 
calculate the month-over-month growth rate for the past year (year 2018). 
Write query to first calculate total monthly sales for each payment method, 
then compute the percentage change from the previous month.

Output: payment_type, sale_month, monthly_total, monthly_change */

WITH monthly_sales AS (
SELECT
p.payment_type,
DATE_TRUNC('month', o.order_purchase_timestamp) AS sale_month,
SUM(oi.price) AS monthly_total
FROM orders o
JOIN payments p ON o.order_id = p.order_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
GROUP BY p.payment_type, sale_month
),
sales_growth AS (
SELECT
payment_type,
TO_CHAR(sale_month, 'YYYY-MM') AS sale_month,
monthly_total,
ROUND(
(monthly_total - LAG(monthly_total) OVER (PARTITION BY payment_type ORDER BY sale_month))
/ NULLIF(LAG(monthly_total) OVER (PARTITION BY payment_type ORDER BY sale_month), 0) * 100,
2) AS monthly_change FROM monthly_sales )
SELECT * FROM sales_growth
ORDER BY payment_type, sale_month
