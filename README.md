🛒 Online Store Database Management System
📖 Project Overview

This project is a relational database system designed for managing an online store.
It simulates real-world e-commerce operations including customer management, product catalog, order processing, and sales analytics.

The system is inspired by platforms like Amazon and Flipkart.

Developed using:

MySQL

MySQL Workbench

🎯 Objectives

Design a normalized relational database

Implement Primary and Foreign Key relationships

Enforce data integrity using constraints

Perform analytical queries for business insights

Implement triggers for automation

Create views for reporting

🗂 Database Schema

The database contains the following tables:

customers

product_categories

products

customer_orders

order_items

🔗 Relationships

One Customer → Many Orders

One Order → Many Order Items

One Category → Many Products

One Product → Many Order Items

Foreign key constraints maintain referential integrity.

🧱 Features Implemented

✅ AUTO_INCREMENT Primary Keys
✅ UNIQUE constraint on email
✅ CHECK constraints for price and stock
✅ Foreign key relationships
✅ Trigger to auto-reduce stock after purchase
✅ Sales summary View
✅ Business analytical queries

⚙️ Advanced Components
🔄 Trigger

Automatically reduces product stock when a new order item is inserted.

📊 View

sales_summary view provides simplified sales reporting.

📈 Sample Analytical Queries
1️⃣ Top 5 Customers by Spending
SELECT 
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN customer_orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;
2️⃣ Total Revenue (Completed Orders)
SELECT SUM(total_amount) AS total_revenue 
FROM customer_orders
WHERE order_status = 'Completed';
3️⃣ Low Stock Products
SELECT product_name, stock
FROM products
WHERE stock < 10;
🧮 Database Concepts Used

Normalization (3NF structure)

Joins (INNER JOIN)

Aggregate Functions (SUM, COUNT)

GROUP BY and ORDER BY

Views

Triggers

Constraints

Indexing principles

🗃 How to Run the Project

Open MySQL Workbench

Create a new schema

Run:

Database creation script

Table creation script

Sample data script

Trigger & View script

Execute analytical queries

📊 ER Diagram

The ER diagram was generated using MySQL Workbench Reverse Engineering feature.

(Insert ER Diagram image here)

🚀 Learning Outcomes

Through this project, I gained hands-on experience in:

Designing relational database systems

Implementing real-world business logic

Writing optimized SQL queries

Maintaining data integrity

Creating automated database processes

📌 Future Improvements

Stored procedures for order placement

Payment management module

Customer authentication system

Performance optimization with indexing

Dashboard integration

👩‍💻 Author

3rd Year Computer Science Student
Passionate about Database Systems & Data Analytic
