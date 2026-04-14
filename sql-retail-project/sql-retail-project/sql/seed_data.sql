-- ============================================================
--  Online Retail Sales Analysis Database
--  seed_data.sql  –  Sample / Demo Data
-- ============================================================

-- ----------------------------------------------------------
-- Customers  (20 records)
-- ----------------------------------------------------------
INSERT INTO Customers (name, city) VALUES
    ('Aarav Sharma',      'Mumbai'),
    ('Priya Nair',        'Chennai'),
    ('Rohan Mehta',       'Delhi'),
    ('Sneha Reddy',       'Hyderabad'),
    ('Vikram Singh',      'Bengaluru'),
    ('Ananya Iyer',       'Pune'),
    ('Karthik Pillai',    'Kochi'),
    ('Divya Patel',       'Ahmedabad'),
    ('Arjun Bose',        'Kolkata'),
    ('Meera Joshi',       'Jaipur'),
    ('Nikhil Gupta',      'Lucknow'),
    ('Pooja Verma',       'Bhopal'),
    ('Rahul Das',         'Patna'),
    ('Sanya Kapoor',      'Chandigarh'),
    ('Tarun Malhotra',    'Noida'),
    ('Usha Krishnan',     'Coimbatore'),
    ('Vivek Agarwal',     'Surat'),
    ('Wanjiru Kamau',     'Delhi'),
    ('Yashika Tiwari',    'Nagpur'),
    ('Zara Hussain',      'Hyderabad');

-- ----------------------------------------------------------
-- Products  (25 records)
-- ----------------------------------------------------------
INSERT INTO Products (name, category, price) VALUES
    ('iPhone 15 Pro',          'Electronics',   129999.00),
    ('Samsung Galaxy S24',     'Electronics',    89999.00),
    ('Sony WH-1000XM5',        'Electronics',    29999.00),
    ('Dell XPS 15 Laptop',     'Electronics',   149999.00),
    ('iPad Air 5',             'Electronics',    74999.00),
    ('Levi''s 511 Jeans',      'Clothing',        3499.00),
    ('Nike Air Max 270',       'Footwear',        9499.00),
    ('Adidas Ultraboost 22',   'Footwear',       12999.00),
    ('Zara Floral Dress',      'Clothing',        4999.00),
    ('Allen Solly Shirt',      'Clothing',        2299.00),
    ('The Alchemist',          'Books',            499.00),
    ('Atomic Habits',          'Books',            699.00),
    ('Rich Dad Poor Dad',      'Books',            399.00),
    ('Prestige Iron',          'Home Appliances',  2999.00),
    ('Philips Air Fryer',      'Home Appliances',  8499.00),
    ('Dyson V12 Vacuum',       'Home Appliances', 49999.00),
    ('IKEA Study Desk',        'Furniture',       12999.00),
    ('Wooden Bookshelf',       'Furniture',        7499.00),
    ('Ergonomic Chair',        'Furniture',       18999.00),
    ('Whey Protein 2kg',       'Health & Fitness',  2999.00),
    ('Yoga Mat Premium',       'Health & Fitness',  1499.00),
    ('Resistance Bands Set',   'Health & Fitness',   799.00),
    ('Face Serum SPF50',       'Beauty',           1299.00),
    ('Hair Dryer Pro',         'Beauty',           3499.00),
    ('Perfume EDP 100ml',      'Beauty',           4999.00);

-- ----------------------------------------------------------
-- Orders  (50 records, spread across 2023-2024)
-- ----------------------------------------------------------
INSERT INTO Orders (customer_id, date) VALUES
    ( 1, '2023-01-15'), ( 3, '2023-01-22'), ( 5, '2023-02-05'),
    ( 2, '2023-02-18'), ( 7, '2023-03-01'), ( 9, '2023-03-14'),
    ( 4, '2023-04-02'), ( 6, '2023-04-19'), ( 8, '2023-05-07'),
    (10, '2023-05-23'), ( 1, '2023-06-10'), (11, '2023-06-28'),
    (12, '2023-07-04'), (13, '2023-07-19'), (14, '2023-08-01'),
    (15, '2023-08-15'), (16, '2023-09-03'), (17, '2023-09-20'),
    (18, '2023-10-07'), (19, '2023-10-25'), (20, '2023-11-11'),
    ( 2, '2023-11-28'), ( 3, '2023-12-05'), ( 4, '2023-12-20'),
    ( 5, '2024-01-08'), ( 6, '2024-01-25'), ( 7, '2024-02-10'),
    ( 8, '2024-02-27'), ( 9, '2024-03-15'), (10, '2024-03-30'),
    ( 1, '2024-04-12'), (11, '2024-04-28'), (12, '2024-05-09'),
    (13, '2024-05-24'), (14, '2024-06-06'), (15, '2024-06-21'),
    (16, '2024-07-03'), (17, '2024-07-18'), (18, '2024-08-01'),
    (19, '2024-08-16'), (20, '2024-09-02'), ( 1, '2024-09-17'),
    ( 2, '2024-10-05'), ( 3, '2024-10-20'), ( 4, '2024-11-07'),
    ( 5, '2024-11-22'), ( 6, '2024-12-03'), ( 7, '2024-12-18'),
    ( 8, '2024-12-28'), ( 9, '2024-12-30');

-- ----------------------------------------------------------
-- Order_Items
-- ----------------------------------------------------------
INSERT INTO Order_Items (order_id, product_id, quantity) VALUES
    -- Order 1
    (1, 1, 1),(1, 11, 2),
    -- Order 2
    (2, 4, 1),(2, 20, 1),
    -- Order 3
    (3, 7, 2),(3, 10, 1),
    -- Order 4
    (4, 2, 1),(4, 23, 2),
    -- Order 5
    (5, 15, 1),(5, 21, 3),
    -- Order 6
    (6, 6, 2),(6, 12, 1),
    -- Order 7
    (7, 19, 1),(7, 22, 2),
    -- Order 8
    (8, 3, 1),(8, 25, 1),
    -- Order 9
    (9, 8, 1),(9, 20, 2),
    -- Order 10
    (10,16, 1),(10,13, 3),
    -- Order 11
    (11, 5, 1),(11,11, 1),
    -- Order 12
    (12,14, 2),(12,21, 1),
    -- Order 13
    (13, 9, 2),(13,24, 1),
    -- Order 14
    (14,17, 1),(14,12, 2),
    -- Order 15
    (15, 1, 1),(15,22, 4),
    -- Order 16
    (16, 4, 1),(16,23, 1),
    -- Order 17
    (17, 7, 1),(17,20, 2),
    -- Order 18
    (18, 2, 1),(18,11, 1),
    -- Order 19
    (19,18, 1),(19,25, 2),
    -- Order 20
    (20, 6, 3),(20,14, 1),
    -- Order 21
    (21, 3, 1),(21,12, 2),
    -- Order 22
    (22, 5, 1),(22,21, 1),
    -- Order 23
    (23,15, 1),(23,22, 3),
    -- Order 24
    (24, 8, 2),(24,13, 1),
    -- Order 25
    (25, 1, 2),(25,11, 1),
    -- Order 26
    (26,19, 1),(26,20, 1),
    -- Order 27
    (27, 4, 1),(27,25, 1),
    -- Order 28
    (28, 9, 1),(28,23, 2),
    -- Order 29
    (29, 2, 1),(29,21, 2),
    -- Order 30
    (30,16, 1),(30,12, 1),
    -- Order 31
    (31, 7, 2),(31,22, 1),
    -- Order 32
    (32,14, 1),(32,20, 3),
    -- Order 33
    (33, 5, 1),(33,11, 2),
    -- Order 34
    (34, 3, 1),(34,24, 1),
    -- Order 35
    (35,17, 2),(35,13, 1),
    -- Order 36
    (36, 1, 1),(36,21, 2),
    -- Order 37
    (37, 6, 2),(37,25, 1),
    -- Order 38
    (38,15, 1),(38,22, 1),
    -- Order 39
    (39, 8, 1),(39,20, 2),
    -- Order 40
    (40, 4, 1),(40,12, 3),
    -- Order 41
    (41, 2, 1),(41,23, 1),
    -- Order 42
    (42,19, 1),(42,11, 1),
    -- Order 43
    (43, 3, 2),(43,21, 2),
    -- Order 44
    (44, 7, 1),(44,25, 2),
    -- Order 45
    (45, 5, 1),(45,22, 1),
    -- Order 46
    (46,16, 1),(46,13, 2),
    -- Order 47
    (47, 9, 1),(47,20, 3),
    -- Order 48
    (48, 1, 1),(48,24, 1),
    -- Order 49
    (49, 4, 2),(49,11, 1),
    -- Order 50
    (50, 8, 1),(50,21, 2);
