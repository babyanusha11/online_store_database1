CREATE DATABASE online_store;
USE online_store;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE product_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    category_id INT,
    FOREIGN KEY (category_id) 
        REFERENCES product_categories(category_id)
        ON DELETE SET NULL
);
CREATE TABLE customer_orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) DEFAULT 0,
    order_status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) 
        REFERENCES customers(customer_id)
        ON DELETE CASCADE
);
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) 
        REFERENCES customer_orders(order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id) 
        REFERENCES products(product_id)
);
INSERT INTO product_categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances'),
('Sports'),
('Beauty');
INSERT INTO customers (full_name, email, phone, city) VALUES
('Rahul Sharma', 'rahul1@gmail.com', '9876543210', 'Mumbai'),
('Anita Verma', 'anita1@gmail.com', '9123456780', 'Delhi'),
('Karan Mehta', 'karan1@gmail.com', '9000011111', 'Bangalore'),
('Priya Singh', 'priya1@gmail.com', '9000022222', 'Hyderabad'),
('Arjun Patel', 'arjun1@gmail.com', '9000033333', 'Ahmedabad'),
('Sneha Reddy', 'sneha1@gmail.com', '9000044444', 'Chennai'),
('Vikram Rao', 'vikram1@gmail.com', '9000055555', 'Pune'),
('Neha Kapoor', 'neha1@gmail.com', '9000066666', 'Kolkata'),
('Rohit Das', 'rohit1@gmail.com', '9000077777', 'Jaipur'),
('Meera Iyer', 'meera1@gmail.com', '9000088888', 'Coimbatore'),
('Aditya Nair', 'aditya1@gmail.com', '9000099999', 'Kochi'),
('Pooja Shah', 'pooja1@gmail.com', '9000000000', 'Surat');
INSERT INTO products (product_name, price, stock, category_id) VALUES
('Laptop', 55000, 10, 1),
('Smartphone', 25000, 20, 1),
('Headphones', 2000, 40, 1),
('T-Shirt', 800, 50, 2),
('Running Shoes', 3000, 15, 2),
('Data Science Book', 1200, 30, 3),
('Notebook', 100, 200, 3),
('Refrigerator', 30000, 5, 4),
('Microwave Oven', 12000, 8, 4),
('Cricket Bat', 1500, 25, 5),
('Football', 900, 30, 5),
('Face Cream', 500, 60, 6),
('Shampoo', 350, 70, 6),
('Washing Machine', 28000, 6, 4),
('Smart Watch', 7000, 18, 1);
INSERT INTO customer_orders (customer_id, order_date, total_amount, order_status) VALUES
(1, '2026-03-01', 55000, 'Completed'),
(2, '2026-03-02', 1200, 'Completed'),
(3, '2026-03-03', 25000, 'Pending'),
(4, '2026-03-04', 3000, 'Completed'),
(5, '2026-03-05', 1500, 'Shipped'),
(6, '2026-03-06', 12000, 'Completed'),
(7, '2026-03-07', 900, 'Pending'),
(8, '2026-03-08', 500, 'Completed');
INSERT INTO order_items (order_id, product_id, quantity, subtotal) VALUES
(1, 1, 1, 55000),
(2, 6, 1, 1200),
(3, 2, 1, 25000),
(4, 5, 1, 3000),
(5, 10, 1, 1500),
(6, 9, 1, 12000),
(7, 11, 1, 900),
(8, 12, 1, 500);
DELIMITER //

CREATE TRIGGER reduce_stock
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;
CREATE VIEW sales_summary AS
SELECT 
    c.full_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM customers c
JOIN customer_orders o ON c.customer_id = o.customer_id;
SELECT 
    c.full_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN customer_orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;
SELECT SUM(total_amount) AS total_revenue 
FROM customer_orders
WHERE order_status = 'Completed';
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM customer_orders
WHERE order_status = 'Completed'
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
SELECT 
    pc.category_name,
    SUM(oi.subtotal) AS category_revenue
FROM product_categories pc
JOIN products p 
    ON pc.category_id = p.category_id
JOIN order_items oi 
    ON p.product_id = oi.product_id
GROUP BY pc.category_id
ORDER BY category_revenue DESC;


