import csv

import psycopg2

conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='1337', port='5433')

try:
    with conn:
        with conn.cursor() as cur:
            # ##### CUSTOMERS TABLE #####

            with open('north_data/customers_data.csv', 'r') as file:
                reader = csv.reader(file)
                next(reader)  # Skip the header row
                for customer_id, company_name, contact_name in reader:
                    cur.execute("INSERT INTO customers (customer_id, company_name, contact_name) VALUES (%s, %s, %s)",
                                (customer_id, company_name, contact_name))

            # ##### EMPLOYEES TABLE #####
            with open('north_data/employees_data.csv', 'r') as file:
                reader = csv.reader(file)
                next(reader)  # Skip the header row
                for employee_id, first_name, last_name, title, birth_date, notes in reader:
                    cur.execute(
                        "INSERT INTO employees (employee_id, first_name, last_name, title, birth_date, notes) VALUES (%s, %s, %s, %s, %s, %s)",
                        (employee_id, first_name, last_name, title, birth_date, notes))

            # ##### ORDERS TABLE #####
            with open('north_data/orders_data.csv', 'r') as file:
                reader = csv.reader(file)
                next(reader)  # Skip the header row
                for order_id, customer_id, employee_id, order_date, ship_city in reader:
                    cur.execute("INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city) VALUES (%s, %s, %s, %s, %s)",
                                (order_id, customer_id, employee_id, order_date, ship_city))


            # conn.commit() # not needed, because conn is opened with 'with', so it automatically commits


finally:
    conn.close()  # must be closed here
