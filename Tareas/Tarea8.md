# Composicion, vistas y disparadores
- [Archivo SQL](https://github.com/fer98morales/BDR/blob/master/Tareas/Tarea8.sql)

Referencias:
- [PostgreSQL CREATE TRIGGER](https://www.postgresqltutorial.com/postgresql-triggers/creating-first-trigger-postgresql/)
---
## Crear vistas (VIEW)
### business_reviews
``` postgresql
CREATE OR REPLACE VIEW business_reviews AS
SELECT b.business_id, b.name AS business_name, b.category, r.review_id, r.stars, r.review_text, u.user_id, u.name AS user_name
FROM business b
LEFT JOIN review r ON b.business_id = r.business_id
JOIN "user" u ON r.user_id = u.user_id;
```
Esta vista combina información relevante de negocios, reseñas y usuarios en una única vista. Proporciona una visión completa de las reseñas asociadas a cada negocio, incluyendo detalles sobre el negocio, la reseña y el usuario que la realizó.
La vista utiliza un LEFT JOIN para asegurarse de que todos los negocios sean incluidos, incluso si no tienen reseñas asociadas. Además, utiliza JOIN para combinar la información de usuario correspondiente a cada reseña.

Al utilizar esta vista, la compañía puede obtener una visión completa de las reseñas realizadas en relación con sus negocios, incluyendo los detalles de los negocios, las calificaciones de las reseñas, el texto de las reseñas y los nombres de los usuarios que las realizaron. Esto puede ser útil para el análisis de la satisfacción del cliente, la identificación de patrones o tendencias en las reseñas y la toma de decisiones basada en la retroalimentación de los usuarios.

### user_reviews 
``` postgresql
CREATE OR REPLACE VIEW user_reviews AS
SELECT u.user_id, u.name AS user_name, r.review_id, r.stars, r.review_text, b.business_id, b.name AS business_name
FROM "user" u
LEFT JOIN review r ON u.user_id = r.user_id
RIGHT JOIN business b ON r.business_id = b.business_id
WHERE u.user_id IN (SELECT user_id FROM review);
```
En esta vista, se utiliza un RIGHT JOIN para combinar la información de los usuarios, las reseñas y los negocios. Además, se incluye una subconsulta para filtrar únicamente los usuarios que tienen reseñas asociadas.

Al utilizar esta vista, la compañía puede obtener una lista de usuarios que han realizado reseñas, junto con los detalles de las reseñas y los negocios asociados. Esto puede ser útil para analizar el comportamiento de los usuarios, identificar a los usuarios más activos en términos de reseñas y comprender qué negocios están recibiendo más feedback de los usuarios.

## Crear disparador (TRIGGER) de inserción, actualización o eliminación.

``` postgresql
-- Definir una función que se ejecutará después de insertar una nueva fila en la tabla "review"
CREATE OR REPLACE FUNCTION update_review_count()
  RETURNS TRIGGER AS
$$
DECLARE
    avg_stars numeric;
BEGIN
-- Incrementar el contador de reseñas en la tabla "user" para el usuario asociado a la nueva reseña
    UPDATE "user" SET review_count = review_count + 1 WHERE user_id = NEW.user_id;

 -- Incrementar el contador de reseñas en la tabla "business" para el negocio asociado a la nueva reseña
    UPDATE business SET review_count = review_count + 1 WHERE business_id = NEW.business_id;

    SELECT ROUND(AVG(stars), 1) INTO avg_stars FROM review WHERE business_id = NEW.business_id;

-- Actualizar el valor del promedio de estrellas en la tabla "business"
    UPDATE business SET stars = avg_stars WHERE id = NEW.business_id;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- Crear el disparador que ejecutará la función después de insertar una nueva fila en la tabla "review"
CREATE TRIGGER increment_review_count
AFTER INSERT ON review
FOR EACH ROW
EXECUTE FUNCTION update_review_count();

```
> PostgreSQL proporciona una variable especial llamada NEW que hace referencia a la fila recién insertada.

Para implementar este trigger en PostgreSQL, se debe crear una función que realice las actualizaciones necesarias en las tablas "user" y "business" al insertar una nueva reseña en la tabla "review". Luego, se crea un trigger que invoque esta función después de cada INSERT en la tabla "review".

