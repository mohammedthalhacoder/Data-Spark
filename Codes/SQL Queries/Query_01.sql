SET AUTOCOMMIT = 0;
---------------------------------------------------

-- Calculating the age group based on Age
ALTER TABLE dataspark.customers ADD Age_Group varchar(50)
;
UPDATE dataspark.customers
SET Age_Group = CASE
					WHEN Age BETWEEN 0 AND 18 THEN 'Teen'
                    WHEN Age BETWEEN 18 AND 35 THEN 'Young'
                    WHEN Age BETWEEN 35 AND 50 THEN 'Middle'
                    ELSE 'Old'
				END
;
COMMIT;

---------------------------------------------------

/*
Profitability Analysis:
Calculate profit margins for products by comparing unit cost and unit price.
*/

SELECT * FROM dataspark.products;

ALTER TABLE dataspark.products ADD Profit_Margin float;
-- profit margins for products by comparing unit cost and unit price
UPDATE dataspark.products
SET Profit_Margin = ((Unit_Price_USD - Unit_Cost_USD) / Unit_Price_USD ) * 100
;
commit;

SELECT * FROM dataspark.products;

---------------------------------------------------------------------------------------------------------------------------------

-- need to join the customer data and sales table

CREATE TABLE dataspark.cus_sal
AS
SELECT
customers.CustomerKey,
customers.Gender,
customers.Name,
customers.City,
customers.State_Code,
customers.State,
customers.Zip_Code,
customers.Country,
customers.Continent,
customers.Birthday,
customers.Age,
customers.Age_Group,
sales.Order_Number,
sales.Line_Item,
sales.Order_Date,
sales.Delivery_Date,
sales.StoreKey,
sales.ProductKey,
sales.Quantity,
sales.Currency_Code
FROM dataspark.customers AS customers
INNER JOIN dataspark.sales AS sales
ON customers.CustomerKey = sales.CustomerKey;

-- view the created table
SELECT * FROM dataspark.cus_sal;


-- NEED TO JOIN THE PRODUCT DATA TO CUS__SAL DATA

CREATE TABLE dataspark.cus_sal_prod
AS
SELECT
cus_sal.CustomerKey,
cus_sal.ProductKey,
cus_sal.Gender,
cus_sal.Name,
cus_sal.City,
cus_sal.State_Code,
cus_sal.State,
cus_sal.Zip_Code,
cus_sal.Country,
cus_sal.Continent,
cus_sal.Birthday,
cus_sal.Age,
cus_sal.Age_Group,
cus_sal.Order_Number,
cus_sal.Line_Item,
cus_sal.Order_Date,
cus_sal.Delivery_Date,
cus_sal.StoreKey,
cus_sal.Quantity,
cus_sal.Currency_Code,
prod.Product_Name,
prod.Brand,
prod.Color,
prod.Unit_Cost_USD,
prod.Unit_Price_USD,
prod.SubcategoryKey,
prod.Subcategory,
prod.CategoryKey,
prod.Category,
prod.Profit_Margin
FROM dataspark.products AS prod
INNER JOIN dataspark.cus_sal AS cus_sal
ON PROD.ProductKey = cus_sal.ProductKey;


SELECT * FROM dataspark.cus_sal_prod;

-- Total revenue calculated
ALTER TABLE dataspark.cus_sal_prod ADD Total_revenue float;

UPDATE dataspark.cus_sal_prod
SET Total_revenue = Quantity * Unit_Price_USD;
commit;


-- need to join the sales data and stores data

CREATE TABLE dataspark.sal_store
AS
SELECT
sales.Order_Number,
sales.Line_Item,
sales.Order_Date,
sales.Delivery_Date,
sales.CustomerKey,
sales.StoreKey,
sales.ProductKey,
sales.Quantity,
sales.Currency_Code,
stores.Country,
stores.State,
stores.Square_Meters,
stores.Open_Date
FROM dataspark.sales AS sales
INNER JOIN dataspark.stores AS stores
ON sales.StoreKey = stores.StoreKey;

-- view the created table
SELECT * FROM dataspark.sal_store;

------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM dataspark.cus_sal_prod;
SELECT * FROM dataspark.sal_store;

