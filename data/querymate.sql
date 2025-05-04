-- CREATE TABLE customers (
--   customer_id TEXT PRIMARY KEY,
--   company_name TEXT NOT NULL,
--   contact_name TEXT,
--   contact_title TEXT,
--   address TEXT,
--   city TEXT,
--   region TEXT,
--   postal_code TEXT,
--   country TEXT,
--   phone TEXT,
--   fax TEXT
-- );

-- CREATE TABLE employees (
--   employee_id INTEGER PRIMARY KEY,
--   last_name TEXT NOT NULL,
--   first_name TEXT NOT NULL,
--   title TEXT,
--   title_of_courtesy TEXT,
--   birth_date TEXT,
--   hire_date TEXT,
--   address TEXT,
--   city TEXT,
--   region TEXT,
--   postal_code TEXT,
--   country TEXT,
--   home_phone TEXT,
--   extension TEXT,
--   photo BLOB,
--   notes TEXT,
--   reports_to INTEGER,
--   photo_path TEXT
-- );

-- CREATE TABLE orders (
--   order_id INTEGER PRIMARY KEY,
--   customer_id TEXT,
--   employee_id INTEGER,
--   order_date TEXT,
--   required_date TEXT,
--   shipped_date TEXT,
--   ship_via INTEGER,
--   freight REAL,
--   ship_name TEXT,
--   ship_address TEXT,
--   ship_city TEXT,
--   ship_region TEXT,
--   ship_postal_code TEXT,
--   ship_country TEXT,
--   FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
--   FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
-- );

-- CREATE TABLE products (
--   product_id INTEGER PRIMARY KEY,
--   product_name TEXT NOT NULL,
--   supplier_id INTEGER,
--   category_id INTEGER,
--   quantity_per_unit TEXT,
--   unit_price REAL,
--   units_in_stock INTEGER,
--   units_on_order INTEGER,
--   reorder_level INTEGER,
--   discontinued INTEGER
-- );

-- CREATE TABLE order_details (
--   order_id INTEGER,
--   product_id INTEGER,
--   unit_price REAL,
--   quantity INTEGER,
--   discount REAL,
--   PRIMARY KEY (order_id, product_id),
--   FOREIGN KEY (order_id) REFERENCES orders(order_id),
--   FOREIGN KEY (product_id) REFERENCES products(product_id)
-- );


INSERT INTO customers (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax)
VALUES ('ALFKI', 'Alfreds Futterkiste', 'Maria Anders', 'Sales Representative', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany', '030-0074321', '030-0076545');

INSERT INTO orders (order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country)
VALUES (10248, 'ALFKI', 5, '2023-12-01', '2023-12-10', '2023-12-05', 3, 32.38, 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany');

INSERT INTO employees (employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address, city, region, postal_code, country, home_phone, extension, photo, notes, reports_to, photo_path)
VALUES (5, 'Buchanan', 'Steven', 'Sales Manager', 'Mr.', '1955-03-04', '1993-10-17', '14 Garrett Hill', 'London', NULL, 'SW1 8JR', 'UK', '(71) 555-4848', '3453', NULL, 'Some notes', 2, NULL);

INSERT INTO products (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level, discontinued)
VALUES (1, 'Chai', 1, 1, '10 boxes x 20 bags', 18.00, 39, 0, 10, 0);

INSERT INTO order_details (order_id, product_id, unit_price, quantity, discount)
VALUES (10248, 1, 18.00, 12, 0.0);
