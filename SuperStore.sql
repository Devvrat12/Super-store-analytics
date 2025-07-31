SELECT 
	SUM(Sales) AS Total_Revenue 
From 
	orders;
SELECT
    STRFTIME('%Y-%m', "Order.Date") AS Sales_Month, -- Extract Year-Month
    SUM(Sales) AS Monthly_Sales
FROM
    orders
GROUP BY
    Sales_Month
ORDER BY
    Sales_Month;
	
SELECT 
	STRFTIME('%Y', "Order.Date") AS Sales_Year,
	SUM(Sales) AS Yearly_Sales
From 
	orders
GROUP BY 
	Sales_year
Order BY 
	Sales_year;
	
SELECT
	Region, 
	SUM(Sales) AS Total_sales_region,
	SUM(Profit) AS Total_profit_region
FROM 
	orders
GROUP BY
	Region
ORDER BY 
	Total_sales_region DESC;

SELECT
	Region, 
	State,
	SUM(Sales) AS Total_sales_state,
	SUM(Profit) AS Total_profit_state
FROM 
	orders
GROUP BY 
	Region, State
ORDER BY
	Region, Total_sales_state DESC;

SELECT
    "Sub.Category", -- Note the corrected column name with a hyphen
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity_Sold
FROM
    orders
GROUP BY
    "Sub.Category"
ORDER BY
    Total_Sales DESC
LIMIT 10;

SELECT
	"Product.Name",
	"Sub.Category",
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit,
	SUM(Quantity) AS Total_quantity_sold
FROM
	orders
GROUP BY
	"Product.Name"
ORDER BY
	Total_Sales DESC
LIMIT 10;

SELECT
    "Sub.Category",
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity_Sold
FROM
    orders
GROUP BY
    "Sub.Category"
ORDER BY
    Total_Quantity_Sold DESC
LIMIT 10;
	
SELECT
	"Customer.Name",
	"Customer.ID",
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit,
	Count("Order.ID") AS Total_orders
FROM
	orders
GROUP BY
	"Customer.ID","Customer.Name"
ORDER BY
	Total_Sales DESC
LIMIT 10;

SELECT
	"Customer.Name",
	"Customer.ID",
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit,
	Count("Order.ID") AS Total_orders
FROM
	orders
GROUP BY
	"Customer.ID","Customer.Name"
ORDER BY
	Total_Profit DESC
LIMIT 10;

