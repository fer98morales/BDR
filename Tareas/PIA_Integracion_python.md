# Usando PostgreSQL en Python
Descubre cómo crear, conectarse y administrar bases de datos PostgreSQL utilizando el paquete psycopg2 de Python.

## Comprendiendo PostgreSQL
PostgreSQL es una base de datos relacional ligera, gratuita y de código abierto.

## Comprendiendo psycopg2
Para conectarse a una base de datos que ya está creada en tu sistema o en Internet, deberás indicarle a Python cómo detectarla. En otras palabras, tendrás que decirle a Python que la base de datos de tu interés es una base de datos PostgreSQL.

En Python, tienes varias opciones entre las cuales puedes elegir. En este caso, utilizaremos psycopg2, probablemente el adaptador de base de datos PostgreSQL más popular para Python. Psycopg2 requiere algunos requisitos previos para funcionar correctamente en tu computadora.

Una vez que psycopg2 esté instalado, podrás usarlo en tus proyectos de Python para interactuar con bases de datos PostgreSQL.
```console
pip install psycopg2
```

## Conexión de Python a PostgreSQL
Para utilizar Python y realizar operaciones con una base de datos PostgreSQL, es necesario establecer una conexión. Esto se logra mediante la función connect() de psycopg2, la cual crea una nueva sesión de base de datos y devuelve una nueva instancia de conexión.

```python 
import psycopg2

# Estableciendo la conexión con la base de datos
conn = psycopg2.connect(database="dummy", 
                        user="postgres", 
                        host="localhost",
                        password="postgre",
                        port=5432)

```

Los parámetros básicos de conexión requeridos son los siguientes:

* database.  El nombre de la base de datos.
* user. El nombre de usuario necesario para autenticarse.
* password. La contraseña utilizada para la autenticación.
* host. La dirección del servidor de la base de datos (en nuestro caso, la base de datos está alojada localmente, pero también podría ser una dirección IP).
* port. El número de puerto de conexión (por defecto es 5432 si no se proporciona).

## Creando una tabla en PostgreSQL
La conexión encapsula una sesión de base de datos, lo que te permite ejecutar comandos y consultas SQL, como SELECT, INSERT, CREATE, UPDATE o DELETE, utilizando el método cursor(), y hacer que los cambios sean persistentes utilizando el método commit().

Una vez que hayas creado la instancia del cursor, puedes enviar comandos a la base de datos utilizando el método execute() y recuperar datos de una tabla utilizando fetchone(), fetchmany() o fetchall().

```python 
# Abrir un cursor para realizar operaciones en la base de datos
cur = conn.cursor()

# Ejecutar un comando: eliminar la tabla users si existe
cur.execute("""DROP TABLE IF EXISTS users CASCADE;""")

# Ejecutar un comando: crear la tabla users
cur.execute("""
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    team VARCHAR(100),
    name VARCHAR(100),
    email VARCHAR(100),
    age INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);
""")

# Hacer que los cambios en la base de datos sean persistentes
conn.commit()

# Cerrar el cursor y la conexión con la base de datos
cur.close()
conn.close()
```

# Ejecutando consultas básicas en PostgreSQL con Python
Ahora que la tabla "users" está lista, ¡es hora de usar PostgreSQL para realizar algunas consultas básicas!

## INSERT 
Puede que hayas notado que la tabla aún no tiene valores. Para crear registros en la tabla "users", necesitamos el comando INSERT.

```python 
# Abrir un cursor para realizar operaciones en la base de datos
cur = conn.cursor()

# Ejecutar comandos INSERT para agregar registros a la tabla "users"
cur.execute("INSERT INTO users(team, name, email, age) VALUES('red','John Doe', 'johndoe@example.com', 30)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('green','Jane Smith', 'janesmith@example.com', 25)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('blue','Mike Johnson', 'mikejohnson@example.com', 28)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('red','Emily Davis', 'emilydavis@example.com', 33)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('green','David Wilson', 'davidwilson@example.com', 22)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('blue','Sarah Thompson', 'sarahthompson@example.com', 29)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('red','Michael Brown', 'michaelbrown@example.com', 31)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('green','Jennifer Martinez', 'jennifermartinez@example.com', 27)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('blue','Matthew Taylor', 'matthewtaylor@example.com', 35)")
cur.execute("INSERT INTO users(team, name, email, age) VALUES('red','Olivia Clark', 'oliviaclark@example.com', 26)")

# Hacer que los cambios en la base de datos sean persistentes
conn.commit()

# Cerrar el cursor y la conexión con la base de datos
cur.close()
conn.close()
```

## SELECT 
Usaremos la clásica sentencia SELECT * FROM nombre_basededatos para leer todos los datos disponibles en la tabla. Luego, utilizaremos el método fetchall() para obtener todas las filas disponibles. Ten en cuenta que PostgreSQL crea automáticamente un índice numérico para la fila.

```python 
# Abrir un cursor para realizar operaciones en la base de datos
cur = conn.cursor()

# Ejecutar una consulta SELECT para obtener todos los datos de la tabla "users"
cur.execute('SELECT * FROM users')

# Obtener todas las filas resultantes de la consulta
rows = cur.fetchall()

# Hacer que los cambios en la base de datos sean persistentes
conn.commit()

# Cerrar el cursor y la conexión con la base de datos
cur.close()
conn.close()

# Imprimir los resultados obtenidos
for row in rows:
    print(row)
```

# UPDATE 
A menudo, los datos vienen con errores y es necesario realizar modificaciones en la base de datos. Para hacerlo, utilizamos el comando UPDATE.
```python 
# Abrir un cursor para realizar operaciones en la base de datos
cur = conn.cursor()

# Ejecutar un comando UPDATE para corregir el correo electrónico de John Doe
cur.execute("UPDATE users SET email = 'johndoe2@example.com' WHERE name = 'John Doe'")

# Hacer que los cambios en la base de datos sean persistentes
conn.commit()

# Cerrar el cursor y la conexión con la base de datos
cur.close()
conn.close()
```

# DELETE 
Es posible que desees eliminar uno de los registros de tu tabla. Para hacerlo, utilizamos la sentencia DELETE.

```python 
# Abrir un cursor para realizar operaciones en la base de datos
cur = conn.cursor()

# Ejecutar un comando DELETE para eliminar el registro de David Wilson
cur.execute("DELETE from users WHERE name = 'Olivia Clark';")

# Hacer que los cambios en la base de datos sean persistentes
conn.commit()

# Cerrar el cursor y la conexión con la base de datos
cur.close()
conn.close()
```

# ORDER BY 
upongamos que deseas ordenar tu base de datos por el correo electrónico (email) de los usuarios. Puedes utilizar la sentencia ORDER BY:
```python 
# Abrir un cursor para realizar operaciones en la base de datos
cur = conn.cursor()

# Ejecutar una consulta SELECT para obtener todos los datos de la tabla "users" ordenados por correo electrónico
cur.execute('SELECT * FROM users ORDER BY email')

# Obtener todas las filas resultantes de la consulta
rows = cur.fetchall()

# Cerrar el cursor y la conexión con la base de datos
cur.close()
conn.close()

# Imprimir los resultados obtenidos
for row in rows:
    print(row)
```

# GROUP BY
Es posible que desees realizar algunas funciones de agregación dentro de diferentes grupos de datos.
```python 
# Abrir un cursor para realizar operaciones en la base de datos
cur = conn.cursor()

# Ejecutar una consulta con GROUP BY para obtener la cantidad de usuarios por cada valor único en la columna "team"
# También se calcula la media de edad (average) redondeada a entero y se le asigna un alias "AVG_age", y se cuenta el número de jugadores y se le asigna un alias "players"
cur.execute('SELECT team, round(avg(age)) as AVG_age, COUNT(*) as players FROM users GROUP BY team')

# Obtener todas las filas resultantes de la consulta
rows = cur.fetchall()

# Cerrar el cursor y la conexión con la base de datos
cur.close()
conn.close()

# Imprimir los resultados obtenidos
for row in rows:
    print(row)
```

# Example CREATE
```console
pip install yfinance
```

```python
import pandas as pd
import yfinance as yf
import psycopg2

# Definir el símbolo del ticker de la acción y el rango de fechas
stock_symbol = 'AAPL'  # Apple Inc.
start_date = '2023-01-01'
end_date = '2023-07-18'

# Descargar datos financieros desde Yahoo Finance
stock_data = yf.download(stock_symbol, start=start_date, end=end_date)

# Detalles de conexión a la base de datos
db_params = {
    'database': 'dummy',
    'user': 'postgres',
    'host': 'localhost',
    'password': 'postgre',
    'port': 5432
}

# Establecer una conexión con la base de datos PostgreSQL
conn = psycopg2.connect(**db_params)

# Crear la tabla de datos financieros
financial_table_name = f'{stock_symbol}_datos_financieros'
with conn.cursor() as cur:
    # Eliminar la tabla de datos financieros si existe
    cur.execute(f'''
        DROP TABLE IF EXISTS {financial_table_name} CASCADE
    ''')

    # Crear la tabla de datos financieros
    cur.execute(f'''
        CREATE TABLE {financial_table_name} (
            Fecha DATE PRIMARY KEY,
            Apertura FLOAT,
            Cierre FLOAT,
            Volumen BIGINT
        )
    ''')

    # Insertar los datos financieros
    for index, row in stock_data.iterrows():
        cur.execute(f'''
            INSERT INTO {financial_table_name} (Fecha, Apertura, Cierre, Volumen)
            VALUES (%s, %s, %s, %s)
        ''', (index, row['Open'], row['Close'], row['Volume']))

    # Confirmar los cambios para la tabla de datos financieros
    conn.commit()

# Eliminar la tabla de datos diarios de la acción si existe
daily_stock_table_name = f'{stock_symbol}_datos_diarios_accion'
with conn.cursor() as cur:
    cur.execute(f'''
        DROP TABLE IF EXISTS {daily_stock_table_name} CASCADE
    ''')

    # Crear una tabla para almacenar los datos diarios de la acción
    cur.execute(f'''
        CREATE TABLE IF NOT EXISTS {daily_stock_table_name} (
            Fecha DATE PRIMARY KEY,
            CierreAnterior FLOAT,
            MinimoDia FLOAT,
            MaximoDia FLOAT,
            Volumen BIGINT
        )
    ''')

# Insertar los datos diarios de la acción en la tabla
with conn.cursor() as cur:
    for index, row in stock_data.iterrows():
        cur.execute(f'''
            INSERT INTO {daily_stock_table_name} (Fecha, CierreAnterior, MinimoDia, MaximoDia)
            VALUES (%s, %s, %s, %s)
        ''', (index, row['Close'], row['Low'], row['High']))

# Confirmar los cambios y cerrar la conexión
conn.commit()
conn.close()

print(f"Datos financieros de {stock_symbol} guardados en la tabla '{financial_table_name}' en PostgreSQL.")
print(f"Datos diarios de la acción de {stock_symbol} guardados en la tabla '{daily_stock_table_name}' en PostgreSQL.")
```

# Example JOIN
```python
import pandas as pd
import psycopg2

# Detalles de conexión a la base de datos
db_params = {
    'database': 'dummy',
    'user': 'postgres',
    'host': 'localhost',
    'password': 'postgre',
    'port': 5432
}

# Establecer una conexión con la base de datos PostgreSQL
conn = psycopg2.connect(**db_params)

# Definir el símbolo de la acción para obtener los datos
stock_symbol = 'AAPL'

# Definir los nombres de las dos tablas
financial_table_name = f'{stock_symbol}_datos_financieros'
daily_stock_table_name = f'{stock_symbol}_datos_diarios_accion'

# Definir el nombre de la nueva tabla para almacenar los datos unidos
joined_table_name = f'{stock_symbol}_datos_unidos'

# Consulta SQL para eliminar la tabla unida si existe
drop_table_query = f'''
    DROP TABLE IF EXISTS {joined_table_name};
'''

# Consulta SQL para realizar la operación de JOIN y crear la nueva tabla
join_query = f'''
    CREATE TABLE {joined_table_name} AS
    SELECT f.Fecha, f.Apertura, f.Cierre, f.Volumen,
           d.CierreAnterior, d.MinimoDia, d.MaximoDia AS volumen_diario
    FROM {financial_table_name} AS f
    JOIN {daily_stock_table_name} AS d
    ON f.Fecha = d.Fecha;
'''

# Ejecutar la consulta para ELIMINAR LA TABLA
with conn.cursor() as cur:
    cur.execute(drop_table_query)
    conn.commit()

# Ejecutar la consulta para UNIR LAS TABLAS y crear la nueva tabla
with conn.cursor() as cur:
    cur.execute(join_query)
    conn.commit()

# Cerrar la conexión
conn.close()

print(f"Los datos unidos para {stock_symbol} se han guardado en la tabla '{joined_table_name}' en PostgreSQL.")
```