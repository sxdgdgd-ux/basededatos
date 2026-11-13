/* Ejemplo Conversion de texto a numero 
-- Convertir string a entero (Resultado : 123)
-- Nota : Entre "CAST" y el "("no puede haber ningún espacio)*/

SELECT CAST ('123' AS SIGNED) AS numero;

-- Convertir string a decimal (resultad : 45.67)
SELECT CAST('46.67' AS DECIMAL (10,2)) AS precio;

-- Conversion de numero a texto

-- Numero a string (resultado : '12345')
SELECT CAST(12345 AS CHAR) AS codigo;

-- Con longitud especifica (resultado :'789')
SELECT CAST(789 AS CHAR(10)) AS codigo_fijo;

-----------------------------------------------------

-- Conversión de fechas
-- String a fecha
SELECT CAST('2025-10-13' AS DATE) AS fecha;

-- Fecha a string
SELECT CAST(NOW() AS CHAR) AS fecha_texto;

-- Extraer solo la fecha de un datetime (resultado : 2027-09-03)
SELECT CAST('2027-09-03 15:30:00' AS DATE) AS solo_fecha;

------------------------------------------------------

