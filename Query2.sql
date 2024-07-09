SELECT * FROM coffee_shop_sales
#Total Sales Analysis
SELECT CONCAT((ROUND(SUM(unit_price * transaction_qty)))/1000,"K") AS Total_Sales
FROM coffee_shop_sales
WHERE
MONTH(transaction_date) = 3 -- March Month

#Total Sales Analysis
SELECT 
    MONTH(transaction_date) AS month,
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales,
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1)
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5) -- for months of April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);

#Total order analysis
SELECT COUNT(transaction_id) AS Total_Orders
FROM coffee_shop_sales
WHERE
MONTH(transaction_date) = 3 -- March Month

SELECT 
    MONTH(transaction_date) AS month,
    ROUND(COUNT(transaction_id)) AS total_orders,
    (COUNT(transaction_id) - LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5) -- for April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);


SELECT SUM(transaction_qty) AS Total_Quantity_Sold
FROM coffee_shop_sales
WHERE
MONTH(transaction_date) = 5 -- May Month

SELECT 
    MONTH(transaction_date) AS month,
    ROUND(SUM(transaction_qty)) AS total_quantity_sold,
    (SUM(transaction_qty) - LAG(SUM(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty), 1) 
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5)   -- for April and May
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);

#calender
SELECT
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1),'K') AS Total_Sales,
    CONCAT(ROUND(SUM(transaction_qty)/1000,1),'K') AS Total_Qty_Sold,
    CONCAT(ROUND(COUNT(transaction_id)/1000,1),'K') AS Total_Orders
FROM 
    coffee_shop_sales
WHERE 
    transaction_date = '2023-05-18'
    ; --For 18 May 2023

Sun = 1
Mon = 2 
.
.
.
.
SAT = 7

SELECT
   CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
   ELSE 'Weekdays'
   END AS day_type,
   CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1), 'K') As Total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 -- May Month
GROUP BY
	CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
    ELSE 'Weekdays'
    END
    
END
    #location
SELECT 
	store_location,
	CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1),'K') as Total_Sales
FROM coffee_shop_sales
WHERE
	MONTH(transaction_date) =5 
GROUP BY store_location
ORDER BY 	SUM(unit_price * transaction_qty) DESC

