
/*
SQL ASSIGNMENT
Name: Nikita Singh
Subject: SQL Server / Database Management
Assignment: Items & Products Database
*/

/* =====================================================
BASIC QUESTIONS (LOCKED – DO NOT MODIFY)
===================================================== */

/* 1. Create Databases */
CREATE DATABASE Brands;
CREATE DATABASE Products;

/* 2. Create Tables */
USE Brands;
CREATE TABLE ITEMS_TABLE (
    Item_id INT,
    Item_description VARCHAR(255),
    Vendor_nos INT,
    Vendor_name VARCHAR(255),
    Bottle_size INT,
    Bottle_price DECIMAL(10,2)
);

USE Products;
CREATE TABLE PRODUCT_SALES_TABLE (
    Product_Id INT,
    Country VARCHAR(100),
    Product VARCHAR(100),
    Units_Sold FLOAT,
    Manufacturing_Price DECIMAL(10,2),
    Sale_Price DECIMAL(10,2),
    Gross_Sales DECIMAL(10,2),
    Sales DECIMAL(10,2),
    COGS DECIMAL(10,2),
    Profit DECIMAL(10,2),
    Date DATE,
    Month_Number INT,
    Month_Name VARCHAR(20),
    Year INT
);

/* 3. Insert Records */
USE Brands;
INSERT INTO ITEMS_TABLE VALUES
(1,'Travis Hasse Apple Pie',305,'Mhw Ltd',750,9.77),
(2,'D''aristi Xtabentun',391,'Anchor Distilling (preiss Imports)',750,14.12),
(3,'Hiram Walker Peach Brandy',370,'Pernod Ricard Usa/austin Nichols',1000,6.50),
(4,'Oak Cross Whisky',305,'Mhw Ltd',750,25.33),
(5,'Uv Red(cherry) Vodka',380,'Phillips Beverage Company',200,1.97),
(6,'Heaven Hill Old Style White Label',259,'Heaven Hill Distilleries Inc.',750,6.37),
(7,'Hyde Herbal Liqueur',194,'Fire Tail Brands Llc',750,5.06),
(8,'Dupont Calvados Fincher Reserve',403,'Robert Kacher Selections',750,23.61);

USE Products;
INSERT INTO PRODUCT_SALES_TABLE VALUES
(1,'Canada','Carretera',1618.5,3,20,32370,32370,16185,16185,'2014-01-01',1,'January',2014),
(2,'Germany','Carretera',1321,3,20,26420,26420,13210,13210,'2014-01-01',1,'January',2015),
(3,'France','Carretera',2178,3,15,32670,32670,21780,10890,'2014-06-01',6,'June',2016),
(4,'Germany','Carretera',888,3,15,13320,13320,8880,4440,'2014-06-01',6,'June',2017),
(5,'Mexico','Carretera',2470,3,15,37050,37050,24700,12350,'2014-06-01',6,'June',2018),
(6,'Germany','Carretera',1513,3,350,529550,529550,393380,136170,'2014-12-01',12,'December',2019),
(7,'Germany','Montana',921,5,15,13815,13815,9210,4605,'2014-03-01',3,'March',2020),
(8,'Canada','Montana',2518,5,12,30216,30216,7554,22662,'2014-06-01',6,'June',2021);

/* 4. Delete specific products */
DELETE FROM PRODUCT_SALES_TABLE
WHERE Units_Sold IN (1618.5, 888, 2470);

/* 5–10. Basic Queries */
SELECT * FROM ITEMS_TABLE;
SELECT Item_description, Bottle_price FROM ITEMS_TABLE;
SELECT Item_description, Bottle_price FROM ITEMS_TABLE WHERE Bottle_price > 20;
SELECT DISTINCT Country FROM PRODUCT_SALES_TABLE;
SELECT COUNT(DISTINCT Country) FROM PRODUCT_SALES_TABLE;
SELECT COUNT(DISTINCT Country) FROM PRODUCT_SALES_TABLE WHERE Sale_Price BETWEEN 10 AND 20;

/* =====================================================
INTERMEDIATE QUESTIONS
===================================================== */

SELECT SUM(Sale_Price) AS Total_Sale_Price, SUM(Gross_Sales) AS Total_Gross_Sales FROM PRODUCT_SALES_TABLE;
SELECT Year, SUM(Gross_Sales) AS Total_Sales FROM PRODUCT_SALES_TABLE GROUP BY Year ORDER BY Total_Sales DESC;
SELECT Product FROM PRODUCT_SALES_TABLE WHERE Gross_Sales = 37050;
SELECT DISTINCT Country FROM PRODUCT_SALES_TABLE WHERE Profit BETWEEN 4605 AND 22662;
SELECT Product_Id FROM PRODUCT_SALES_TABLE WHERE COGS = 24700;
SELECT Country, SUM(Units_Sold) AS Total_Units_Sold FROM PRODUCT_SALES_TABLE GROUP BY Country;
SELECT Country, AVG(Gross_Sales) AS Average_Sales FROM PRODUCT_SALES_TABLE GROUP BY Country;
SELECT Product_Id, Country, Product FROM PRODUCT_SALES_TABLE WHERE Year = 2014;
SELECT MAX(Profit) AS Maximum_Profit FROM PRODUCT_SALES_TABLE;
SELECT * FROM PRODUCT_SALES_TABLE WHERE Profit > (SELECT AVG(Profit) FROM PRODUCT_SALES_TABLE);
SELECT Item_description FROM ITEMS_TABLE WHERE Bottle_size = 750;
SELECT DISTINCT Vendor_name FROM ITEMS_TABLE WHERE Vendor_nos IN (305,380,391);
SELECT SUM(Bottle_price) AS Total_Bottle_Price FROM ITEMS_TABLE;
SELECT Item_id FROM ITEMS_TABLE WHERE Bottle_price = 5.06;

/* =====================================================
ADVANCE QUESTIONS
===================================================== */

SELECT * FROM ITEMS_TABLE I INNER JOIN PRODUCT_SALES_TABLE P ON I.Item_id = P.Product_Id;
SELECT I.Item_description, P.Product FROM ITEMS_TABLE I JOIN PRODUCT_SALES_TABLE P ON I.Item_id = P.Product_Id WHERE P.Gross_Sales = 13320;
SELECT LEFT(Item_description, CHARINDEX(' ', Item_description) - 1) AS Item_desc1,
       SUBSTRING(Item_description, CHARINDEX(' ', Item_description) + 1, LEN(Item_description)) AS Item_desc2
FROM ITEMS_TABLE;
SELECT TOP 3 Item_description, Bottle_price FROM ITEMS_TABLE ORDER BY Bottle_price DESC;
SELECT Country, Product, SUM(Gross_Sales) AS Total_Gross_Sales, SUM(Profit) AS Total_Profit FROM PRODUCT_SALES_TABLE GROUP BY Country, Product;
SELECT Vendor_name, Item_description FROM ITEMS_TABLE WHERE Bottle_size = 750 AND Bottle_price < 10;
SELECT Product FROM PRODUCT_SALES_TABLE WHERE Year = 2019 AND Profit = (SELECT MAX(Profit) FROM PRODUCT_SALES_TABLE WHERE Year = 2019);
SELECT Product_Id, Country FROM PRODUCT_SALES_TABLE WHERE Profit >= 2 * COGS;
SELECT TOP 1 Country FROM PRODUCT_SALES_TABLE WHERE Year = 2018 GROUP BY Country ORDER BY SUM(Gross_Sales) DESC;
SELECT Month_Name, SUM(Sales) AS Total_Sales FROM PRODUCT_SALES_TABLE GROUP BY Month_Name;
SELECT Item_description, Vendor_name FROM ITEMS_TABLE WHERE Vendor_nos IN (SELECT Vendor_nos FROM ITEMS_TABLE GROUP BY Vendor_nos HAVING COUNT(*) > 1);
SELECT Country, Product, AVG(Manufacturing_Price) AS Avg_Manufacturing_Price FROM PRODUCT_SALES_TABLE GROUP BY Country, Product HAVING AVG(Manufacturing_Price) > 3;

/* =====================================================
SUPER-ADVANCE QUESTIONS
===================================================== */

SELECT Item_description, Bottle_price FROM ITEMS_TABLE WHERE Vendor_name = (SELECT Vendor_name FROM ITEMS_TABLE WHERE Item_id = 1);
SELECT Item_description FROM ITEMS_TABLE WHERE Item_description LIKE '%Whisky%';
SELECT Country, Product FROM PRODUCT_SALES_TABLE WHERE Profit > (SELECT AVG(Profit) FROM PRODUCT_SALES_TABLE);
SELECT I.Item_description, I.Vendor_name, P.Country, P.Product FROM ITEMS_TABLE I JOIN PRODUCT_SALES_TABLE P ON I.Item_id = P.Product_Id;
SELECT Item_description + ' - ' + Vendor_name AS Item_Vendor FROM ITEMS_TABLE;
SELECT Item_description, ROUND(Bottle_price,1) AS Rounded_Price FROM ITEMS_TABLE;
SELECT Product_Id, DATEDIFF(DAY, Date, GETDATE()) AS Days_Difference FROM PRODUCT_SALES_TABLE;


/* =====================================================
INTERMEDIATE QUESTIONS (FINAL)
===================================================== */

SELECT SUM(Sale_Price) AS Total_Sale_Price,
       SUM(Gross_Sales) AS Total_Gross_Sales
FROM PRODUCT_SALES_TABLE;

SELECT Year, SUM(Gross_Sales) AS Total_Sales
FROM PRODUCT_SALES_TABLE
GROUP BY Year
ORDER BY Total_Sales DESC;

SELECT Product
FROM PRODUCT_SALES_TABLE
WHERE Gross_Sales = 37050;

SELECT DISTINCT Country
FROM PRODUCT_SALES_TABLE
WHERE Profit BETWEEN 4605 AND 22662;

SELECT Product_Id
FROM PRODUCT_SALES_TABLE
WHERE COGS = 24700;

SELECT Country, SUM(Units_Sold) AS Total_Units_Sold
FROM PRODUCT_SALES_TABLE
GROUP BY Country;

SELECT Country, AVG(Gross_Sales) AS Average_Sales
FROM PRODUCT_SALES_TABLE
GROUP BY Country;

SELECT Product_Id, Country, Product
FROM PRODUCT_SALES_TABLE
WHERE Year = 2014;

SELECT MAX(Profit) AS Maximum_Profit
FROM PRODUCT_SALES_TABLE;

SELECT *
FROM PRODUCT_SALES_TABLE
WHERE Profit > (
    SELECT AVG(Profit) FROM PRODUCT_SALES_TABLE
);

SELECT Item_description
FROM ITEMS_TABLE
WHERE Bottle_size = 750;

SELECT DISTINCT Vendor_name
FROM ITEMS_TABLE
WHERE Vendor_nos IN (305,380,391);

SELECT SUM(Bottle_price) AS Total_Bottle_Price
FROM ITEMS_TABLE;

ALTER TABLE ITEMS_TABLE
ADD CONSTRAINT PK_Item_id PRIMARY KEY (Item_id);

SELECT Item_id
FROM ITEMS_TABLE
WHERE Bottle_price = 5.06;

/* =====================================================
ADVANCE QUESTIONS (FINAL)
===================================================== */

SELECT *
FROM ITEMS_TABLE I
INNER JOIN PRODUCT_SALES_TABLE P
ON I.Item_id = P.Product_Id;

SELECT I.Item_description, P.Product
FROM ITEMS_TABLE I
JOIN PRODUCT_SALES_TABLE P
ON I.Item_id = P.Product_Id
WHERE P.Gross_Sales = 13320;

SELECT 
LEFT(Item_description, CHARINDEX(' ', Item_description) - 1) AS Item_desc1,
SUBSTRING(Item_description, CHARINDEX(' ', Item_description) + 1, LEN(Item_description)) AS Item_desc2
FROM ITEMS_TABLE;

SELECT TOP 3 Item_description, Bottle_price
FROM ITEMS_TABLE
ORDER BY Bottle_price DESC;

SELECT Country, Product,
SUM(Gross_Sales) AS Total_Gross_Sales,
SUM(Profit) AS Total_Profit
FROM PRODUCT_SALES_TABLE
GROUP BY Country, Product;

SELECT Vendor_name, Item_description
FROM ITEMS_TABLE
WHERE Bottle_size = 750
AND Bottle_price < 10;

SELECT Product
FROM PRODUCT_SALES_TABLE
WHERE Year = 2019
AND Profit = (
    SELECT MAX(Profit)
    FROM PRODUCT_SALES_TABLE
    WHERE Year = 2019
);

SELECT Product_Id, Country
FROM PRODUCT_SALES_TABLE
WHERE Profit >= 2 * COGS;

SELECT TOP 1 Country
FROM PRODUCT_SALES_TABLE
WHERE Year = 2018
GROUP BY Country
ORDER BY SUM(Gross_Sales) DESC;

SELECT Month_Name, SUM(Sales) AS Total_Sales
FROM PRODUCT_SALES_TABLE
GROUP BY Month_Name;

SELECT Item_description, Vendor_name
FROM ITEMS_TABLE
WHERE Vendor_nos IN (
    SELECT Vendor_nos
    FROM ITEMS_TABLE
    GROUP BY Vendor_nos
    HAVING COUNT(*) > 1
);

SELECT Country, Product,
AVG(Manufacturing_Price) AS Avg_Manufacturing_Price
FROM PRODUCT_SALES_TABLE
GROUP BY Country, Product
HAVING AVG(Manufacturing_Price) > 3;

/* =====================================================
SUPER-ADVANCE QUESTIONS (FINAL)
===================================================== */

SELECT Item_description, Bottle_price
FROM ITEMS_TABLE
WHERE Vendor_name = (
    SELECT Vendor_name
    FROM ITEMS_TABLE
    WHERE Item_id = 1
);

CREATE PROCEDURE Get_Items_By_BottlePrice
@Price DECIMAL(10,2)
AS
BEGIN
    SELECT *
    FROM ITEMS_TABLE
    WHERE Bottle_price > @Price;
END;

CREATE PROCEDURE Insert_Product_Sales
(
    @Product_Id INT,
    @Country VARCHAR(100),
    @Product VARCHAR(100),
    @Units_Sold FLOAT,
    @Manufacturing_Price DECIMAL(10,2),
    @Sale_Price DECIMAL(10,2),
    @Gross_Sales DECIMAL(10,2),
    @Sales DECIMAL(10,2),
    @COGS DECIMAL(10,2),
    @Profit DECIMAL(10,2),
    @Date DATE,
    @Month_Number INT,
    @Month_Name VARCHAR(20),
    @Year INT
)
AS
BEGIN
    INSERT INTO PRODUCT_SALES_TABLE
    VALUES (
        @Product_Id,@Country,@Product,@Units_Sold,@Manufacturing_Price,
        @Sale_Price,@Gross_Sales,@Sales,@COGS,@Profit,@Date,
        @Month_Number,@Month_Name,@Year
    );
END;

CREATE TRIGGER trg_Update_GrossSales
ON PRODUCT_SALES_TABLE
AFTER UPDATE
AS
BEGIN
    UPDATE PRODUCT_SALES_TABLE
    SET Gross_Sales = Units_Sold * Sale_Price;
END;

SELECT Item_description
FROM ITEMS_TABLE
WHERE Item_description LIKE '%Whisky%';

SELECT Country, Product
FROM PRODUCT_SALES_TABLE
WHERE Profit > (
    SELECT AVG(Profit)
    FROM PRODUCT_SALES_TABLE
);

SELECT I.Item_description, I.Vendor_name, P.Country, P.Product
FROM ITEMS_TABLE I
JOIN PRODUCT_SALES_TABLE P
ON I.Item_id = P.Product_Id;

SELECT Item_description + ' - ' + Vendor_name AS Item_Vendor
FROM ITEMS_TABLE;

SELECT Item_description, ROUND(Bottle_price,1) AS Rounded_Price
FROM ITEMS_TABLE;

SELECT Product_Id,
DATEDIFF(DAY, Date, GETDATE()) AS Days_Difference
FROM PRODUCT_SALES_TABLE;
