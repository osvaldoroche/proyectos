

-- CREAR LAS BASES DE DATOS

CREATE DATABASE netflix_analysis;
USE netflix_analysis;

-- CREAR LAS TABLAS

SELECT * FROM titles
WHERE id LIKE '%t%';

SELECT * FROM titles ;
SELECT * FROM credits;

-- CREAR STORED PROCEDURE PARA VER TABLA

# Tabla títulos
DELIMITER //
CREATE PROCEDURE sp_titulos()
BEGIN
	SELECT * FROM titles;
END //
DELIMITER ;


# Tabla de autores
DELIMITER //
CREATE PROCEDURE sp_autores()
BEGIN
	SELECT * FROM credits;
END //
DELIMITER ;

CALL sp_titulos(); 
CALL sp_autores(); 

-- ARREGLAR TABLAS

# 1. Arreglar tipo de datos de release_year

ALTER TABLE titles MODIFY COLUMN release_year YEAR;

-- RESOLVER EL PROBLEMA

DESCRIBE titles;
DESCRIBE credits;

/*
1. ¿Qué películas y programas de Netflix se ubicaron entre 
los 10 primeros y los 10 últimos según sus puntuaciones de IMDB? 
 * */


# 10 Mejores programas.

SELECT release_year, title, imdb_score 
FROM titles
WHERE imdb_score IS NOT NULL AND TYPE = 'SHOW'
ORDER BY imdb_score DESC LIMIT 10;

# 10 Peores programas

SELECT release_year, title, imdb_score 
FROM titles
WHERE imdb_score IS NOT NULL AND TYPE = 'SHOW'
ORDER BY imdb_score ASC 
LIMIT 10;

# 10 Mejores Películas 

SELECT release_year, title, imdb_score 
FROM titles
WHERE imdb_score IS NOT NULL AND TYPE = 'MOVIE'
ORDER BY imdb_score DESC LIMIT 10;

# 10 Peores Películas

SELECT release_year, title, imdb_score 
FROM titles
WHERE imdb_score IS NOT NULL AND TYPE = 'MOVIE'
ORDER BY imdb_score ASC LIMIT 10;

# 10 best shows and movies of 2015

SELECT release_year, title, imdb_score 
FROM titles
WHERE imdb_score IS NOT NULL AND release_year = 2015
ORDER BY imdb_score desc LIMIT 10; 

/*2. ¿Cuántas películas y programas se encuentran por cada década en la biblioteca de Netflix? */


# Total de Programas o peliculas 

SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade, type, count(*) AS number
FROM titles 
GROUP BY decade, `type` 
ORDER BY decade ASC;

# Total de programas y peliculas 

SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade, count(*) AS total_number
FROM titles 
GROUP BY decade 
ORDER BY decade ASC;

/* 3. ¿Cómo impactaron las certificaciones de edad en el conjunto de datos?*/

# Relación age con el promedio de títulos.
SELECT age_certification, 
	ROUND(AVG(imdb_score),2) AS avg_imdb
FROM titles
GROUP BY age_certification
ORDER BY avg_imdb DESC;

# Examinar la distribución de películas y programas según las certificaciones de edad.

SELECT age_certification, count(*) AS number_titles
FROM titles 
WHERE age_certification <> '' 
GROUP BY age_certification 
ORDER BY number_titles DESC;

/* 4. ¿Qué géneros son los más comunes?*/

# generos más comunes en general
SELECT genres, count(*) AS number
FROM titles
GROUP BY genres
ORDER BY number DESC;

# generos más comunes de películas
SELECT genres, count(*) AS number
FROM titles
WHERE `type` = 'MOVIE'
GROUP BY genres
ORDER BY number DESC;

# generos más comunes de programas
SELECT genres, count(*) AS number
FROM titles
WHERE `type` = 'SHOW'
GROUP BY genres
ORDER BY number DESC;

/* 5. Evolución de películas y shows por año*/

SELECT release_year, TYPE, count(TYPE)
FROM titles
GROUP BY release_year, type
ORDER BY release_year ASC;

/*6. Cuáles son los países que más producen películas y programas*/

SELECT production_countries, count(*) AS  number_titles
FROM titles 
GROUP BY production_countries
ORDER BY number_titles DESC; 

-- ANÁLISIS DE LOS AUTORES Y CRÉDITOS

CALL sp_autores();

# 1. Cantidad de películas por autor

SELECT person_id, name, count(*) AS number_movies
FROM credits
GROUP BY person_id, name
ORDER BY number_movies DESC;

# 2. Películas escritas por un autor específico: Robert de Niro

SELECT id
FROM credits 
WHERE person_id = 3748;

# Dada una película específica (por título o identificador), 
# ¿puedes listar todos los autores que contribuyeron a esa película y sus roles?

SELECT person_id, name
FROM credits 
WHERE id = 'tm145608';

SELECT id, count(person_id) AS autors 
FROM credits 
WHERE id = 'tm145608';

# Cantidad de autores por películas

SELECT id, count(person_id) AS number_autors 
FROM credits 
GROUP BY id
ORDER BY number_autors DESC;

# ¿Puedes encontrar autores que tengan más de un alias en la tabla?

SELECT name, count(`character`) AS number_character
FROM credits 
GROUP BY name
HAVING number_character > 1;

-- ANÁLISIS CONJUNTO

CALL sp_autores();
CALL sp_titulos(); 

# Ver autores duplicados: No se pueden relacionar mientras hayan duplicados.

SELECT person_id, COUNT(*) duplicados
FROM credits 
GROUP BY person_id 
HAVING duplicados > 1;

SELECT COUNT(*) AS cantidad_duplicados
FROM (
	SELECT person_id, COUNT(*) duplicados
	FROM credits 
	GROUP BY person_id 
	HAVING duplicados > 1
	) AS duplicados;

# Ver peliculas duplicadas: No hay duplicados.

SELECT id, COUNT(*) duplicados
FROM titles  
GROUP BY id 
HAVING duplicados > 1;

# Relacionar tablas

ALTER TABLE titles ADD CONSTRAINT pk_titles PRIMARY KEY (id);

ALTER TABLE credits ADD CONSTRAINT fk_credits 
					FOREIGN KEY (id)
					REFERENCES titles(id)
					ON DELETE RESTRICT ON UPDATE CASCADE;

/* 1.  ¿Puedes obtener una lista de autores que se especializan en un género 
 particular de películas (por ejemplo, comedia, drama, acción, etc.)? */

# Cantidad de Películas por género protagonizadas por autor.
				
SELECT t.genres, c.name, COUNT(*) AS cantidad
FROM titles t 
INNER JOIN credits c ON t.id = c.id
GROUP BY genres, name
ORDER BY cantidad DESC;

-- PRESENTACIÓN DE RESULTADOS

# Armar archivo explicando resultados
# Pasarlo a Power BI
# Diseñar y modelar power BI


SELECT DISTINCT role
FROM credits;





