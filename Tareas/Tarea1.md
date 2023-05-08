# Descripción del dataset: Spotify Music Data
[Top Spotify songs from 2010-2019 - BY YEAR](https://www.kaggle.com/datasets/leonardopena/top-spotify-songs-from-20102019-by-year)

Un cliente desea saber qué hace una canción popular. Contamos con un dataset que contiene información sobre 600 canciones que fueron consideradas las más populares del año por Billboard, durante el periodo de 2010 a 2019. Las variables fueron obtenidas de Spotify, y proporciona datos interesantes sobre cada canción, como el tempo en beats por minuto, la cantidad de palabras habladas, el volumen o "loudness" y la energía de la canción. Estos datos pueden ser útiles para comprender mejor las características que hacen que una canción sea popular y cómo los usuarios interactúan con ella.

| Variable | Definición | Tipo|
|------|-----|--------|
| title | El título de la canción | String|
| artist | El artista que interpreta la canción | String|
| top genre | El género de música de la canción | String|
| year | El año en que la canción estuvo en el Billboard | Integer|
| bpm | Beats por minuto: el tempo de la canción | Integer|
| nrgy | La energía de la canción: valores más altos significan más energía (rápido, fuerte) | Integer|
| dnce | La capacidad de baile de la canción: valores más altos significan que es más fácil de bailar | Integer|
| dB | Decibelios: el volumen de la canción | Integer|
| live | Vivo: la probabilidad de que la canción se haya grabado con una audiencia en vivo | Integer|
| val | Valencia: valores más altos significan un sonido más positivo (feliz, alegre) | Integer|
| dur | La duración de la canción | Integer
| acous | Acústica de la canción: la probabilidad de que la canción sea acústica | Integer|
| spch | Habla: valores más altos significan más palabras habladas en la canción | Integer|
| pop | Popularidad: valores más altos significan mayor popularidad | Integer|

## Posibles relaciones
- El género musical puede influir en las características de la canción, como el tempo y la energía.
- La popularidad de una canción puede verse afectada por su energía, capacidad de baile y probabilidad de que se hablen palabras en la canción.
- La acústica de la canción y la cantidad de palabras habladas en la canción pueden estar relacionadas entre sí, ya que las canciones más acústicas pueden tener menos palabras habladas y viceversa.

# Investigacion SGBD: PostgreSQL
PostgreSQL es una base de datos relacional de código abierto que se originó en la Universidad de California en Berkeley en la década de 1980. 
Originalmente conocida como POSTGRES. En 1996 fue renombrada a PostgreSQL para reflejar su soporte de SQL. Es compatible con la mayoría de los sistemas operativos, incluyendo Linux, macOS y Windows.

PostgreSQL ofrece funciones para ayudar a los desarrolladores y administradores de bases de datos a crear aplicaciones, proteger la integridad de los datos y administrar conjuntos de datos grandes y pequeños. Es conocido por su arquitectura, seguridad, escabilidad y estabilidad, además de su capacidad para manejar cargas de trabajo complejas. 

PostgreSQL es conocido por ser un SGBD extremadamente potente y escalable. Es capaz de manejar grandes conjuntos de datos y soporta características avanzadas de SQL, como subconsultas anidadas, tipos de datos personalizados, vistas materializadas y más. También es un SGBD orientado a objetos y ofrece soporte para funciones y procedimientos almacenados en diferentes lenguajes de programación, como PL/SQL, PL/Python y PL/Perl. En términos de seguridad, PostgreSQL es conocido por ser uno de los SGBD más seguros disponibles en el mercado. Ofrece características avanzadas de seguridad, como autenticación de dos factores, encriptación de datos en reposo y encriptación de conexiones SSL/TLS. 

Entre las características que lo diferencian de otros sistemas de gestión de bases de datos se encuentran la capacidad de trabajar fácilmente con los resultados de las operaciones INSERT, UPDATE y DELETE utilizando Common Table Expressions (CTEs), la amplia variedad de tipos de datos y funciones útiles para aplicaciones que trabajan con datos complejos, como tipos de rangos, arreglos, jsonb (9.4), hstore, funciones de expresiones regulares, entre otros, y la capacidad de almacenar y buscar coordenadas geográficas de latitud y longitud.

Referencias: 

[Wikipedia. (2023, May 6). PostgreSQL. In Wikipedia. Retrieved May 7, 2023](https://en.wikipedia.org/wiki/PostgreSQL)

[PostgreSQL Global Development Group. (n.d.). About PostgreSQL](https://www.postgresql.org/about/)

[Reddit. (2014, July 17). Why use PostgreSQL? [Online forum post]](https://www.reddit.com/r/PostgreSQL/comments/2ayilx/why_use_postgresql/)

[Reddit. (2012, July 28). Convince me to choose PostgreSQL over MySQL. [Online forum post]](https://www.reddit.com/r/PostgreSQL/comments/xblooo/convince_me_to_choose_postgresql_over_mysql/)

