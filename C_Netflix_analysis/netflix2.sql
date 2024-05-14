
-- PROCESO ETL del Análisis

USE netflix_analysis;

CALL sp_titulos(); 
CALL sp_autores();

SELECT * FROM titles1;

-- CRAR LAS TABLAS

# 1. Renombrar tabla títulos original
ALTER TABLE titles RENAME titles1;

# 2. Crear tabla de roles
CREATE TABLE roles (
role_id INT AUTO_INCREMENT PRIMARY KEY,
role_name VARCHAR(10)
);

# 3. Crear la tabla autores

CREATE TABLE authors (
author_id INT PRIMARY KEY,
name VARCHAR(250),
role_id INT,
FOREIGN KEY (role_id)
	REFERENCES roles(role_id)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

# 4. Crear tabla de personajes

CREATE TABLE characters (
character_id INT AUTO_INCREMENT PRIMARY KEY,
`character` VARCHAR(250),
author_id INT,
FOREIGN KEY (author_id)
	REFERENCES authors(author_id)
	ON DELETE RESTRICT ON UPDATE CASCADE
);  

# 5. Crear tabla de certificación de edad

CREATE TABLE age_certification (
age_id INT AUTO_INCREMENT PRIMARY KEY,
age_name VARCHAR(50)
);

# 6. Crear tabla de generos

CREATE TABLE genres (
genre_id INT AUTO_INCREMENT PRIMARY KEY,
genre_name VARCHAR(250)
);

# 7. Crear tabla títulos

CREATE TABLE titles (
id_title VARCHAR(20) PRIMARY KEY,
title VARCHAR(250),
`type` VARCHAR(6), 
description TEXT,
character_id INT,
age_id INT,
genre_id INT,
release_year YEAR,
runtime INT,
seasons INT,
production_countries TEXT,
imdb_id VARCHAR(20),
imdb_score FLOAT,
imdb_votes INT,
tmdb_popularity FLOAT,
tmdb_score FLOAT,
FOREIGN KEY (age_id)
	REFERENCES age_certification(age_id)
	ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (genre_id)
	REFERENCES genres(genre_id)
	ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (character_id)
	REFERENCES characters(character_id)
	ON DELETE RESTRICT ON UPDATE CASCADE
);


-- AGREGAR DATOS A LAS TABLAS

# 1. Agregar datos a la tabla roles

SELECT * FROM roles;
CALL sp_autores(); 

## Mostrar datos que queremos ingresar.
SELECT DISTINCT `role` FROM credits;

## Ingresar los datos
INSERT INTO roles (role_name) 
SELECT DISTINCT `role`
FROM credits;

## Ver el resultado
SELECT * FROM roles;

# 2. Agregar datos a tabla autores.

SELECT * FROM authors;
CALL sp_autores();

## Mostrar datos que queremos ingresar eliminando duplicados.
SELECT person_id, name, roles
FROM (
	SELECT DISTINCT person_id, name, `role`,
	CASE
		WHEN `role` = 'ACTOR' THEN 1
		WHEN `role` = 'DIRECTOR' THEN 2
		ELSE NULL
	END AS roles
	FROM credits
) AS credits_new
WHERE person_id = 3308;

## crear llave primaria distinta.

SELECT DISTINCT person_id, name FROM credits WHERE person_id = 3308;


ALTER TABLE `characters` DROP FOREIGN KEY characters_ibfk_1;
ALTER TABLE authors DROP PRIMARY KEY; 
ALTER TABLE authors ADD COLUMN person_id INT AUTO_INCREMENT PRIMARY KEY;
SELECT * FROM authors;
ALTER TABLE	`characters` DROP COLUMN author_id;
ALTER TABLE `characters` ADD COLUMN person_id INT;
ALTER TABLE `characters` ADD CONSTRAINT fk_character
						 FOREIGN KEY (person_id)
						 REFERENCES authors(person_id)
						 ON DELETE RESTRICT ON UPDATE CASCADE; 
SELECT * FROM `characters`;

## Ingresar los datos limpios

SELECT * FROM authors;

INSERT INTO authors (author_id, name, role_id)
SELECT person_id, name, roles
FROM (
	SELECT DISTINCT person_id, name, `role`,
	CASE
		WHEN `role` = 'ACTOR' THEN 1
		WHEN `role` = 'DIRECTOR' THEN 2
		ELSE NULL
	END AS roles
	FROM credits
) AS credits_new;


# 3. Agregar datos a tabla de personajes

SELECT * FROM `characters`;
DESCRIBE `characters`;
CALL sp_autores(); 

## Ver los resultados deseados: HAY 46,960 CHARACTERS NO REPETIDOS

SELECT c.`character`, a.person_id
FROM credits c
INNER JOIN authors a ON c.person_id = a.author_id
WHERE `character`;

SELECT COUNT(DISTINCT(`character`))
FROM credits;

## Cambiar tipo de datos de columna character

ALTER TABLE `characters` MODIFY COLUMN `character` TEXT;

## Ingresar los datos a la tabla Characters

INSERT INTO `characters` (`character`, person_id)
SELECT c.`character`, a.person_id
FROM credits c
INNER JOIN authors a ON c.person_id = a.author_id;

## Ver el resultados

SELECT * FROM `characters`;

# 4. Arreglar tabla Character por error (Antes que title)

## Eliminar llave foranea de tabla titulos y poner llave foranea en tabla personajes

DESCRIBE titles;
ALTER TABLE titles DROP FOREIGN KEY titles_ibfk_3;
ALTER TABLE titles DROP COLUMN character_id;
SELECT * FROM titles;

## Agregar clave foranea a tabla personajes

ALTER TABLE `characters` ADD COLUMN id_title VARCHAR(20);
ALTER TABLE `characters` 
ADD CONSTRAINT fk_titles 
FOREIGN KEY (id_title) 
REFERENCES titles(id_title)
ON DELETE RESTRICT ON UPDATE CASCADE;

## Borrar los registros

TRUNCATE TABLE `characters`;  
SELECT * FROM `characters`;
SELECT * FROM authors;

## Ver los registros nuevamente con id_title.

SELECT c.`character`,a.person_id, c.id
FROM credits c
INNER JOIN authors a ON c.person_id = a.author_id;

## Insertar los registros con id_title

INSERT INTO `characters` (`character`, person_id, id_title)
SELECT c.`character`, a.person_id, c.id 
FROM credits c
INNER JOIN authors a ON c.person_id = a.author_id;

# 5. Agregar datos a tabla de certificación de edad

SELECT * FROM age_certification;
DESCRIBE age_certification;
SELECT * FROM titles1;

## Ver el resultado deseado

SELECT DISTINCT age_certification
FROM titles1
WHERE age_certification <> '';

## Ingresar datos

INSERT INTO age_certification (age_name)
SELECT DISTINCT age_certification
FROM titles1
WHERE age_certification <> '';

## Ver resultado
SELECT * FROM age_certification;

# 6. Agregar datos a tabla géneros

SELECT * FROM genres;

## Ver resultado deseado

SELECT DISTINCT genres
FROM titles1;

## Ingresar datos a la tabla

INSERT INTO genres (genre_name)
SELECT DISTINCT genres
FROM titles1;

## Ver resultado

SELECT * FROM genres;

# 7. Agregar datos a la tabla de Títulos

CALL sp_titulos();
CALL sp_autores(); 
SELECT * FROM titles1 t;
SELECT * FROM authors a;
SELECT * FROM titles t;
SELECT * FROM `characters` c;
SELECT * FROM age_certification ac;
SELECT * FROM genres g;

## Ver resultados esperados


SELECT id, title,`type`, description,age_id,genre_id,release_year,
	   runtime, seasons, production_countries, imdb_id, imdb_score, imdb_votes,
	   tmdb_popularity, tmdb_score
FROM ( SELECT t.id, t.title, t.`type`, t.description, t.age_certification, ac.age_id, t.genres, g.genre_id, t.release_year,
	   t.runtime, t.seasons, t.production_countries, t.imdb_id, t.imdb_score, t.imdb_votes,
	   t.tmdb_popularity, t.tmdb_score
	   FROM titles1 t 
	   INNER JOIN age_certification ac ON t.age_certification = ac.age_name 
	   INNER JOIN genres g ON t.genres = g.genre_name) AS new_titles;

## Actualizar algunos elementos

SELECT id,age_certification
FROM titles1
WHERE age_certification = '';

UPDATE titles1 
SET age_certification = 'SC' 
WHERE age_certification = NULL;

UPDATE titles1 
SET age_certification = 'SC'
WHERE age_certification IS NULL;

UPDATE age_certification 
SET age_name = 'SC'
WHERE age_name IS NULL;

UPDATE titles1
SET imdb_id = NULL 
WHERE imdb_id = '';

## Insertar a tabla titles

INSERT INTO titles 
SELECT id, title,`type`, description,age_id,genre_id,release_year,
	   runtime, seasons, production_countries, imdb_id, imdb_score, imdb_votes,
	   tmdb_popularity, tmdb_score
FROM ( SELECT t.id, t.title, t.`type`, t.description, t.age_certification, ac.age_id, t.genres, g.genre_id, t.release_year,
	   t.runtime, t.seasons, t.production_countries, t.imdb_id, t.imdb_score, t.imdb_votes,
	   t.tmdb_popularity, t.tmdb_score
	   FROM titles1 t 
	   INNER JOIN age_certification ac ON t.age_certification = ac.age_name 
	   INNER JOIN genres g ON t.genres = g.genre_name) AS new_titles;


## Ver el resultado
	  
SELECT * FROM titles;

# Conectar a Power BI


-- RESPONDER PREGUNTAS

# Mejores peliculas

SELECT release_year, title
FROM titles 
ORDER BY imdb_score DESC;

USE netflix_analysis;

/*
1. ¿Qué películas y programas de Netflix se ubicaron entre 
los 10 primeros y los 10 últimos según sus puntuaciones de IMDB? 
 * */

CREATE VIEW mejores_peliculas AS
SELECT title, imdb_score AS score
FROM titles t 
WHERE `type` = 'MOVIE'
ORDER BY imdb_score DESC
LIMIT 10;

CREATE VIEW peores_peliculas AS
SELECT title, imdb_score AS score 
FROM titles t 
WHERE `type` = 'MOVIE' AND imdb_score IS NOT NULL
ORDER BY imdb_score ASC
LIMIT 10;

CREATE VIEW mejores_programas AS
SELECT title, imdb_score AS score 
FROM titles t 
WHERE `type` = 'SHOW' AND imdb_score IS NOT NULL
ORDER BY imdb_score DESC
LIMIT 10;

CREATE VIEW peores_programas AS
SELECT title, imdb_score AS score 
FROM titles t 
WHERE `type` = 'SHOW' AND imdb_score IS NOT NULL
ORDER BY imdb_score ASC
LIMIT 10;

/*2. ¿Cuántas películas y programas se encuentran por cada década en la biblioteca de Netflix?*/

CREATE VIEW programas_decada AS
SELECT concat(floor(release_year / 10) * 10, 's') AS decade, `type`, count(*) AS number
FROM titles 
GROUP BY decade, `type`
ORDER BY decade ASC;

/* 3. ¿Cómo impactaron las certificaciones de edad en el conjunto de datos?*/

CREATE VIEW relacion_certificaciones AS
SELECT ac.age_name, t.`type`, count(*)  AS cantidad
FROM titles t 
INNER JOIN age_certification ac ON ac.age_id = t.age_id 
GROUP BY age_name, `type`
ORDER BY cantidad DESC;

/* 4. ¿Qué géneros son los más comunes?*/

CREATE VIEW generos AS
SELECT g.genre_name ,count(*) AS number_gender
FROM titles t 
INNER JOIN genres g ON g.genre_id = t.genre_id 
GROUP BY genre_name
ORDER BY number_gender DESC
LIMIT 10;

/* 5. Evolución de películas y shows por año*/

CREATE VIEW evolution AS
SELECT release_year, TYPE, count(*) numbers
FROM titles t 
GROUP BY release_year, `type` 
ORDER BY release_year ASC;

SELECT * FROM relacion_certificaciones ;



















