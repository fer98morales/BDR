## Agregar datos ficticios o de otras fuentes de manera automática (mediante funciones como las vistas en esta tarea).
1. Crear las tablas vacías.
    ```postgresql
    DROP TABLE IF EXISTS business CASCADE;

    CREATE TABLE public.business (
        business_id varchar(22) PRIMARY KEY,
        "name" varchar(64) ,
        address varchar(110) ,
        city varchar(52) ,
        state varchar(3) ,
        postal_code varchar(10) ,
        latitude float8 ,
        longitude float8 ,
        stars float8 ,
        review_count int8 ,
        is_open int8 ,
        "attributes" varchar(1514) ,
        categories varchar(503) ,
        hours varchar(183) 
    );
    ```

2. Abre tu consola de comandos (cmd) e ingresa PostgreSQL (debes poner el numero de tu version donde dice #Version)
    ```cmd
    cd "C:\Program Files\PostgreSQL\#Version\bin"
    ```

    ingresa tu usuario.
    ```cmd
    psql -U usuario
    ```


3. Dentro de PostgreSQL, selecciona tu base de datos.
    ```cmd
    \c database
    ```

4. Utiliza la función COPY para agregar tu archivo CSV a tu tabla.
    ```cmd
    COPY business FROM 'path/to/yelp_academic_dataset_business.csv' DELIMITER ',' CSV HEADER;
    ```


---  
## Reportar en menos de 5 minutos hallazgos, dificultades, recomendaciones o recursos que sean relevantes. 
Al trabajar con la base de datos de Yelp, tuve problemas para cargar los datos, ya que me fueron proporcionados en formato JSON (debido a su tamaño). 
Para resolver esta situación, opté por utilizar Python para convertir los archivos JSON a formato CSV, lo cual facilitó su procesamiento.

Una vez convertidos los archivos a CSV, procedí a importarlos a PostgreSQL también mediante el uso de Python. Sin embargo, es importante destacar que antes de realizar la importación, fue necesario crear la tabla correspondiente en PostgreSQL con los atributos correctos. Para ello, tuve que asegurarme de seguir el mismo orden en el cual aparecían los atributos en el archivo JSON original.

### Código para convertir JSON a CSV
```python
import pandas as pd

# Specify the path to the JSON file
json_file_path = "path/to/yelp_academic_dataset_business.json"

# Specify the path for the output CSV file
csv_file_path = "path/to/output/yelp_academic_dataset_business.csv"

# Read the JSON file into a pandas DataFrame
df = pd.read_json(json_file_path, lines=True)

# Convert the DataFrame to CSV
df.to_csv(csv_file_path, index=False)

print("Conversion completed successfully!")

```

### Código para crear tablas vacías
```postgreSQL

DROP TABLE IF EXISTS business CASCADE;

CREATE TABLE public.business (
	business_id varchar(22) PRIMARY KEY,
	"name" varchar(64) ,
	address varchar(110) ,
	city varchar(52) ,
	state varchar(3) ,
	postal_code varchar(10) ,
	latitude float8 ,
	longitude float8 ,
	stars float8 ,
	review_count int8 ,
	is_open int8 ,
	"attributes" varchar(1514) ,
	categories varchar(503) ,
	hours varchar(183) 
);

```

### Código para importar CSV a PostgreSQL
```python
import pandas as pd
import psycopg2
from psycopg2 import sql

# PostgreSQL connection details
host="your_host",
port="your_port",
database="your_database",
user="your_user",
password="your_password"

# Path to the CSV file
csv_file = "path/to/yelp_academic_dataset_business.csv"

# Connect to the PostgreSQL database
conn = psycopg2.connect(
    host=host,
    database=database,
    user=user,
    password=password,
    port=port
)

# Create a cursor to execute SQL queries
cur = conn.cursor()

# Extract the table name from the CSV file name
table_name = csv_file.split("/")[-1].split(".csv")[0]

# Read the CSV file using pandas
df = pd.read_csv(csv_file)

# Create the table in PostgreSQL using the column names and data types from the CSV
create_table_query = sql.SQL("CREATE TABLE IF NOT EXISTS {} ({});").format(
    sql.Identifier(table_name),
    sql.SQL(", ").join(sql.Identifier(column) + sql.SQL(" TEXT") for column in df.columns)
)
cur.execute(create_table_query)

# Insert the data from the CSV into the PostgreSQL table
for _, row in df.iterrows():
    insert_query = sql.SQL("INSERT INTO {} VALUES ({});").format(
        sql.Identifier(table_name),
        sql.SQL(", ").join(sql.Placeholder() * len(row))
    )
    cur.execute(insert_query, list(row))

conn.commit()

# Close the cursor and database connection
cur.close()
conn.close()

```



---  
## Calificación anónima dada en promedio por otros compañeros y autoevaluación.
Considero que mis compañeros/as hicieron un excelente trabajo, mostrando gran detalle en sus tareas. Noté que abordamos algunas cosas de manera diferente, en particular, me llamó la atención el cuidado que pusieron en el formato del archivo Markdown. Además, valoré especialmente el uso de Mermaid por parte de ellos, ya que lograron mostrar el diagrama completo con un espacio adecuado entre cada entidad, algo que me resultó un poco difícil de lograr. Basándome en mi desempeño, me calificaría con un 9. Creo que he hecho un buen trabajo, pero también creo que hay espacio para mejorar en futuros proyectos.