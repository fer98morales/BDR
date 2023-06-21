/*tabla business*/

/* Reemplazamos las variaciones de McDonald's */
BEGIN;
UPDATE business
SET name = REPLACE(name, 'McDonalds''s', 'McDonald''s')
WHERE name LIKE 'McDonald%';
COMMIT;

/* Tenemos tres IDs diferentes del negocio Kroger con la dirección 3410 Gallatin Pike. En este bloque de código, 
 * voy a cambiar los IDs de los comentarios para que todos sean el mismo. */

BEGIN;
/* Actualizo los IDs de los comentarios para que sean iguales */
UPDATE review
SET review_id = 'BMcyBSKVkaCfKqz-STbvrw'
WHERE business_id IN (
    'U3J_imHxyCx3hTLZprLPkA',
    'YT1ZJrFHgwbeZvzOqSe1LA'
);

/* Ahora eliminaré los negocios duplicados de la tabla "business" */
DELETE FROM business
WHERE name = 'Kroger'
  AND address = '3410 Gallatin Pike'
  AND business_id <> 'BMcyBSKVkaCfKqz-STbvrw';

COMMIT;

/* Tenemos tres IDs diferentes del negocio XpresSpa con la dirección 8000 Essington Ave. En este bloque de código, 
 * voy a cambiar los IDs de los comentarios para que todos sean el mismo. */

BEGIN;
/* Actualizo los IDs de los comentarios para que sean iguales */
UPDATE review
SET review_id = 'iaW_PbJwEWq5lm06KFxa0g'
WHERE business_id IN (
    '0fGD3Ea30DywMORW6vD2Yw',
    'qMlco2xbB0h9CTMQxazfuQ'
);

/* Ahora eliminaré los negocios duplicados de la tabla "business" */
DELETE FROM business
WHERE name = 'XpresSpa'
  AND address = '8000 Essington Ave'
  AND business_id <> 'iaW_PbJwEWq5lm06KFxa0g';

COMMIT;

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


/*tabla checkin*/
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

