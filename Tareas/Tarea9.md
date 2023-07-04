# Usa lo aprendido hasta ahora para crear al menos dos funciones o procedimientos almacenados que calculen alguno de los siguientes resultados (o equivalentes):
- Dataset utilizado  [audio_features](https://github.com/fer98morales/BDR/blob/master/Tareas/Tarea9.sql)
- [Pearson Correlation Coefficient by Hand](https://www.statology.org/correlation-coefficient-by-hand/)

> Algunas de las características incluidas en el dataset de Spotify son el nombre del artista, el título de la canción, el género, la duración de la canción, la popularidad, la energía, la valencia, el tempo, el tono, el lenguaje, el modo y muchas otras características relacionadas con el contenido musical.

## Correlación entre dos conjuntos de datos
Pensaba que seria interesante buscar alguna correlacion entre lo bailable que es una cancion y su popularidad.

``` postgresql
-- Creamos o reemplazamos una función llamada calcular_correlacion que toma dos arreglos de tipo FLOAT como parámetros y devuelve un valor FLOAT.
CREATE OR REPLACE FUNCTION calcular_correlacion(datax FLOAT[], datay FLOAT[])
RETURNS FLOAT AS
$$
DECLARE
    n INT;
   	µx FLOAT;
   	µy FLOAT;
    sumProducts FLOAT;
    sumSquares1 FLOAT;
    sumSquares2 FLOAT;
BEGIN
    -- Obtenemos la longitud de los arreglos
    n := array_length(datax, 1);
   	µx := 0;
   	µy := 0;
    sumProducts := 0;
    sumSquares1 := 0;
    sumSquares2 := 0;
    
    -- Calculamos la suma de los elementos en los arreglos
    FOR i IN 1..n LOOP
        µx := µx + datax[i]; -- Sumamos el elemento i del arreglo datax a la media de datax
        µy := µy + datay[i]; -- Sumamos el elemento i del arreglo datay a la media de datay
    END LOOP;

    -- Calculamos las medias (promedios)
    µx := µx / n; -- Dividimos la suma de datax entre la longitud n para obtener la media de datax
    µy := µy / n; -- Dividimos la suma de datay entre la longitud n para obtener la media de datay

    -- Calculamos la suma de los productos de las desviaciones y las sumas de cuadrados
    FOR i IN 1..n LOOP
       	sumProducts := sumProducts + ((datax[i] - µx) * (datay[i] - µy));
        sumSquares1 := sumSquares1 + (datax[i] - µx)^2;
        sumSquares2 := sumSquares2 + (datay[i] - µy)^2;
    END LOOP;

    -- Devolvemos el resultado de la correlación
    RETURN sumProducts/(sqrt(sumSquares1)*sqrt(sumSquares2));
END;
$$
LANGUAGE plpgsql;

SELECT calcular_correlacion(ARRAY(SELECT popularity FROM audio_features), ARRAY(SELECT danceability FROM audio_features)) AS correlacion;
```
La correlación calculada indica que la relación lineal entre las variables es muy débil o nula.
|correlacion|
|-----------|
|0.002643091676709995|

---

## Buscar canciones por palabras clave en el nombre de la canción, el nombre del artista o el género.
Creí que sería útil contar con un motor de búsqueda de canciones que permitiera buscar fácilmente canciones utilizando parte del nombre de la canción, el nombre del artista o el género musical.

``` postgresql
-- Creamos o reemplazamos una función llamada buscar_por_palabra_clave que toma una palabra clave de tipo VARCHAR como parámetro y devuelve una tabla con columnas title, artist y genres, todas de tipo VARCHAR.
CREATE OR REPLACE FUNCTION buscar_por_palabra_clave(palabra_clave VARCHAR)
RETURNS TABLE (title VARCHAR, artist VARCHAR, genres VARCHAR) AS
$$
BEGIN
    -- Ejecutamos una consulta que busca en la tabla audio_features los registros que coincidan con la palabra clave en el título, artista o género.
    RETURN QUERY
    SELECT audio_features.title, audio_features.artist, audio_features.genres
    FROM audio_features
    WHERE LOWER(audio_features.title) LIKE LOWER('%' || palabra_clave || '%')
       OR LOWER(audio_features.artist) LIKE LOWER('%' || palabra_clave || '%')
       OR LOWER(audio_features.genres) LIKE LOWER('%' || palabra_clave || '%');
END;
$$
LANGUAGE plpgsql;

SELECT * FROM buscar_por_palabra_clave('pop');

```
|title|artist|genres|
|-----|------|------|
|Copa Vac�a|Shakira|colombian pop|
|MOJABI GHOST|Tainy|pop reggaeton|
|vampire|Olivia Rodrigo|pop|
|La Nena|Becky G|latin pop|
|D�jalo En Visto|Piso 21|colombian pop|
|BILLBOARD|Ovy On The Drums|colombian pop|
|Speed Drive (From Barbie The Album)|Charli XCX|art pop|
|Big Hammer|James Blake|art pop|
|Heartquake|L'Imp�ratrice|french indie pop|
|Don't Think Twice - Edit|Rita Ora|dance pop|
|GRL GVNG|XG|k-pop girl group|
|El Primero|Lasso|pop venezolano|
|Suficiente|Leonel Garc�a|latin pop|
|Propiedad Privada|Paulina Rubio|latin arena pop|
|As� De Simple|Nicole Favre|pop peruano|
|One Like You|LP|la pop|
|MOJABI GHOST|Tainy|pop reggaeton|
|Classy 101|Feid|colombian pop|
|Chanel|Becky G|latin pop|
|Copa Vac�a|Shakira|colombian pop|
|MOJABI GHOST|Tainy|pop reggaeton|
|vampire|Olivia Rodrigo|pop|
|La Nena|Becky G|latin pop|
|D�jalo En Visto|Piso 21|colombian pop|
|BILLBOARD|Ovy On The Drums|colombian pop|
|Speed Drive (From Barbie The Album)|Charli XCX|art pop|
|Big Hammer|James Blake|art pop|
|Heartquake|L'Imp�ratrice|french indie pop|
|Don't Think Twice - Edit|Rita Ora|dance pop|
|GRL GVNG|XG|k-pop girl group|
|El Primero|Lasso|pop venezolano|
|Suficiente|Leonel Garc�a|latin pop|
|Propiedad Privada|Paulina Rubio|latin arena pop|
|As� De Simple|Nicole Favre|pop peruano|
|One Like You|LP|la pop|
|MOJABI GHOST|Tainy|pop reggaeton|
|Classy 101|Feid|colombian pop|
|Chanel|Becky G|latin pop|

---