CREATE DATABASE proyecto
use proyecto

CREATE TABLE municipio(
	id INT NOT NULL,
	nombre VARCHAR(20)
	CONSTRAINT pk_municipio PRIMARY KEY (id)
	);

	

CREATE TABLE hospital(
	id INT NOT NULL,
	nombre VARCHAR(20),
	direccion VARCHAR(50),
	telefono VARCHAR(9) CHECK (telefono LIKE '\[276][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' ESCAPE '\'),
	id_municipio INT,
	CONSTRAINT pk_hospital PRIMARY KEY (id),
	CONSTRAINT fk_municipio FOREIGN KEY(id_municipio) REFERENCES municipio(id)
	);

CREATE TABLE equipo_medico(
	numero_serie INT NOT NULL,
	nombre VARCHAR(20),
	marca VARCHAR(20),
	modelo VARCHAR(20),
	fecha_mantenimiento DATE,
	numero_inventario INT,
	CONSTRAINT pk_equipoMedico PRIMARY KEY (numero_serie)
	);

CREATE TABLE accesorios_em(
	id INT NOT NULL,
	nombre VARCHAR(20),
	id_equipoMedico INT,
	CONSTRAINT pk_accesorios_em PRIMARY KEY (id),
	CONSTRAINT fk_equipo_medico FOREIGN KEY(id_equipoMedico) REFERENCES equipo_medico(numero_serie)
	);

CREATE TABLE clase_equipoMedico(
	id INT NOT NULL,
	nombre VARCHAR(20),
	id_equipoMedico INT,
	CONSTRAINT pk_claseEM PRIMARY KEY (id),
	CONSTRAINT fk__equipo_medico FOREIGN KEY(id_equipoMedico) REFERENCES equipo_medico(numero_serie)
	);

CREATE TABLE tipo_equipoMedico(
	id INT NOT NULL,
	nombre VARCHAR(20),
	id_equipoMedico INT,
	CONSTRAINT pk_tipoEM PRIMARY KEY (id),
	CONSTRAINT fk_equipo__medico FOREIGN KEY(id_equipoMedico) REFERENCES equipo_medico(numero_serie)
	);

CREATE TABLE inspeccion(
	id INT NOT NULL,
	resultados VARCHAR(50),
	observaciones VARCHAR(50),
	CONSTRAINT pk_inspeccion PRIMARY KEY (id)
	);

CREATE TABLE EMXINS(
	id_em INT NOT NULL,
	id_ins INT NOT NULL,
	fecha_hora_inspeccion DATETIME,
	
	CONSTRAINT fk_em_emxins FOREIGN KEY(id_em) REFERENCES equipo_medico(numero_serie),
	CONSTRAINT fk_ins_emxins FOREIGN KEY(id_ins) REFERENCES inspeccion(id),
	unique(id_em,id_ins)
	);

CREATE TABLE puntos_medicion(
	id INT NOT NULL,
	nombre VARCHAR(20),
	id_inspeccion INT,
	CONSTRAINT PK_puntos_medicion PRIMARY KEY(id),
	CONSTRAINT FK_inspeccion_pmedicion FOREIGN KEY(id_inspeccion) REFERENCES inspeccion(id)

);

CREATE TABLE parametro(
	id INT NOT NULL,
	nombre VARCHAR(20),
	id_inspeccion INT,
	CONSTRAINT PK_parametro PRIMARY KEY(id),
	CONSTRAINT FK_inspeccion_parametro FOREIGN KEY(id_inspeccion) REFERENCES inspeccion(id)

);

CREATE TABLE equipo_inspeccion(
	no_serie INT NOT NULL,
	nombre VARCHAR(20),
	marca VARCHAR(20),
	modelo VARCHAR(20),
	fecha_calibracion DATE,
	certificado_calibracion VARCHAR(20),
	CONSTRAINT PK_equipo_inspeccion PRIMARY KEY(no_serie)
);


CREATE TABLE INSXEI(
	id_ins INT not null,
	id_ei INT not null,

	CONSTRAINT FK_ins_insxei  FOREIGN KEY (id_ins) REFERENCES inspeccion(id),
	
	CONSTRAINT FK_ei_insxei  FOREIGN KEY (id_ei) REFERENCES equipo_inspeccion(no_serie),
	UNIQUE(id_ins,id_ei)
);

CREATE TABLE accesorios_ins(
	id INT NOT NULL,
	nombre VARCHAR(20),
	id_equipo_inspeccion INT,
	CONSTRAINT pk_accesorios_ins PRIMARY KEY (id),
	CONSTRAINT fk_equipo_inspeccion FOREIGN KEY(id_equipo_inspeccion) REFERENCES equipo_inspeccion(no_serie)
);

CREATE TABLE area(
	id INT NOT NULL,
	nombre VARCHAR(20),
	servicio_hospitalario VARCHAR(50),
	responsable VARCHAR(50),
	responsable_mantenimiento VARCHAR(50),
	extension VARCHAR(4),
	id_hospital INT,
	id_em INT
	CONSTRAINT pk_area PRIMARY KEY (id),
	CONSTRAINT fk_equipo_medico_area FOREIGN KEY(id_em) REFERENCES equipo_medico(numero_serie),
	CONSTRAINT fk_hospital_area FOREIGN KEY(id_hospital) REFERENCES hospital(id)
	);

--MUNICIPIOS
INSERT INTO municipio([id],[nombre]) VALUES(1,'San Salvador'),(2,'Aguilares'),(3,'Apopa'),(4,'Ayutuxtepeque'),(5,'Cuscatancingo'),(6,'Delgado'),(7,'El Paisnal'),(8,'Guazapa'),(9,'Ilopango'),(10,'Mejicanos');
INSERT INTO municipio([id],[nombre]) VALUES(11,'Nejapa'),(12,'Panchimalco'),(13,'Rosario de Mora'),(14,'San Marcos'),(15,'San Martin'),(16,'Santiago Texacuangos'),(17,'Santo Tomas'),(18,'Soyapango'),(19,'Tonacatepeque'),(20,'Santa Tecla');
INSERT INTO municipio([id],[nombre]) VALUES(21,'Antiguo Cuscatlan'),(22,'Chiltiupan'),(23,'Ciudad Arce'),(24,'Colon'),(25,'Comasagua'),(26,'Huizucar'),(27,'Jayaque'),(28,'Jicalapa'),(29,'La Libertad'),(30,'Nuevo Cuscatlan');
INSERT INTO municipio([id],[nombre]) VALUES(31,'Quezaltepeque'),(32,'San Juan Opico'),(33,'Sacacoyo'),(34,'San Jose Villanueva'),(35,'San Matias'),(36,'San Pablo Tacachico'),(37,'Talnique'),(38,'Tamanique'),(39,'Teotepeque'),(40,'Tepecoyo');
INSERT INTO municipio([id],[nombre]) VALUES(41,'Zaragoza'),(42,'Cojutepeque'),(43,'Candelaria'),(44,'El Carmen'),(45,'El Rosario'),(46,'Monte San Juan'),(47,'Oratorio de Concepcion'),(48,'San Bartolome Perulapia'),(49,'San Cristobal'),(50,'San Jose Guayabal');

--HOSPITALES
INSERT INTO hospital([id],[nombre],[telefono],[direccion],[id_municipio]) VALUES(1,'Sem Industries','2936-3750','839-8956 Donec C/',42),(2,'Senectus Et LLC','2807-5463','Apdo.:847-9096 Non Calle',48),(3,'Pretium Aliquet Incorporated','2982-1063','Apartado n�m.: 380, 4416 Blandit. ',32),(4,'Arcu Company','2555-9141','Apartado n�m.: 588, 4993 A, Av.',43),(5,'Urna Ut Corporation','2257-7011','254-4901 Non, Carretera',14),(6,'Diam Foundation','2355-6782','9735 Diam. Ctra.',50),(7,'Felis Nulla Tempor Incorporated','2717-1233','Apartado n�m.: 354, 6244 Nec Carretera',7),(8,'Duis Elementum Consulting','2909-3436','1079 Feugiat C/',8),(9,'Aliquam LLC','2228-5542','Apdo.:427-3834 Et Calle',21),(10,'Tellus Industries','2105-7973','257-9375 Eleifend C.',7);
INSERT INTO hospital([id],[nombre],[telefono],[direccion],[id_municipio]) VALUES(11,'Sit Amet Ultricies Ltd','2430-6291','185-3239 Congue. Avda.',13),(12,'Nec Diam Inc.','2562-2919','5795 Faucibus C/',30),(13,'Volutpat Ornare Ltd','2779-0540','Apdo.:298-2443 Sit Ctra.',29),(14,'Ipsum Dolor Inc.','2996-0063','717-5331 Interdum. Ctra.',13),(15,'Nec PC','2745-1982','Apartado n�m.: 819, 1023 Feugiat C.',44),(16,'Class Limited','2276-0578','9967 Venenatis Ctra.',20),(17,'Ultricies Ornare LLP','2048-7612','152-1304 Est. Avda.',10),(18,'Ante Dictum Mi Corporation','2606-3918','1005 Tellus Av.',3),(19,'Sociis Natoque Penatibus Limited','2648-5654','6457 Ac ',9),(20,'Sed Inc.','2245-6180','Apdo.:412-5523 Proin C.',28);

--AREA
INSERT INTO area([id],[nombre],[servicio_hospitalario],[responsable],[responsable_mantenimiento],[extension],[id_hospital],[id_em]) VALUES(1,'Anestiosologia','Anestesias','Skyler Medina','Lewis Craft','8102',19,9),(2,'Cardiologia','Cuidados al corazon','Nehru Espinoza','Naomi Chavez','3385',14,26),(3,'Cuidados intensivos','Pacientes en riesgo','Carl Horton','Finn Barber','5590',11,24),(4,'Digestivo','Enfermedades estomacales','Tamara Lott','Ignacia Lawson','9361',4,30),(5,'Hematologia','Golpes','Dustin Keller','Fritz Hyde','0161',5,23),(6,'Medicina interna','Ingreso de pacientes','Zia Merrill','Shea Downs','2796',11,18),(7,'Neumologia','Enfermedades pulmonares','Steel Case','Elizabeth Stein','5639',16,16),(8,'Pediatria','Pacientes infantes','Justine Mccullough','Bevis Tyson','8338',13,19),(9,'Urgencias','Emergencias','Elliott Velazquez','Chandler Robertson','7573',18,13),(10,'Rehabilitacion','Recuperacion','Keaton Gallagher','Velma Reid','1747',16,13);
INSERT INTO area([id],[nombre],[servicio_hospitalario],[responsable],[responsable_mantenimiento],[extension],[id_hospital],[id_em]) VALUES(11,'Cirugia General y Digestiva','Cirugias generales','Kane Bird','Moses Santiago','3722',3,7),(12,'Traumatologia','Cirugia y heridas graves','Regan Newton','Addison Gill','3263',19,26),(13,'Dermatologia','Cuido de Piel','Charissa Burgess','Donovan Salas','8523',8,24),(14,'Oftalmologia','Salud Visual','Sydnee Rowland','Cassandra Avila','7485',6,27),(15,'Otorrinolarinngologia','Salud Auditiva','Rogan Cantu','Lacota Wright','4025',2,7),(16,'Laboratorios Clinicos','Examenes varios','Kessie Bailey','Paki Flowers','9155',13,6),(17,'Radiodiagnostico','Examenes Radiograficos','Keaton Nielsen','Elliott Bolton','9113',12,12),(18,'Farmacia','Mediacamentos','Rashad Dominguez','Erin Frank','4111',4,26),(19,'Urologia','Salud en aparato urinario','Steven Cameron','Abra Mcintosh','9742',2,3),(20,'Sem Company','Fusce Dolor Consulting','Hammett Noel','Lillian Nicholson','2416',15,27);


--EQUIPO MEDICO
INSERT INTO equipo_medico([numero_serie],[nombre],[marca],[modelo],[fecha_mantenimiento],[numero_inventario]) VALUES(1,'A Foundation','Dictum Ltd','D7Q 9K4','04/06/19',9),(2,'Ornare LLP','Non Arcu Vivamus Institute','T7K 6G4','24/11/19',3),(3,'Nam Foundation','Donec Consectetuer Limited','P6M 7E5','09/02/19',8),(4,'Dolor Dolor Tempus Industries','Turpis Egestas Aliquam Corp.','Z0L 4S0','20/06/19',3),(5,'Quis Tristique Corp.','Netus Et Malesuada PC','M6E 1Z6','22/07/19',2),(6,'Feugiat Corporation','At Libero Foundation','J0W 6A8','20/02/19',9),(7,'Leo Morbi Neque Corp.','Orci Foundation','M3L 0X6','05/07/18',2),(8,'Non Corporation','In LLP','Z0S 2Y1','17/04/20',1),(9,'Orci Tincidunt Adipiscing Consulting','Nec Ante Ltd','F8Y 8J8','19/10/18',6),(10,'Enim Etiam Imperdiet Corporation','Elit Curabitur Sed Company','M0Y 3R1','22/03/20',8);
INSERT INTO equipo_medico([numero_serie],[nombre],[marca],[modelo],[fecha_mantenimiento],[numero_inventario]) VALUES(11,'Imperdiet LLP','Congue Turpis In PC','B5T 7T8','07/07/19',10),(12,'Aliquam PC','Et Consulting','G3J 1R2','22/02/20',2),(13,'Non Nisi Aenean Industries','Tempor PC','G3G 8R1','23/06/18',10),(14,'Malesuada Fames Institute','Dui Fusce Diam Incorporated','G2O 1X4','11/12/18',2),(15,'Mauris Inc.','Sed Dictum Foundation','N6V 0O3','09/06/20',6),(16,'Senectus Et PC','Aliquam Auctor Limited','S4D 7M2','17/06/20',6),(17,'Nec Inc.','Amet Nulla Donec Associates','E2V 3E7','23/04/20',4),(18,'Bibendum Ullamcorper Institute','Molestie Sodales Mauris LLC','M9Q 4J9','04/12/18',2),(19,'Et Commodo At LLC','Nulla In PC','Y5F 9Y4','01/06/19',3),(20,'Non Institute','Magna Ltd','O8Z 0G0','11/06/19',9);
INSERT INTO equipo_medico([numero_serie],[nombre],[marca],[modelo],[fecha_mantenimiento],[numero_inventario]) VALUES(21,'Consectetuer Limited','Fringilla Mi Lacinia Industries','L4S 4Y6','11/07/19',3),(22,'Non Sollicitudin A Company','Dignissim Magna A Corporation','G7V 9U5','05/08/19',1),(23,'Suspendisse Tristique Company','Dui Cum Consulting','U4Q 7O2','26/10/19',10),(24,'Aenean Corporation','Et Netus LLP','Q6T 4B2','11/08/19',7),(25,'Dolor Tempus Non Foundation','Interdum Enim Non Institute','P9E 3W8','25/03/20',5),(26,'Mi Lacinia Limited','Nibh Phasellus Corporation','H9O 5Y5','27/05/19',9),(27,'Fringilla Est Consulting','Erat PC','K7K 8B8','12/06/20',2),(28,'A LLP','A Auctor Non Ltd','G0Q 3T2','13/09/19',7),(29,'Non Lobortis Inc.','Porttitor Tellus Ltd','S4B 2Z9','20/02/19',3),(30,'Consequat Limited','At Industries','I8O 6R5','06/09/19',7);


--ACCESORIOS EQUIPO MEDICO
INSERT INTO accesorios_em([id],[nombre],[id_equipoMedico]) VALUES(1,'Hymenaeos Consulting',12),(2,'Purus LLP',14),(3,'Euismod Urna Inc.',11),(4,'Libero At Auctor Corp.',19),(5,'Posuere Cubilia Curae; Industries',23),(6,'Consequat Lectus Ltd',18),(7,'Pharetra Nibh Industries',23),(8,'Et Tristique Pellentesque Associates',15),(9,'A Tortor Nunc Company',1),(10,'Elementum Foundation',14);
INSERT INTO accesorios_em([id],[nombre],[id_equipoMedico]) VALUES(11,'Convallis Erat Eget Limited',15),(12,'Facilisis Company',9),(13,'Cras Pellentesque Corporation',28),(14,'Quisque Nonummy Ipsum Associates',28),(15,'Ac Institute',9),(16,'Lorem Industries',10),(17,'Adipiscing Ltd',3),(18,'A Associates',20),(19,'Convallis PC',9),(20,'In Consulting',23);
INSERT INTO accesorios_em([id],[nombre],[id_equipoMedico]) VALUES(21,'Vitae Orci Inc.',30),(22,'Quis Pede Praesent Corporation',5),(23,'Interdum Associates',21),(24,'Convallis Ligula Ltd',4),(25,'Ut Ltd',18),(26,'Tempus Lorem Incorporated',19),(27,'Hendrerit Donec Ltd',27),(28,'Sit Amet Lorem Industries',26),(29,'Tincidunt Vehicula LLC',28),(30,'Aliquam Enim Nec Inc.',6);
INSERT INTO accesorios_em([id],[nombre],[id_equipoMedico]) VALUES(31,'In Tincidunt Congue Consulting',9),(32,'Auctor Ullamcorper Nisl Corporation',28),(33,'Feugiat Tellus PC',29),(34,'Nonummy Company',6),(35,'Eu Nulla At Industries',3),(36,'Ac Risus LLP',27),(37,'Ullamcorper Consulting',2),(38,'Dui Lectus Rutrum Foundation',10),(39,'Nullam LLC',22),(40,'Dictum Ultricies Ligula Corporation',5);

--CLASE EQUIPO MEDICO


--TIPO EQUIPO MEDICO


--EMXINS
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(28,1,'2020-06-08 06:52:01'),(25,2,'2019-05-02 10:21:52'),(27,3,'2018-11-24 11:37:16'),(1,4,'2019-09-06 00:27:48'),(20,5,'2019-02-16 10:46:04'),(17,6,'2019-07-01 23:35:10'),(30,7,'2018-09-18 12:23:31'),(10,8,'2020-05-13 03:51:36'),(24,9,'2019-07-11 21:42:15'),(26,10,'2019-01-24 09:51:07');
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(21,11,'2020-05-23 03:51:32'),(24,12,'2019-09-19 19:11:51'),(20,13,'2018-12-23 15:04:50'),(15,14,'2019-03-30 08:55:20'),(17,15,'2019-10-31 09:48:36'),(29,16,'2018-11-09 00:43:14'),(29,17,'2019-07-24 19:30:49'),(13,18,'2019-08-28 04:22:51'),(21,19,'2018-08-27 01:19:14'),(8,20,'2020-01-20 03:37:07');
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(21,21,'2020-04-20 09:45:54'),(29,22,'2019-01-25 22:05:12'),(12,23,'2019-02-24 18:01:22'),(29,24,'2018-09-24 21:34:30'),(21,25,'2018-12-08 02:01:40'),(13,26,'2020-03-05 14:36:54'),(13,27,'2019-01-19 21:07:45'),(4,28,'2018-07-24 06:36:49'),(23,29,'2018-09-01 13:13:42'),(6,30,'2018-12-02 03:32:22');
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(2,31,'2019-05-24 16:36:55'),(9,32,'2019-06-16 12:45:53'),(25,33,'2019-01-20 18:21:17'),(4,34,'2019-05-01 23:02:22'),(7,35,'2019-10-04 00:41:20'),(25,36,'2019-04-07 08:06:48'),(22,37,'2018-09-15 02:37:51'),(25,38,'2019-09-27 11:52:25'),(8,39,'2018-10-20 19:53:11'),(14,40,'2019-05-15 18:58:27');
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(18,41,'2018-07-17 01:32:17'),(17,42,'2018-07-14 16:53:58'),(30,43,'2019-05-03 06:45:09'),(3,44,'2019-06-10 20:01:51'),(4,45,'2018-06-23 01:18:58'),(17,46,'2019-08-19 11:00:27'),(25,47,'2018-10-20 11:22:45'),(27,48,'2018-08-06 20:04:07'),(27,49,'2019-03-19 23:04:37'),(3,50,'2018-10-27 19:17:56');


--INSPECCION
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(1,'egestas blandit. Nam nulla magna, malesuada vel, convallis in, cursus et, eros. Proin','Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas'),(2,'enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc mauris sapien, cursus','quis diam luctus lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per'),(3,'vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices','purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue'),(4,'aliquet vel, vulputate eu, odio. Phasellus at augue id ante dictum cursus. Nunc mauris elit,','faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis'),(5,'Proin dolor. Nulla semper tellus id nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam','lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus.'),(6,'nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu','nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna.'),(7,'Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet.','egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam'),(8,'vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec felis orci,','ridiculus mus. Proin vel arcu eu odio tristique pharetra. Quisque ac'),(9,'ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit,','per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas.'),(10,'congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec vitae','purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio. Phasellus at augue id');
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(11,'libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris','natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis'),(12,'pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget ipsum.','vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate'),(13,'ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis placerat. Cras dictum ultricies','torquent per conubia nostra, per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc'),(14,'velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas.','rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus'),(15,'adipiscing lobortis risus. In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna','velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus'),(16,'non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc mauris sapien,','ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem'),(17,'lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim diam vel arcu. Curabitur ut odio vel','non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh.'),(18,'luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac sem','magna a tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque'),(19,'malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing','arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus'),(20,'arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros nec tellus. Nunc lectus pede,','nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus');
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(21,'orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu','mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum'),(22,'facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede. Cum','nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo'),(23,'nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros','fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec'),(24,'amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et','dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce'),(25,'Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis,','adipiscing ligula. Aenean gravida nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel'),(26,'et netus et malesuada fames ac turpis egestas. Fusce aliquet','justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et'),(27,'est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper','In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero'),(28,'adipiscing ligula. Aenean gravida nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu eu odio','ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi'),(29,'hendrerit consectetuer, cursus et, magna. Praesent interdum ligula eu enim. Etiam','ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales.'),(30,'ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu eu odio','parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus.');
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(31,'tellus eu augue porttitor interdum. Sed auctor odio a purus. Duis elementum, dui quis accumsan convallis,','consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget'),(32,'lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec','sem egestas blandit. Nam nulla magna, malesuada vel, convallis in,'),(33,'urna, nec luctus felis purus ac tellus. Suspendisse sed dolor.','nibh dolor, nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper'),(34,'imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac','pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae'),(35,'elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in faucibus','tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor'),(36,'scelerisque, lorem ipsum sodales purus, in molestie tortor nibh sit amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus. Aenean egestas hendrerit neque.','Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras'),(37,'ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis.','lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla.'),(38,'fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae','mus. Donec dignissim magna a tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices.'),(39,'Nam nulla magna, malesuada vel, convallis in, cursus et, eros. Proin ultrices. Duis volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer','purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio. Phasellus at augue id'),(40,'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna','metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate, risus a');
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(41,'Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue,','nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum placerat, augue. Sed'),(42,'amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh.','porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget,'),(43,'scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu,','quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend'),(44,'aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh.','velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit,'),(45,'felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor,','malesuada vel, convallis in, cursus et, eros. Proin ultrices. Duis volutpat'),(46,'Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna','posuere cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue. In'),(47,'fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut','Cras sed leo. Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum,'),(48,'Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum','elit erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit'),(49,'nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque','vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse'),(50,'lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi','est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis');

--PARAMETRO
INSERT INTO parametro([id],[nombre],[id_inspeccion]) VALUES(1,'Fusce Mollis Duis Corp.',29),(2,'Lorem Consulting',21),(3,'Dolor Fusce Feugiat LLP',20),(4,'Suspendisse Commodo Inc.',26),(5,'Elementum Purus Accumsan PC',42),(6,'Dui Lectus Rutrum Industries',3),(7,'Nec Inc.',24),(8,'Integer Urna Company',44),(9,'Arcu Curabitur Ut Corp.',33),(10,'Cursus Integer Limited',47);


--PUTOS DE MEDICION
INSERT INTO puntos_medicion([id],[nombre],[id_inspeccion]) VALUES(1,'Duis Mi Limited',1),(2,'Etiam Laoreet Libero Industries',40),(3,'Metus Vitae Velit PC',13),(4,'Eget Company',47),(5,'Arcu Aliquam Foundation',36),(6,'Donec At Arcu Company',18),(7,'Adipiscing Fringilla Limited',1),(8,'Phasellus Vitae Mauris Associates',16),(9,'A Purus Duis LLP',25),(10,'Magnis Dis Limited',38);


--INSXEI
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(1,9),(2,7),(3,5),(4,5),(5,15),(6,20),(7,3),(8,14),(9,14),(10,18);
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(11,10),(12,6),(13,8),(14,11),(15,16),(16,20),(17,7),(18,11),(19,14),(20,20);
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(21,6),(22,9),(23,17),(24,2),(25,20),(26,15),(27,15),(28,1),(29,10),(30,19);
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(31,1),(32,3),(33,15),(34,16),(35,14),(36,20),(37,1),(38,4),(39,20),(40,12);
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(41,15),(42,8),(43,14),(44,19),(45,1),(46,12),(47,8),(48,4),(49,7),(50,6);


--EQUIPO DE INSPECCION
INSERT INTO equipo_inspeccion([no_serie],[nombre],[marca],[modelo],[fecha_calibracion],[certificado_calibracion]) VALUES(1,'Montes Incorporated','Imperdiet Nec Ltd','U6F 0A2','04/12/19','TZO11DGR8CB'),(2,'Rutrum Fusce Dolor Incorporated','Nunc Consulting','H1T 7G4','01/12/19','XDW33ZLR5VH'),(3,'Posuere Industries','Consectetuer Corp.','G2E 1V9','11/04/19','HLA45ARH6VW'),(4,'Cras Sed PC','Primis In Company','C1R 1B8','29/12/19','SNQ53KPR0LJ'),(5,'Tellus Non PC','Diam Pellentesque Habitant Incorporated','Q3F 9Z8','10/04/19','IMG26UKB9AH'),(6,'Ipsum Consulting','Congue In Associates','D7M 6Y9','12/03/19','LJX44OIO6ON'),(7,'Ut Tincidunt Orci Foundation','Suspendisse Sagittis Nullam Corp.','Z1U 0L2','12/11/18','KTI26XPL5MP'),(8,'Neque Inc.','Diam Lorem Auctor Incorporated','M3N 6K3','29/11/18','FFM35OVH4RI'),(9,'Egestas Nunc Sed Inc.','Felis Orci Adipiscing Institute','Z6I 6R1','30/04/19','XIW75ELM2DM'),(10,'Dolor Tempus Non Company','Luctus Aliquet Odio LLC','N0F 6F2','29/04/20','CPF04BJQ3CI');
INSERT INTO equipo_inspeccion([no_serie],[nombre],[marca],[modelo],[fecha_calibracion],[certificado_calibracion]) VALUES(11,'Ut Semper Corp.','Faucibus Id Libero Institute','H2L 5J0','02/05/20','CBY19DQQ6ND'),(12,'Magnis Dis Incorporated','Donec Consulting','O0C 8W4','19/09/19','JEE62RTJ6XY'),(13,'Non Consulting','Purus Sapien Corporation','I1I 2O9','12/12/18','TDR48ZEI4XS'),(14,'Enim Industries','Erat Vel Inc.','H2X 2T4','30/04/20','YPO84RDX6MB'),(15,'Sed PC','Facilisis Limited','G5Z 0H1','16/09/18','PFU64EMF3DG'),(16,'Libero Mauris Aliquam Incorporated','Tempor Bibendum Donec Industries','V1J 6W6','04/01/19','TAX19JPS6XY'),(17,'Vel LLC','Eu Ligula Aenean Foundation','D2A 7Z0','19/07/19','BWB33KDZ0PT'),(18,'Eu Nulla At Institute','Nec Leo Foundation','K6O 6T4','08/09/18','JSM23HNH1QE'),(19,'Duis Ac Foundation','Facilisi Sed Neque Corporation','B9T 8X9','10/06/20','DSI50OZS4YI'),(20,'Ac Feugiat Non Foundation','Aenean Euismod Associates','V7P 1M8','03/12/19','JHU84TPH3OB');

--ACCESORIOS EQUIPO INSPECCION
INSERT INTO accesorios_ins([id],[nombre],[id_equipo_inspeccion]) VALUES(1,'Ante Consulting',17),(2,'Non Enim PC',8),(3,'Mi Fringilla Corporation',17),(4,'Ipsum Suspendisse Non Consulting',18),(5,'Posuere Cubilia Curae; Foundation',7),(6,'Elit LLC',01),(7,'Ipsum Incorporated',10),(8,'Eros Non Corporation',3),(9,'Sagittis Felis LLC',1),(10,'Egestas Nunc Industries',12);
INSERT INTO accesorios_ins([id],[nombre],[id_equipo_inspeccion]) VALUES(11,'Mauris LLP',5),(12,'Ultricies Adipiscing PC',3),(13,'Egestas Corp.',11),(14,'Dolor Nonummy Industries',7),(15,'Vitae Erat Institute',1),(16,'Duis Dignissim Tempor Industries',5),(17,'Tellus Id Associates',4),(18,'Nascetur Ridiculus Company',8),(19,'Mus Aenean Eget LLP',19),(20,'Luctus Sit Amet Company',16);
INSERT INTO accesorios_ins([id],[nombre],[id_equipo_inspeccion]) VALUES(21,'Rutrum Lorem Corporation',27),(22,'Scelerisque Scelerisque Industries',20),(23,'Quam Curabitur Vel Foundation',30),(24,'Ante Dictum Institute',15),(25,'Ut Sagittis Lobortis Industries',17),(26,'Ornare Facilisis Corporation',8),(27,'Consequat Corp.',17),(28,'Ullamcorper Magna Inc.',11),(29,'Nulla Ante Ltd',13),(30,'Eget Corp.',33);
INSERT INTO accesorios_ins([id],[nombre],[id_equipo_inspeccion]) VALUES(31,'Hendrerit Institute',12),(32,'Nulla Dignissim Maecenas Ltd',10),(33,'Mi Pede Nonummy Consulting',15),(34,'Vestibulum Accumsan Neque Foundation',13),(35,'Fermentum Arcu Foundation',14),(36,'Penatibus Foundation',14),(37,'Eu Elit Industries',5),(38,'Duis Volutpat Nunc Ltd',06),(39,'Elit Sed Consequat Corporation',3),(40,'Lectus Institute',19);

-- TSQL















