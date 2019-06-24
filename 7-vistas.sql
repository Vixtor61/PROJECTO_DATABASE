--VISTAS

--1. hospitales por municipio
CREATE VIEW hospitalespormunicipios
   AS  
   SELECT mu.nombre,COUNT(h.id_municipio) as Hospitales FROM hospital h LEFT JOIN municipio mu on mu.id = h.id_municipio
   GROUP BY mu.nombre

GO  
SELECT e.nombre, e.hospitales FROM  hospitalespormunicipios  e   
ORDER BY e.hospitales DESC;
GO  

--2. Resultados de la inspeccion
CREATE VIEW inspec
   AS  
   SELECT ei.nombre ,ins.resultados , p.nombre inspe FROM inspeccion ins INNER JOIN INSXEI insei 
   on ins.id = insei.id_ins INNER JOIN equipo_inspeccion ei 
   ON insei.id_ei = ei.no_serie INNER JOIN parametro p 
   on p.id_inspeccion = ins.id
   
GO  
SELECT ins.nombre, ins.resultados FROM  inspec  ins   
ORDER BY ins.nombre DESC;
GO  

--3. Resultados de equipo medico
CREATE VIEW ins_em
   AS  
   SELECT em.nombre ,ins.resultados , p.nombre inspe FROM inspeccion ins INNER JOIN EMXINS emins
   ON ins.id = emins.id_ins INNER JOIN equipo_medico em 
   ON emins.id_em = em.numero_serie INNER JOIN parametro p 
   ON p.id_inspeccion = ins.id
   WHERE emins.fecha_hora_inspeccion BETWEEN CAST('2018-01-01' as DATE) AND CAST('2018-12-31' as DATE);
 
GO  

SELECT im.nombre,im.resultados FROM  ins_em im
ORDER BY im.nombre DESC;
GO  

--4. Parametro con sus inspecciones
CREATE VIEW parametrosins
   AS  
   SELECT  p.nombre,ins.id as ID_INSPECCION FROM inspeccion ins INNER JOIN parametro p on p.id_inspeccion = ins.id;
GO  
SELECT p.nombre , p.ID_INSPECCION FROM  parametrosins p
ORDER BY p.nombre DESC;
GO  

--5. Mostrar equipo disponible para hospitales de la marca "Ipsum Ac Mi PC"
CREATE VIEW equipo_hospital
   AS  
   SELECT  a.nombre as Area,h.nombre as Hospital,me.nombre as Equipo,me.marca as Marca FROM area a INNER JOIN hospital h ON h.id = a.id_hospital INNER JOIN equipo_medico me ON me.numero_serie = a.id_em 
   where me.marca = 'Ipsum Ac Mi PC';
 
GO  
SELECT  eh .Area , eh.Hospital, eh.Equipo, eh.Marca FROM  equipo_hospital eh
ORDER BY eh.Area DESC;
GO  



