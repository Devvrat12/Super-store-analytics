-- ===================================================
-- SUPERSTORE SALES DASHBOARD PROJECT
-- Author: Devvrat Tiwari
-- Description: Business insights using SQL on Superstore Dataset
-- ===================================================

-- ===================================================
-- SECTION 1: Revenue Analysis
-- ===================================================

-- Q1: Total Revenue
SELECT 
    SUM(Sales) AS Total_Revenue 
FROM 
    orders;

-- Q2: Monthly Sales Trend
SELECT
    STRFTIME('%Y-%m', "Order.Date") AS Sales_Month,
    SUM(Sales) AS Monthly_Sales
FROM
    orders
GROUP BY
    Sales_Month
ORDER BY
    Sales_Month;

-- Q3: Yearly Sales Trend
SELECT 
    STRFTIME('%Y', "Order.Date") AS Sales_Year,
    SUM(Sales) AS Yearly_Sales
FROM 
    orders
GROUP BY 
    Sales_Year
ORDER BY 
    Sales_Year;

-- ===================================================
-- SECTION 2: Regional Performance
-- ===================================================

-- Q4: Total Sales and Profit by Region
SELECT
    Region, 
    SUM(Sales) AS Total_Sales_Region,
    SUM(Profit) AS Total_Profit_Region
FROM 
    orders
GROUP BY
    Region
ORDER BY 
    Total_Sales_Region DESC;

-- Q5: State-Level Sales & Profit by Region
SELECT
    Region, 
    State,
    SUM(Sales) AS Total_Sales_State,
    SUM(Profit) AS Total_Profit_State
FROM 
    orders
GROUP BY 
    Region, State
ORDER BY
    Region, Total_Sales_State DESC;

-- ===================================================
-- SECTION 3: Product & Category Insights
-- ===================================================

-- Q6: Top 10 Sub-Categories by Sales
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
    Total_Sales DESC
LIMIT 10;

-- Q7: Top 10 Products by Sales
SELECT
    "Product.Name",
    "Sub.Category",
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity_Sold
FROM
    orders
GROUP BY
    "Product.Name"
ORDER BY
    Total_Sales DESC
LIMIT 10;

-- Q8: Top 10 Sub-Categories by Quantity Sold
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

-- ===================================================
-- SECTION 4: Customer Analysis
-- ===================================================

-- Q9: Top 10 Customers by Sales
SELECT
    "Customer.Name",
    "Customer.ID",
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT("Order.ID") AS Total_Orders
FROM
    orders
GROUP BY
    "Customer.ID", "Customer.Name"
ORDER BY
    Total_Sales DESC
LIMIT 10;

-- Q10: Top 10 Customers by Profit
SELECT
    "Customer.Name",
    "Customer.ID",
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT("Order.ID") AS Total_Orders
FROM
    orders
GROUP BY
    "Customer.ID", "Customer.Name"
ORDER BY
    Total_Profit DESC
LIMIT 10;

-- Q11: Customer Segmentation - New vs Repeat
SELECT
    CASE
        WHEN Total_Orders > 1 THEN 'Repeat Customer'
        ELSE 'New Customer'
    END AS Customer_Type,
    COUNT(DISTINCT "Customer.ID") AS Number_of_Customers
FROM (
    SELECT
        "Customer.ID",
        COUNT("Order.ID") AS Total_Orders
    FROM
        orders
    GROUP BY
        "Customer.ID"
) AS Customer_Order_Counts
GROUP BY
    Customer_Type;

-- ===================================================
-- SECTION 5: Order Value & Profitability
-- ===================================================

-- Q12: Average Order Value
SELECT
    AVG(Total_Sales_Per_Order) AS Average_Order_Value
FROM (
    SELECT
        "Order.ID",
        SUM(Sales) AS Total_Sales_Per_Order
    FROM
        orders
    GROUP BY
        "Order.ID"
) AS Order_Sales;

-- Q13: Overall Profit Margin Percentage
SELECT    
    (SUM(Profit) * 100.0 / SUM(Sales)) AS Profit_Margin_Percentage
FROM
    orders;

-- Q14: Average Discount by Category
SELECT
    "Category",
    AVG(Discount) AS Average_Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM
    orders
GROUP BY
    "Category"
ORDER BY
    Average_Discount DESC;

-- ===================================================
-- SECTION 6: Shipping & Loss-Making Orders
-- ===================================================

-- Q15: Shipping Mode Analysis
SELECT
    "Ship.Mode",
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    COUNT("Order.ID") AS Total_Orders_Shipped
FROM
    orders
GROUP BY
    "Ship.Mode"
ORDER BY
    Total_Profit DESC;

-- Q16: Top 10 Loss-Making Orders
SELECT
    "Order.ID",
    "Order.Date",
    "Customer.Name",
    Sales,
    Profit,
    Discount
FROM 
    orders
WHERE 
    Profit < 0
ORDER BY
    Profit ASC
LIMIT 10;

-- Q17: Top 10 Highest Discount Orders
SELECT
    "Order.ID",
    "Order.Date",
    "Customer.Name",
    Sales,
    Profit,
    Discount
FROM 
    orders
ORDER BY
    Discount DESC
LIMIT 10;
