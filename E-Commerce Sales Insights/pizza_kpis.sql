SELECT * FROM dbo.pizza_sales;

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

SELECT  SUM(total_price)/COUNT(DISTINCT order_id) AS Average_order_value
FROM pizza_sales;

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

SELECT COUNT(DISTINCT order_id) FROM pizza_sales;

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Average_Pizzas_per_order
FROM pizza_sales;

SELECT DATENAME(DW,order_date) AS order_day,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW,order_date);

SELECT DATENAME(MONTH,order_date) AS Month_Name,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Total_orders DESC; 

----Percentage_total_sales by pizza category----
SELECT pizza_category,ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales),2)AS percentage_of_total_sales
FROM pizza_sales
GROUP BY pizza_category;

-----Percentage of sales by Pizza_size---

SELECT pizza_size,ROUND(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales),2)AS percentage_of_total_sales
FROM pizza_sales
GROUP BY pizza_size;

----TOP 5 BEST SELLERS BY REVENUE,TOTAL QUANTITY AND TOTAL ORDERS----

SELECT TOP 5 pizza_name,
       SUM(total_price) AS Total_revenue
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_revenue DESC;

SELECT TOP 5 pizza_name,
       SUM(quantity) AS Total_quantity
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_quantity DESC;

SELECT TOP 5 pizza_name,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_orders DESC;

------Bottom 5 WORST SELLERS BY REVENUE,TOTAL QUANTITY AND ORDER-------
SELECT TOP 5 pizza_name,
       SUM(total_price) AS Total_revenue
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_revenue;

SELECT TOP 5 pizza_name,
       SUM(quantity) AS Total_quantity
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_quantity;

SELECT TOP 5 pizza_name,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_orders;