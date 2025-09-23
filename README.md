# 📚 Bookstore Analytics Project

## 📝 Project Overview
Bookstore analytics helps understand **customer preferences**, **product trends**, **inventory health**, and **marketing performance** in a retail bookstore. Using SQL, we can answer questions like: *Which books sell the most? Which customers bring the most profit? How effective is our marketing spend?* 💡

This project demonstrates step-by-step how to build a complete bookstore analytics solution using SQL.

---

## 🎯 Key Objectives
By the end of this project, you will be able to:
- 📈 Identify best-selling books and revenue drivers  
- ⚠️ Track and alert on low inventory stock  
- 👥 Segment customers based on behavior (RFM analysis)  
- 💰 Measure ROI on customer acquisition  
- 📊 Present actionable insights to stakeholders  

---

## 🛠 Tools & Technologies
- SQL (MySQL / PostgreSQL / SQLite)  
- 🔗 Joins, Subqueries, Aggregations  
- 🧩 Common Table Expressions (CTEs)  

---

## 🗂 Dataset Overview
The bookstore database includes four main tables:

| Table | Description |
|-------|------------|
| **Books** | Contains book details (title, genre, price) and stock |
| **Customers** | Customer information including city and signup date |
| **Orders** | Purchase data linking customers and books |
| **MarketingSpend** | Marketing cost per customer |

**Database Relationships:**  
- `Orders.customer_id` → `Customers.customer_id`  
- `Orders.book_id` → `Books.book_id`  
- `MarketingSpend.customer_id` → `Customers.customer_id`  

---

## ❓ Business Questions
The project answers the following business questions using SQL:
- 🏙️ List all customers from a specific city  
- 📚 Show total number of books available  
- 🛒 Retrieve orders for a particular customer  
- 💵 Total marketing spend per city  
- 💎 Identify the book with the highest price  
- 🏆 Top customers by quantity purchased  
- 📊 Revenue by genre  
- 💸 Customers with high marketing spend  
- 📈 Books priced above genre average  
- 🌆 City with highest total orders  
- 🔝 Top 2 books by quantity sold  
- 🧮 RFM metrics for each customer  
- 💹 Profit per customer (Revenue – Marketing Spend)  
- 📅 Total revenue per month  
- 🔁 Customers who ordered more than once  
- 🧾 Average order value  
- 🤝 Frequently bought book pairs  
- ⏳ Customers inactive for more than a year  

---

## 🔍 Sample Insights & Recommendations

### 👥 Customer Insights
- Most active customers: Alice, Ian, Jane  
- Some customers haven’t purchased in over a year → risk of churn  
**Recommendation:** Loyalty programs and re-engagement campaigns 💌  

### 📈 Sales & Revenue Analysis
- Best-selling books: “Data Science 101”, “The Art of SQL”  
- Highest revenue genres: Education, Technology  
**Recommendation:** Focus on popular genres and bundle slower-selling books 📦  

### 📦 Inventory Management
- Low-stock books: “Fantasy World Chronicles”, “Space Explorers”  
**Recommendation:** Restock books and promote unsold inventory ⚠️  

### 💰 Marketing & ROI
- High marketing spend doesn’t always correlate to high revenue  
**Recommendation:** Optimize marketing budget by targeting high-ROI customers 🎯  

### 🤝 Product & Cross-Selling
- Certain books are frequently bought together  
**Recommendation:** Create book bundles and upsell related books 📚+📚  

### 🏙️ Operational Metrics
- New York has the highest total orders  
**Recommendation:** Prioritize logistics and marketing in high-demand cities 🚚  

---



