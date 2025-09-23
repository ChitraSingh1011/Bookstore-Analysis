-- Business questions

-- 1. List all customers who live in New York
SELECT name 
FROM customers
WHERE city = 'New York';

-- 2. Find the total number of books available in the Books table
SELECT COUNT(book_id) 
FROM books;

-- 3. Show the orders placed by Alice (customer name, book title, and order date)
SELECT c.name, b.title, o.order_date
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN books AS b ON o.book_id = b.book_id
WHERE c.name = 'Alice';

-- 4. Get the total marketing spend for each city
SELECT c.city, SUM(m.spend_amount) AS total_spend
FROM customers AS c
JOIN marketingspend AS m ON c.customer_id = m.customer_id
GROUP BY c.city;

-- 5. Find the book with the highest price
SELECT title, price 
FROM books
ORDER BY price DESC
LIMIT 1;



-- Find the top 3 customers who ordered the most books (by quantity).
SELECT c.customer_id, c.name, SUM(o.quantity) AS total_quantity
FROM Customers AS c
JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_quantity DESC
LIMIT 3;


-- Show each genre and the total revenue generated from it (book price × quantity).
SELECT b.genre, SUM(b.price * o.quantity) AS total_revenue
FROM Books AS b
JOIN Orders AS o 
    ON b.book_id = o.book_id
GROUP BY b.genre
ORDER BY total_revenue DESC;



-- List the customers who spent more than 60 in marketing.
SELECT c.name, m.spend_amount
FROM Customers AS c
JOIN MarketingSpend AS m 
    ON c.customer_id = m.customer_id
WHERE m.spend_amount > 60;



-- Get the average book price per genre, but only show genres where the average price is greater than 30.
SELECT b.genre, AVG(b.price) AS avg_price
FROM Books AS b
GROUP BY b.genre
HAVING AVG(b.price) > 30;


-- Find the city with the highest total number of orders.
SELECT c.city, COUNT(o.order_id) AS total_orders
FROM Customers AS c
JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_orders DESC
LIMIT 1;


-- Find the customers who ordered the most expensive book.
SELECT c.name
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
JOIN Books AS b ON o.book_id = b.book_id
WHERE b.price = (SELECT MAX(price) FROM Books);


-- List all books that have been ordered at least once.
SELECT title
FROM Books
WHERE book_id IN (
    SELECT book_id
    FROM Orders
);

-- Find the books whose price is higher than the average price of their genre.
SELECT title, price, genre
FROM Books b1
WHERE price > (
    SELECT AVG(price)
    FROM Books b2
    WHERE b2.genre = b1.genre
);


-- List the customers who have spent more than the average marketing spend.
SELECT c.name
FROM Customers AS c
JOIN MarketingSpend AS m
    ON c.customer_id = m.customer_id
WHERE m.spend_amount > (
    SELECT AVG(spend_amount)
    FROM MarketingSpend
);

-- Find the top 2 books by total quantity sold

SELECT b.title, SUM(o.quantity) AS total_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.title
ORDER BY total_sold DESC
LIMIT 2;

-- For each customer, assign a row number to their orders based on order_date
SELECT
  o.order_id,
  o.customer_id,
  c.name,
  o.book_id,
  o.quantity,
  o.order_date,
  ROW_NUMBER() OVER (
    PARTITION BY o.customer_id
    ORDER BY o.order_date, o.order_id
  ) AS order_rank
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY o.customer_id, order_rank;


-- Show each book title with its total sold quantity, and also display the rank of that book based on sales.
SELECT 
    b.title,
    SUM(o.quantity) AS total_sold,
    RANK() OVER (ORDER BY SUM(o.quantity) DESC) AS sales_rank
FROM Books b
JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.title
ORDER BY total_sold DESC;

-- Show each book title along with the total units sold and the total revenue earned from that book, and order the result by revenue (highest first)
SELECT 
    b.title,
    SUM(o.quantity) AS total_units_sold,
    SUM(o.quantity * b.price) AS total_revenue
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.title
ORDER BY total_revenue DESC;

-- Show the titles of all books along with their stock, but only those books where the stock is less than 15
SELECT 
    title, stock
FROM Books
WHERE stock < 15;



-- Write an SQL query to calculate the RFM (Recency, Frequency, Monetary) metrics for each customer
WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.name,
        MAX(o.order_date) AS last_order,
        COUNT(o.order_id) AS frequency,
        SUM(o.quantity * b.price) AS monetary
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Books b ON o.book_id = b.book_id
    GROUP BY c.customer_id
)
SELECT *,
       DATEDIFF('2024-07-01', last_order) AS recency_days
FROM customer_metrics;


-- For each customer, display their customer ID, name, total revenue from orders, marketing spend, and profit
WITH customer_spend AS (
    SELECT 
        o.customer_id,
        SUM(o.quantity * b.price) AS total_revenue
    FROM Orders o
    JOIN Books b ON o.book_id = b.book_id
    GROUP BY o.customer_id
)
SELECT 
    c.customer_id,
    c.name,
    ms.spend_amount,
    cs.total_revenue,
    (cs.total_revenue - ms.spend_amount) AS profit
FROM Customers c
JOIN MarketingSpend ms ON c.customer_id = ms.customer_id
JOIN customer_spend cs ON c.customer_id = cs.customer_id;


-- Write an SQL query to calculate the total revenue for each month. Show the month (YYYY-MM) and the total revenue, sorted in chronological order
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(quantity * b.price) AS total_revenue
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY month
ORDER BY month;


-- List customers who have placed more than one order. Show their customer ID, name, and total number of orders
SELECT 
    c.customer_id,
    c.name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING total_orders > 1;

-- Calculate the average order value across all orders. Display the result rounded to 2 decimal places.
SELECT 
    ROUND(SUM(quantity * b.price) * 1.0 / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM Orders o
JOIN Books b ON o.book_id = b.book_id;


-- Find the top 10 pairs of books that are most frequently bought together by the same customer.
--  Show the book IDs and the number of times they were purchased together.
SELECT 
    o1.book_id AS book_1,
    o2.book_id AS book_2,
    COUNT(*) AS times_bought_together
FROM Orders o1
JOIN Orders o2 
  ON o1.customer_id = o2.customer_id AND o1.order_id != o2.order_id
WHERE o1.book_id < o2.book_id
GROUP BY book_1, book_2
ORDER BY times_bought_together DESC
LIMIT 10;



-- List customers whose last purchase was more than a year ago.
--  Show customer ID, name, last purchase date, and days since the last purchase.
SELECT 
    c.customer_id,
    c.name,
    MAX(o.order_date) AS last_purchase,
    DATEDIFF('2025-07-01', MAX(o.order_date)) AS days_since_last_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING days_since_last_purchase > 365;
