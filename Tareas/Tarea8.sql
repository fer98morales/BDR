DROP VIEW IF EXISTS business_reviews;

CREATE OR REPLACE VIEW business_reviews AS
SELECT b.business_id, b.name AS business_name, b.category, r.review_id, r.stars, r.review_text, u.user_id, u.name AS user_name
FROM business b
LEFT JOIN review r ON b.business_id = r.business_id
JOIN "user" u ON r.user_id = u.user_id;

DROP VIEW IF EXISTS user_reviews;
CREATE OR REPLACE VIEW user_reviews AS
SELECT u.user_id, u.name AS user_name, r.review_id, r.stars, r.review_text, b.business_id, b.name AS business_name
FROM "user" u
LEFT JOIN review r ON u.user_id = r.user_id
RIGHT JOIN business b ON r.business_id = b.business_id
WHERE u.user_id IN (SELECT user_id FROM review);

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
