/*Phase 1: Foundation & Inspection*/

-- List all unique pizza categories
USE PIZZA;
SELECT DISTINCT CATEGORY FROM PIZZA_TYPES;

-- Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". 
-- Show first 5 rows.
SELECT PIZZA_TYPE_ID, NAME, COALESCE(INGREDIENTS, 'MISSING DATA') AS INGREDIENTS FROM PIZZA_TYPES LIMIT 5;

-- Check for pizzas missing a price.
SELECT * FROM PIZZAS WHERE PRICE IS NULL;


/*Phase 2: Filtering & Exploration*/

-- Orders placed on '2015-01-01'
SELECT * FROM ORDERS WHERE DATE = '2015-01-01';

-- List pizzas with price descending.
SELECT * FROM PIZZAS ORDER BY PRICE DESC;

-- Pizzas sold in sizes 'L' or 'XL'.
SELECT * FROM PIZZAS WHERE SIZE IN ('XL', 'L');

-- Pizzas priced between $15.00 and $17.00.
SELECT * FROM PIZZAS WHERE PRICE BETWEEN 15.00 AND 17.00;

-- Pizzas with "Chicken" in the name.
SELECT * FROM PIZZA_TYPES WHERE NAME LIKE '%CHICKEN%';

-- Orders on '2015-02-15' or placed after 8 PM.
SELECT * FROM ORDERS WHERE DATE = '2015-02-15' OR TIME >= '20:00;00';


/*Phase 3: Sales Performance*/

-- Total quantity of pizzas sold.
SELECT SUM(QUANTITY) AS TOTAL_PIZZAS_SOLD FROM ORDER_DETAILS;

-- Average pizza price.
SELECT ROUND(AVG(PRICE),2) AS AVG_PRICE FROM PIZZAS;

-- Total order value per order.
SELECT O.ORDER_ID, SUM(P.PRICE * OD.QUANTITY) AS TOTAL_VALUE FROM ORDERS O 
JOIN ORDER_DETAILS OD ON O.ORDER_ID = OD.ORDER_ID 
JOIN PIZZAS P ON OD.PIZZA_ID = P.PIZZA_ID GROUP BY O.ORDER_ID;

-- Total quantity sold per pizza category.
SELECT PT.CATEGORY, SUM(OD.QUANTITY) AS TOTAL_PIZZA_SOLD FROM ORDER_DETAILS OD 
JOIN PIZZAS P ON OD.PIZZA_ID = P.PIZZA_ID 
JOIN PIZZA_TYPES PT ON P.PIZZA_TYPE_ID = PT.PIZZA_TYPE_ID GROUP BY PT.CATEGORY;

-- Categories with more than 5,000 pizzas sold.
SELECT PT.CATEGORY, SUM(OD.QUANTITY) AS TOTAL_PIZZA_SOLD FROM ORDER_DETAILS OD 
JOIN PIZZAS P ON OD.PIZZA_ID = P.PIZZA_ID 
JOIN PIZZA_TYPES PT ON P.PIZZA_TYPE_ID = PT.PIZZA_TYPE_ID 
GROUP BY PT.CATEGORY HAVING TOTAL_PIZZA_SOLD > 5000;

-- Pizzas never ordered.
SELECT P.* FROM PIZZAS P LEFT JOIN ORDER_DETAILS OD ON P.PIZZA_ID = OD.PIZZA_ID WHERE OD.PIZZA_ID IS NULL;

-- Price differences between different sizes of the same pizza.
SELECT P1.PIZZA_TYPE_ID, (MAX(P2.PRICE) - MIN(P1.PRICE)) AS PRICE_DIFFERENCE FROM PIZZAS AS P1 
INNER JOIN PIZZAS AS P2 ON P1.PIZZA_TYPE_ID = P2.PIZZA_TYPE_ID AND P1.SIZE <> P2.SIZE 
GROUP BY P1.PIZZA_TYPE_ID;


/* Additional Insights */

-- 1. Which pizza category generates the highest total revenue?
SELECT 
    pt.category,
    SUM(p.price * od.quantity) AS total_revenue
FROM
    order_details AS od
    JOIN pizzas AS p ON od.pizza_id = p.pizza_id
    JOIN pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_revenue DESC
LIMIT 1;


-- 2. What are the top 5 best-selling pizza types by total quantity sold?
SELECT 
    pt.name,
    SUM(od.quantity) AS total_sold
FROM
    order_details AS od
    JOIN pizzas AS p ON od.pizza_id = p.pizza_id
    JOIN pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_sold DESC
LIMIT 5;

-- 3. Which pizza size contributes the most to total revenue?
SELECT 
    p.size,
    ROUND(SUM(p.price * od.quantity),2) AS total_revenue
FROM
    order_details AS od
    JOIN pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_revenue DESC;

-- 4. What is the average order value (AOV) across all orders?
SELECT 
    ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(p.price * od.quantity) AS order_total
    FROM
        orders AS o
        JOIN order_details AS od ON o.order_id = od.order_id
        JOIN pizzas AS p ON od.pizza_id = p.pizza_id
    GROUP BY o.order_id
) AS totals;












