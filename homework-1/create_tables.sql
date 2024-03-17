CREATE TABLE customers
(
	customer_id varchar(5) PRIMARY KEY,
	company_name varchar(100) NOT NULL,
	contact_name varchar(100) NOT NULL
);

SELECT * FROM customers;

CREATE TABLE employees
(
	employee_id int PRIMARY KEY,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	title varchar(100) NOT NULL,
	birth_date date NOT NULL,
	notes text
);

SELECT * FROM employees;

CREATE TABLE orders
(
	order_id int PRIMARY KEY,
	customer_id varchar(5) NOT NULL,
	employee_id int NOT NULL,
	order_date date NOT NULL,
	ship_city varchar(100) NOT NULL
--	FOREIGN KEY (customer_id) REFERENCES customers(customer_id), # missed reference
--  FOREIGN KEY (employee_id) REFERENCES employees(employee_id) # missed reference
);

SELECT * FROM orders;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);

SELECT * FROM orders;