
USE netflix_analysis;

# Tabla de autores
DELIMITER //
CREATE PROCEDURE sp_autores()
BEGIN
	SELECT * FROM credits;
END //
DELIMITER ;
