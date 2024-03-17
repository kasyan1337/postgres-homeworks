import psycopg2

conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='1337', port='5433')

try:
    with conn:
        with conn.cursor() as cur:

            # ##### CUSTOMERS TABLE #####

            cur.execute("INSERT INTO customers VALUES (%s, %s, %s)", (customer_id, company_name, contact_name))

            rows = cur.fetchall()
            for row in rows:
                print(row)

            # ##### EMPLOYEES TABLE #####

            cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)",
                        (employee_id, first_name, last_name, title, birth_date, notes))

            rows = cur.fetchall()
            for row in rows:
                print(row)

            # ##### ORDERS TABLE #####


            cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)",
                        (order_id, customer_id_o, employee_id_o, order_date, ship_city))

            rows = cur.fetchall()
            for row in rows:
                print(row)

            # conn.commit() # not needed, because conn is opened with 'with', so it automatically commits


finally:
    conn.close()  # must be closed here
