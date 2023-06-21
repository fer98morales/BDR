# Inconsistencias en base de datos Yelp
- PostgreSQL usa BEGIN en lugar de START TRANSACTION
- [Archivo SQL](https://github.com/fer98morales/BDR/blob/master/Tareas/Tarea7.sql)

## Inconsistencias en la tabla business
---
1. McDonald's cuenta con 3 versiones distintas 
    |name|
    |----|
    |McDonald's|
    |McDonalds|
    |McDonalds's|

    ``` postgresql
    /* Reemplazamos las variaciones de McDonald's */
    BEGIN;
    UPDATE business
    SET name = REPLACE(name, 'McDonalds''s', 'McDonald''s')
    WHERE name LIKE 'McDonald%';
    COMMIT;
    ```

2. En los negocios registrados encontre direcciones duplicadas 
    |name|city|address|count|
    |----|----|-------|-----|
    |Starbucks|St. Louis|10701 Natural Bridge Rd|5|
    |Starbucks|Tampa|4100 George J Bean Pkwy|4|
    |Kroger|Nashville|3410 Gallatin Pike|3|
    |XpresSpa|Philadelphia|8000 Essington Ave|3|

    Utilice google para validar el numero de starbucks y es correcto (estan en un aeropuerto) pero Kroger y XpresSpa si son duplicados repetidos

    ``` postgresql
    BEGIN;
    /* Actualizo los IDs de los comentarios para que sean iguales */
    UPDATE review
    SET review_id = 'BMcyBSKVkaCfKqz-STbvrw'
    WHERE business_id IN (
        'BMcyBSKVkaCfKqz-STbvrw',
        'U3J_imHxyCx3hTLZprLPkA',
        'YT1ZJrFHgwbeZvzOqSe1LA'
    );

    /* Ahora eliminaré los negocios duplicados de la tabla "business" */
    DELETE FROM business
    WHERE name = 'Kroger'
    AND address = '3410 Gallatin Pike'
    AND business_id <> 'BMcyBSKVkaCfKqz-STbvrw';

    COMMIT;
    ```

3. Las categorias de los negocios se repiten pero tienen distinto orden generando 2 categorias 
    |categories|
    |----------|
    |Chicken Wings, Fast Food, Restaurants, Italian, Pizza|
    |Chicken Wings, Fast Food, Restaurants, Pizza, Italian|

    ``` postgresql
    /* Dividimos las categorías utilizando una separación por coma y luego las volvemos a unir, pero esta vez en orden alfabético, para asegurar que
    *  estén consistentemente ordenadas */
    BEGIN;

    UPDATE business
    SET categories = (
        SELECT string_agg(category, ', ' ORDER BY category)
        FROM (
            SELECT trim(category) AS category
            FROM regexp_split_to_table(categories, ',')
        ) AS categories
    )
    WHERE categories LIKE '%, %';

    COMMIT;
    ```



---
## Inconsistencias en la tabla checkin
1. Todas las visitas son registradas bajo una sola columna de fecha en lugar de crear una fila por visita
    |business_id|date|
    |-----------|----|
    |--vx2CCaG3wOSoTnRG-rig|2017-07-09 17:41:57, 2019-07-12 23:53:39, 2020-02-17 23:56:48|
    |09aZ4Vhravt9E5x-OFchxg|2014-05-29 23:27:18, 2014-12-16 18:16:05, 2016-09-25 17:57:43|
    |--qLiYw2ErSmvVwumb2kdw|2018-03-30 22:52:21, 2018-04-13 23:37:09, 2018-05-16 23:05:50|
    |--sgBOzb76sjOQ-Xhdjffw|2018-08-01 23:08:27, 2018-08-12 18:39:28, 2019-05-04 14:54:58|
    |0iylAbRUKVOM7c2X5FUCuw|2019-07-26 19:32:25, 2019-09-12 12:49:26, 2020-05-19 16:24:52|

    ``` postgresql
    /* Dividimos las fechas en filas separadas en la tabla checkin */
    BEGIN;

    /* Creamos una tabla temporal para almacenar las fechas divididas */
    CREATE TABLE #temp_dates (
        business_id VARCHAR(255),
        date_value DATETIME
    );

    /* Dividimos las fechas y las insertamos en la tabla temporal */
    INSERT INTO #temp_dates (business_id, date_value)
    SELECT 
        business_id,
        CAST(value AS DATETIME) AS date_value
    FROM
        checkin
    CROSS APPLY
        STRING_SPLIT("date", ',');

    /* Eliminamos las filas originales de la tabla checkin */
    DELETE FROM checkin;

    /* Insertamos las fechas divididas en la tabla checkin */
    INSERT INTO checkin (business_id, "date")
    SELECT
        business_id,
        CONVERT(VARCHAR, date_value, 120) AS "date"
    FROM
        #temp_dates;

    /* Eliminamos la tabla temporal */
    DROP TABLE #temp_dates;

    COMMIT;
    ```

---

---
## Inconsistencias en la tabla review

Los datos se ven bien y no requieren cambios.

---

---
## Inconsistencias en la tabla tip

Los datos se ven bien y no requieren cambios.

---

---
## Inconsistencias en la tabla user

Los datos se ven bien y no requieren cambios.

---