
SELECT * FROM dataspark.customers;

-- Average age based on gender on different countries
SELECT Country, Gender, avg(Age) AS Avg_AGE FROM dataspark.customers
GROUP BY Gender, Country;

-- top 10 highest margin products
SELECT Product_Name, sum(Profit_Margin) Total_Margin, sum(Quantity)Total_units_sold FROM dataspark.cus_sal_prod
GROUP BY Product_Name
ORDER BY Total_Margin DESC
LIMIT 10;

-- product vise total sold and total margin
SELECT Product_Name, sum(Quantity)Total_units_sold , sum(Profit_Margin) Total_Margin FROM dataspark.cus_sal_prod
GROUP BY Product_Name;

-- Sub-Category vise max profit margin
SELECT Subcategory, max(Profit_Margin) AS Maximum_Profit FROM dataspark.cus_sal_prod
GROUP BY Subcategory;

-- customers count from different countries BASED ON SALES
SELECT Country, count(Gender) AS Customers FROM dataspark.cus_sal_prod
GROUP BY Country;

-- Age Group vise max of purchase and min of purchase BASED ON COUNTRY
SELECT Country, Age_Group, max(Quantity) max_purchase, min(Quantity) min_purchase FROM dataspark.cus_sal_prod
GROUP BY Country, Age_Group
ORDER BY Country ASC;

-- total sales over Year
SELECT YEAR(Order_Date) as Years, SUM(Quantity) as Total_Quantity_Sold
FROM dataspark.cus_sal_prod
GROUP BY YEAR(Order_Date)
ORDER BY Years;

-- customers count from different countries by gender vise
SELECT Country, Gender, count(Gender) AS Customers FROM dataspark.cus_sal_prod
GROUP BY Country, Gender;

-- Product Popularity ----------------------------

-- Top 10 most sold products
SELECT Product_Name, sum(Quantity)Total_units_sold , sum(Profit_Margin) Total_Margin FROM dataspark.cus_sal_prod
GROUP BY Product_Name
ORDER BY Total_units_sold DESC
LIMIT 10;

-- least sold products or minimal purchases
SELECT Product_Name, sum(Quantity)Total_units_sold , sum(Profit_Margin) Total_Margin FROM dataspark.cus_sal_prod
GROUP BY Product_Name
ORDER BY Total_units_sold ASC
LIMIT 10;

-- Top 10 highest revenue generated products
SELECT Product_Name, Unit_Price_USD Total_Unit_Price_USD, sum(Quantity)Total_units_sold, sum(Quantity * Unit_Price_USD) Revenue_generated FROM dataspark.cus_sal_prod
GROUP BY Product_Name,Unit_Price_USD
ORDER BY Revenue_generated DESC
LIMIT 10;

-- Sales by Store ---------------------------------

-- country vise stores total sales 
SELECT Country, sum(Quantity) Total_Sales from dataspark.sal_store
group by Country;

-- Category Analysis ------------------------------

-- top performing Category by total sales and avg price
select Category, sum(Quantity) Total_sales, avg(Unit_Price_USD) Average_price_per_category from cus_sal_prod
group by Category
order by Total_sales desc
limit 3;

-- underperformers Category by total sales and avg price
select Category, sum(Quantity) Total_sales, avg(Unit_Price_USD) Average_price_per_category from cus_sal_prod
group by Category
order by Total_sales asc
limit 3;

-- Geographical Analysis --------------------------

-- Total revenue based on Continent
select Continent, sum(Quantity * Unit_Price_USD) Total_revenue_per_Continent from dataspark.cus_sal_prod
group by Continent
order by Total_revenue_per_Continent desc;

-- Category vise total sales by country

select Category, Country, sum(Quantity) as Total_Sales from dataspark.cus_sal_prod
group by Country, Category
order by Country asc,Total_Sales desc;

