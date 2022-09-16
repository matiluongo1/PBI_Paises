
--creacion de tabla

IF OBJECT_ID('Raw_Data_GDP') IS NOT NULL DROP TABLE Raw_Data_GDP
CREATE TABLE Raw_Data_GDP
	(DEMO_IND NVARCHAR(200),
	Indicator NVARCHAR(200),
	[Locacion] NVARCHAR(200),
	Pais NVARCHAR(200),
	Año NVARCHAR(200),
	Valor FLOAT,
	bandera_codigo NVARCHAR(200),
	Banderas NVARCHAR(200)
	)

-- importación de datos

BULK INSERT Raw_Data_GDP
FROM 'C:\Users\Matías\Desktop\Power-BI-raw-data-master\SQL to Power BI\gdp_raw_data.csv'
WITH (FORMAT = 'CSV');

--SELECT * FROM Raw_Data_GDP

--creamos la vista que necesitamos

--DROP VIEW GDP_Excel_Input

CREATE VIEW GDP_Excel_Input AS

SELECT a.*, b.GDP_Per_Capita FROM

	(SELECT Pais, Año AS Año_Nro, Valor AS GDP_Valor FROM Raw_Data_GDP
	WHERE Indicator = 'GDP (current US$)') a

	LEFT JOIN
	(SELECT Pais, Año AS Año_Nro, Valor AS GDP_Per_Capita FROM Raw_Data_GDP
	WHERE Indicator = 'GDP per capita (current US$)') b
	ON a.Pais = b.Pais AND a.Año_Nro = b.Año_Nro

--SELECT * FROM GDP_Excel_Input

-- Creacion Stored Procedure

CREATE PROCEDURE GDP_Excel_Input_Monthly AS 

IF OBJECT_ID('Raw_Data_GDP') IS NOT NULL DROP TABLE Raw_Data_GDP
CREATE TABLE Raw_Data_GDP
	(DEMO_IND NVARCHAR(200),
	Indicator NVARCHAR(200),
	[Locacion] NVARCHAR(200),
	Pais NVARCHAR(200),
	Año NVARCHAR(200),
	Valor FLOAT,
	bandera_codigo NVARCHAR(200),
	Banderas NVARCHAR(200)
	)

BULK INSERT Raw_Data_GDP
FROM 'C:\Users\Matías\Desktop\Power-BI-raw-data-master\SQL to Power BI\gdp_raw_data.csv'
WITH (FORMAT = 'CSV');


-- EXEC GDP_Excel_Input_Monthly