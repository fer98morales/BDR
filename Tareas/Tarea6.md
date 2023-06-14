# Ejemplos de consultas

- ## Conteo de frecuencias o media: 
    Deseo conocer los 10 negocios con mayor numero de reseñas en el año 2021 para una campaña enfocada en aquellos negocios que atraen más usuarios.

    ``` postgresql
    SELECT b."name" AS business_name, count(r.review_id) AS Total_reviews, round(avg(r.stars),2) AS  avg_stars
    FROM review r
    LEFT JOIN business b ON b.business_id = r.business_id
    WHERE EXTRACT(YEAR FROM CAST(r."date" AS date)) = 2021
    GROUP BY b."name"
    ORDER BY count(r.review_id) DESC 
    LIMIT 10
    ```
    |name|total_reviews|avg_stars|
    |----|-------------|---------|
    |McDonald's|2450|1.49|
    |Chipotle Mexican Grill|1794|1.59|
    |Starbucks|1760|2.76|
    |Dunkin'|1431|1.75|
    |First Watch|1191|3.78|
    |Taco Bell|1187|1.73|
    |Chick-fil-A|996|2.62|
    |Wendy's|954|1.71|
    |Burger King|829|1.69|
    |Popeyes Louisiana Kitchen|807|1.69|

- ## Mínimos o máximos: 
    Ahora quiero saber la cantidad de días transcurridos entre el momento en que un usuario se une a la plataforma y realiza su primera reseña.
    ``` postgresql
    SELECT u.user_id ,u."name" , u.review_count , CAST(u.yelping_since AS date), F.first_review, F.last_review, (F.first_review - CAST(u.yelping_since AS date)) as Daysto_FirstReview, round((F.last_review - F.first_review)/365.25,2) as Years_Yelping 
    FROM "user" u 
    LEFT JOIN (
        SELECT user_id,min(CAST(r."date" AS date)) AS first_review , max(CAST(r."date" AS date)) AS last_review
        FROM review r
        GROUP BY user_id 
    ) AS F
    ON u.user_id = F.user_id
    ORDER BY u.review_count DESC 
    LIMIT 10
    ```

    |user_id|name|review_count|yelping_since|first_review|last_review|daysto_firstreview|years_yelping|
    |-------|----|------------|-------------|------------|-----------|------------------|-------------|
    |Hi10sGSZNxQH3NLyWSZ1oA|Fox|17473|2009-05-26|2010-12-01|2021-12-15|554|11.04|
    |8k3aO-mPeyhbR5HUucA5aA|Victor|16978|2007-12-08|2008-02-24|2020-04-08|78|12.12|
    |hWDybu_KvYLSdEFzGrniTw|Bruce|16567|2009-03-08|2010-08-29|2021-10-30|539|11.17|
    |RtGqdDBvvBCjcu5dUqwfzA|Shila|12868|2010-10-17|2013-04-11|2016-01-06|907|2.74|
    |P5bUL3Engv-2z6kKohB6qQ|Kim|9941|2006-05-31|2007-01-30|2015-04-24|244|8.23|
    |nmdkHL2JKFx55T3nq5VziA|Nijole|8363|2011-11-29|2012-08-22|2021-11-19|267|9.24|
    |bQCHF5rn5lMI9c5kEwCaNA|Vincent|8354|2012-03-18|2012-07-18|2021-12-15|122|9.41|
    |8RcEwGrFIgkt9WQ35E6SnQ|George|7738|2009-11-06|2010-01-02|2016-11-07|57|6.85|
    |Xwnf20FKuikiHcSpcEbpKQ|Kenneth|6766|2011-06-10|2015-04-12|2018-06-23|1402|3.20|
    |CxDOIDnH8gp9KXzpBHJYXw|Jennifer|6679|2009-11-09|2012-11-01|2019-03-08|1088|6.35|

- ## Cuantil cuyo resultado sea distinto a la mediana:
    Deseo saber cómo se distribuye el texto en las reseñas para hacer un análisis de qué tan detalladas son. La idea es que, entre más largas, más detalle deberían incluir.

    ``` postgresql
    SELECT u.user_id ,u."name" , u.review_count, Q.quartil_1, Q.quartil_2, Q.quartil_3
    FROM "user" u 
    LEFT JOIN (
        SELECT user_id,
        PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY LENGTH(text)) AS quartil_1,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY LENGTH(text)) AS quartil_2,
        PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY LENGTH(text)) AS quartil_3
        FROM review
        GROUP BY user_id
    ) AS Q
    ON u.user_id = Q.user_id
    ORDER BY u.review_count DESC 
    LIMIT 10
    ```

    |user_id|name|review_count|quartil_1|quartil_2|quartil_3|
    |-------|----|------------|---------|---------|---------|
    |Hi10sGSZNxQH3NLyWSZ1oA|Fox|17473|575|866|1540|
    |8k3aO-mPeyhbR5HUucA5aA|Victor|16978|467|503|616|
    |hWDybu_KvYLSdEFzGrniTw|Bruce|16567|407|560|815|
    |RtGqdDBvvBCjcu5dUqwfzA|Shila|12868|186|223|807|
    |P5bUL3Engv-2z6kKohB6qQ|Kim|9941|313|406|641|
    |nmdkHL2JKFx55T3nq5VziA|Nijole|8363|318|405|555|
    |bQCHF5rn5lMI9c5kEwCaNA|Vincent|8354|639|821|1049|
    |8RcEwGrFIgkt9WQ35E6SnQ|George|7738|91|164|298|
    |Xwnf20FKuikiHcSpcEbpKQ|Kenneth|6766|231|375|445|
    |CxDOIDnH8gp9KXzpBHJYXw|Jennifer|6679|428|587|764|

- ## Moda:
    Deseo saber la categoría a la que más pertenecen los negocios registrados.

    ``` postgresql
    SELECT categories, COUNT(*) AS frequency
    FROM business
    GROUP BY categories
    HAVING COUNT(*) = (
        SELECT MAX(count)
        FROM (
            SELECT categories, COUNT(*) AS count
            FROM business
            GROUP BY categories
        ) AS M
    );
    ```
    |categories|frequency|
    |----------|---------|
    |Beauty & Spas, Nail Salons|1012|

- ## Reporta hallazgos, dificultades, implementación de soluciones encontradas en línea, etc... 
    ### Hallazgos
    -  DBeaver permite copiar el resultado de una consulta directamente en formato Markdown utilizando la opción "Advanced Copy". Esto resultó útil para presentar los resultados de las consultas en este informe.
    - Desconocia la función PERCENTILE_DISC() en PostgreSQL, que simplificó el cálculo de los cuartiles en la consulta correspondiente. Esta función evitó la necesidad de ordenar los datos y utilizar la fórmula manual de cálculo de los cuartiles.

    ### Dificultades
    - No contar con la función Year() en PostgreSQL, a diferencia de SQL Server. Para extraer el año de una fecha, se utilizó la función EXTRACT() en combinación con el tipo de dato CAST().
    - Otro desafío encontrado fue la falta de la función DATEDIFF() en PostgreSQL, que permite calcular la diferencia entre dos fechas en días, meses o años. Sin embargo, se resolvió esta dificultad dividiendo la diferencia entre las fechas en días entre 365.25, para tener en cuenta los años bisiestos.
    
    ### Implementación de soluciones encontradas en línea
    - Para solucionar las dificultades encontradas, busqué en sitios como Stack Overflow la equivalencia de las funciones que conocía en SQL Server a PostgreSQL. También fue útil utilizar sitios como W3Schools para revisar la sintaxis de mi código.