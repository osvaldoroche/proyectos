USE comercio_exterior;

# Todas las tablas del modelo

SELECT * FROM intercambios;
SELECT * FROM paises;
SELECT * FROM productos;
SELECT * FROM tipos_comercio;
SELECT * FROM medidas;

-- LLENADO DE LA TABLA intercambios:

# Arreglar nombres 

SELECT * FROM intercambios;
SELECT count(*) FROM intercambios; 
SELECT * FROM productos;
SELECT * FROM tipos_comercio;

ALTER TABLE intercambios CHANGE producto producto_id INT UNSIGNED;
ALTER TABLE intercambios CHANGE medida medida_id INT;
ALTER TABLE intercambios CHANGE pais pais_id INT UNSIGNED;

ALTER TABLE intercambios 
ADD CONSTRAINT pk_productos 
FOREIGN KEY (producto_id) 
REFERENCES productos(producto_id)
ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE intercambios DROP FOREIGN KEY intercambios_ibfk_1;

# Insertar datos a la tabla desde R


-- RESPONDER LAS PREGUNTAS

# 1. Base de datos a ingresar en Power BI

CREATE VIEW intercambiosAnual AS
SELECT * FROM intercambios WHERE fecha >= '2022-01-01';

# 1. ¿Cuáles son los 10 principales países a donde van las exportaciones salvadoreñas?

CREATE VIEW sociosExportacion AS
	SELECT fecha, pais_id, medida_id, SUM(valor) AS valor
	FROM intercambios 
	WHERE tipo_comercio = 1
	GROUP BY fecha, pais_id, medida_id
	ORDER BY fecha;

# 2. ¿Cuáles son los 10 principales países de donde provienen las importaciones?

CREATE VIEW sociosImportacion AS
	SELECT fecha, pais_id, medida_id, SUM(valor) AS valor
	FROM intercambios i
	WHERE tipo_comercio = 2
	GROUP BY fecha, pais_id, medida_id 
	ORDER BY fecha;

# 3. ¿Cuál es la tasa de crecimiento anual, mensual, trimestral de las exportaciones y exportaciones?

CREATE VIEW valorMensualTotal AS
	SELECT fecha, tipo_comercio, medida_id, SUM(valor) AS valor
	FROM intercambios i
	GROUP BY fecha, tipo_comercio, medida_id
	ORDER BY fecha;

# 4. ¿Cuántos productos se exportan e importan por mes y año y cuánto han crecido?

CREATE VIEW productosPorMes AS
	SELECT fecha, tipo_comercio, COUNT(DISTINCT(producto_id)) AS cantidad
	FROM intercambios 
	WHERE valor > 0 AND tipo_comercio IN (1,2)
	GROUP BY fecha, tipo_comercio 
	ORDER BY fecha;


# 5. ¿Cuáles son los principales productos exportados e importados?(EN PB)

SELECT fecha, producto_id, SUM(valor) AS valor
FROM intercambiosanual 
GROUP BY fecha, producto_id
ORDER BY valor DESC;


SELECT * FROM tasacrecimiento;
SELECT * FROM productospormes;














