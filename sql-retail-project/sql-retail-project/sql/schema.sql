-- ============================================================
--  Online Retail Sales Analysis Database
--  schema.sql  –  Tables + Constraints
-- ============================================================

-- Drop tables if they already exist (safe re-run)
DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- ----------------------------------------------------------
-- 1. Customers
-- ----------------------------------------------------------
CREATE TABLE Customers (
    customer_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name          TEXT    NOT NULL,
    city          TEXT    NOT NULL
);

-- ----------------------------------------------------------
-- 2. Products
-- ----------------------------------------------------------
CREATE TABLE Products (
    product_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    category    TEXT    NOT NULL,
    price       REAL    NOT NULL CHECK (price > 0)
);

-- ----------------------------------------------------------
-- 3. Orders
-- ----------------------------------------------------------
CREATE TABLE Orders (
    order_id    INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER NOT NULL,
    date        TEXT    NOT NULL,   -- stored as YYYY-MM-DD
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- ----------------------------------------------------------
-- 4. Order_Items
-- ----------------------------------------------------------
CREATE TABLE Order_Items (
    order_id    INTEGER NOT NULL,
    product_id  INTEGER NOT NULL,
    quantity    INTEGER NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)   REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
