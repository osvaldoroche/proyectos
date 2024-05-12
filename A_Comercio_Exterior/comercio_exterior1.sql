

-- CREACIÓN DE LA BASE DE DATOS

CREATE DATABASE comercio_exterior;
SHOW DATABASES;
USE comercio_exterior;


-- CREACIÓN DE LAS TABLAS

SHOW TABLES;

CREATE TABLE productos(
producto_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre TEXT,
sac CHAR(10) UNIQUE
);


CREATE TABLE tipos_comercio(
tipo_comercio_id INT PRIMARY KEY,
nombre VARCHAR(11)
);

CREATE TABLE medidas(
medida_id INT PRIMARY KEY,
nombre VARCHAR(9)
);

CREATE TABLE paises(
pais_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
nomenclatura CHAR(3) UNIQUE
);

CREATE TABLE intercambios(
intercambio_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
producto INT UNSIGNED,
tipo_comercio INT,
medida INT,
pais INT UNSIGNED,
valor FLOAT,
fecha DATE,
FOREIGN KEY (producto)
	REFERENCES productos(producto_id)
	ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (tipo_comercio)
	REFERENCES tipos_comercio(tipo_comercio_id)
	ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (medida)
	REFERENCES medidas(medida_id)
	ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (pais)
	REFERENCES paises(pais_id)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

SELECT * FROM productos;
SELECT * FROM tipos_comercio;
SELECT * FROM medidas;
SELECT * FROM paises;
SELECT * FROM intercambios;

-- INSERTAR A LAS TABLAS CATALOGO: Tipo de comercio y Medidas

ALTER TABLE medidas MODIFY nombre VARCHAR(10);
ALTER TABLE tipos_comercio MODIFY nombre VARCHAR(15);

# Insertar en tipo de comercio
INSERT INTO tipos_comercio VALUES 
(1,"Exportación"), 
(2,"Importación"), 
(3,"Saldo");

UPDATE tipos_comercio SET nombre = "saldo_comercial" WHERE tipo_comercio_id = 3;

# Insertar en medidas
INSERT INTO medidas VALUES
(1, "Dólares"),
(2, "Kilogramos");


-- ARREGLAR TABLA DE PRODUCTOS E INTERCAMBIOS PORQUE NO VAN A LLEVAR EL NOMBRE DEL PRODUCTO

ALTER TABLE productos DROP COLUMN nombre;
ALTER TABLE intercambios ADD COLUMN nombre TEXT;

-- TABLAS CON DATOS COMPLETADOS

SELECT * FROM productos;
SELECT * FROM medidas;
SELECT * FROM tipos_comercio;
SELECT * FROM paises;

SHOW TABLES;

-- BORRAR NOMENCLATURA A PAISES POR TIPO DE DATO DEL BCR

SELECT * FROM paises;
ALTER TABLE paises DROP COLUMN nomenclatura;
ALTER TABLE paises MODIFY nombre VARCHAR(60);
ALTER TABLE intercambios DROP COLUMN nombre;

-- IMPORTAR DATOS A TABLAS PAÍSES Y PRODUTOS












