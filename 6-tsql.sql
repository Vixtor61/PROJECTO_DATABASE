-- TSQL
--1. FUNCION PARA VER EL MUNICIPIO DE CADA HOSPITAL

CREATE FUNCTION mostrarMunicipio(@id_hospital int)
		RETURNS VARCHAR(35)
		AS BEGIN 
				DECLARE @municipio VARCHAR(35);
				SELECT @municipio= m.nombre 
				FROM MUNICIPIO m, HOSPITAL h
				WHERE h.id_municipio=m.id
				AND h.id = @id_hospital;
			RETURN @municipio;
 		
		END;

SELECT h.id, h.nombre, h.direccion, [dbo].[mostrarMunicipio](h.id) AS municipio
FROM HOSPITAL h;

--2. Funcion que retorna el servicio hospitalario con el que cuenta el hospital

drop function mostrarServicio
CREATE FUNCTION mostrarServicio(@id_hospital int)

		RETURNS VARCHAR(35)
		AS BEGIN 
				DECLARE @SERVICIO VARCHAR(35);
				SELECT @SERVICIO = a.servicio_hospitalario
				FROM AREA a, HOSPITAL h
--				WHERE h.id = a.id_hospital
			RETURN @SERVICIO;
			
		END;

SELECT a.id, a.nombre as 'Nombre de Area', a.responsable, [dbo].[mostrarServicio](a.id) AS Servicio_Hospitalario
FROM AREA a;

--3. Procedimiento almacneado que consiste en mostrar cuantas areas tiene un hospital.
--PROCEDIMIENTO QUE MUESTRA LAS AREAS DEL HOSPITAL
CREATE PROCEDURE GETNUMAREA 
@id_hospital VARCHAR(50)
			
	AS BEGIN
			DECLARE @cant_area INT;
			SELECT @cant_inventario = COUNT (h.id)
			FROM HOSPITAL h INNER JOIN AREA a
			ON a.id_hospital = h.id
			AND h.id = @id_hospital
			GROUP BY h.id, h.nombre;

			IF @cant_area IS NULL
				PRINT('EL HOSPITAL ' + CAST(@id_hospital AS VARCHAR(5)) + ' POSEE: ' + 'NINGUN AREA');
				
			ELSE 
				PRINT('EL HOSPITAL ' + CAST(@id_hospital AS VARCHAR(5)) + ' POSEE: ' + CAST(@cant_area AS VARCHAR(5)) + ' AREA/AS.');
			END;
			
EXEC GETNUMAREA 5;

--4.Procedimiento almacenado que consiste en mostrar cuantas inspecciones ha realizado cada inspector.
drop procedure GETCANTINSPECCIONES
CREATE PROCEDURE GETCANTINSPECCIONES
@no_serie_equipo_inspeccion VARCHAR(10)
			
	AS BEGIN
			DECLARE @no_serie int;
			DECLARE @fecha_cal varchar(20);
			SELECT @fecha_cal  = cast(ei.fecha_calibracion as date)
			FROM equipo_inspeccion ei
			WHERE ei.no_serie = @no_serie_equipo_inspeccion AND ei.fecha_calibracion BETWEEN '01/01/2018' AND '12/31/2018'
			
			IF @fecha_cal IS NULL
				PRINT('EL EQUIPO DE INSPECCION ' + CAST(@no_serie_equipo_inspeccion AS VARCHAR(8)) + ', NO HA TENIDO: ' + 'NINGUNA CALIBRACION');
				
			ELSE 
				PRINT('EL EQUIPO DE INSPECCION ' + CAST(@no_serie_equipo_inspeccion AS VARCHAR(8)) + ', RECIBIO CALIBRACION LA FECHA: ' + CAST(@fecha_cal AS varchar(20)) + ' CALIBRACION/ES.');
			END;
			
EXEC GETCANTINSPECCIONES 12;
