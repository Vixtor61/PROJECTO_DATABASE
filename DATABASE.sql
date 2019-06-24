CREATE DATABASE proyecto;
use proyecto;
DROP DATABASE proyecto


CREATE TABLE municipio(
	id INT NOT NULL,
	nombre VARCHAR(50)
	CONSTRAINT pk_municipio PRIMARY KEY (id)
	);

	

CREATE TABLE hospital(
	id INT NOT NULL,
	nombre VARCHAR(50),
	direccion VARCHAR(50),
	telefono VARCHAR(9) ,--CHECK (telefono LIKE '\[276][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' ESCAPE '\'),
	id_municipio INT,
	CONSTRAINT pk_hospital PRIMARY KEY (id),
	CONSTRAINT fk_municipio FOREIGN KEY(id_municipio) REFERENCES municipio(id)
	);


CREATE TABLE clase_equipoMedico(
	id INT NOT NULL,
	nombre VARCHAR(50),
	id_equipoMedico INT,
	CONSTRAINT pk_claseEM PRIMARY KEY (id),
	
	);

CREATE TABLE tipo_equipoMedico(
	id INT NOT NULL,
	nombre VARCHAR(50),
	id_equipoMedico INT,
	CONSTRAINT pk_tipoEM PRIMARY KEY (id),
	
	);

CREATE TABLE equipo_medico(
	numero_serie INT NOT NULL,
	nombre VARCHAR(50),
	marca VARCHAR(50),
	modelo VARCHAR(50),
	fecha_mantenimiento DATE,
	numero_inventario INT,
	id_clase_equipo_medico INT,
	id_tipo_equipo_medico INT,
	CONSTRAINT pk_equipoMedico PRIMARY KEY (numero_serie),
	CONSTRAINT fk_clase_equipo_medico FOREIGN KEY(id_clase_equipo_medico) REFERENCES clase_equipoMedico(id),
	CONSTRAINT fk_tipo_equipo_medico FOREIGN KEY(id_tipo_equipo_medico) REFERENCES tipo_equipoMedico(id)	
	);

CREATE TABLE accesorios_em(
	id INT NOT NULL,
	nombre VARCHAR(50),
	id_equipoMedico INT,
	CONSTRAINT pk_accesorios_em PRIMARY KEY (id),
	CONSTRAINT fk_equipo_medico FOREIGN KEY(id_equipoMedico) REFERENCES equipo_medico(numero_serie)
	);

CREATE TABLE inspeccion(
	id INT NOT NULL,
	resultados VARCHAR(300),
	observaciones VARCHAR(300),
	CONSTRAINT pk_inspeccion PRIMARY KEY (id)
	);

CREATE TABLE EMXINS(
	id_em INT NOT NULL,
	id_ins INT NOT NULL,
	fecha_hora_inspeccion DATE,
	
	CONSTRAINT fk_em_emxins FOREIGN KEY(id_em) REFERENCES equipo_medico(numero_serie),
	CONSTRAINT fk_ins_emxins FOREIGN KEY(id_ins) REFERENCES inspeccion(id),
	unique(id_em,id_ins)
	);

CREATE TABLE puntos_medicion(
	id INT NOT NULL,
	nombre VARCHAR(50),
	id_inspeccion INT,
	CONSTRAINT PK_puntos_medicion PRIMARY KEY(id),
	CONSTRAINT FK_inspeccion_pmedicion FOREIGN KEY(id_inspeccion) REFERENCES inspeccion(id)

);

CREATE TABLE parametro(
	id INT NOT NULL,
	nombre VARCHAR(50),
	id_inspeccion INT,
	CONSTRAINT PK_parametro PRIMARY KEY(id),
	CONSTRAINT FK_inspeccion_parametro FOREIGN KEY(id_inspeccion) REFERENCES inspeccion(id)

);

CREATE TABLE equipo_inspeccion(
	no_serie INT NOT NULL,
	nombre VARCHAR(50),
	marca VARCHAR(50),
	modelo VARCHAR(50),
	fecha_calibracion DATE,
	certificado_calibracion VARCHAR(50),
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
	nombre VARCHAR(50),
	id_equipo_inspeccion INT,
	CONSTRAINT pk_accesorios_ins PRIMARY KEY (id),
	CONSTRAINT fk_equipo_inspeccion FOREIGN KEY(id_equipo_inspeccion) REFERENCES equipo_inspeccion(no_serie)
);

CREATE TABLE area(
	id INT NOT NULL,
	nombre VARCHAR(50),
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
INSERT INTO hospital([id],[nombre],[telefono],[direccion],[id_municipio]) VALUES(1,'Sem Industries','2936-3750','839-8956 Donec C/',42),(2,'Senectus Et LLC','2807-5463','Apdo.:847-9096 Non Calle',48),(3,'Pretium Aliquet Incorporated','2982-1063','Apartado núm.: 380, 4416 Blandit. ',32),(4,'Arcu Company','2555-9141','Apartado núm.: 588, 4993 A, Av.',43),(5,'Urna Ut Corporation','2257-7011','254-4901 Non, Carretera',14),(6,'Diam Foundation','2355-6782','9735 Diam. Ctra.',20),(7,'Felis Nulla Tempor Incorporated','2717-1233','Apartado núm.: 354, 6244 Nec Carretera',7),(8,'Duis Elementum Consulting','2909-3436','1079 Feugiat C/',8),(9,'Aliquam LLC','2228-5542','Apdo.:427-3834 Et Calle',21),(10,'Tellus Industries','2105-7973','257-9375 Eleifend C.',7);
INSERT INTO hospital([id],[nombre],[telefono],[direccion],[id_municipio]) VALUES(11,'Sit Amet Ultricies Ltd','2430-6291','185-3239 Congue. Avda.',13),(12,'Nec Diam Inc.','2562-2919','5795 Faucibus C/',30),(13,'Volutpat Ornare Ltd','2779-0540','Apdo.:298-2443 Sit Ctra.',29),(14,'Ipsum Dolor Inc.','2996-0063','717-5331 Interdum. Ctra.',13),(15,'Nec PC','2745-1982','Apartado núm.: 819, 1023 Feugiat C.',44),(16,'Class Limited','2276-0578','9967 Venenatis Ctra.',20),(17,'Ultricies Ornare LLP','2048-7612','152-1304 Est. Avda.',10),(18,'Ante Dictum Mi Corporation','2606-3918','1005 Tellus Av.',3),(19,'Sociis Natoque Penatibus Limited','2648-5654','6457 Ac ',9),(20,'Sed Inc.','2245-6180','Apdo.:412-5523 Proin C.',28);

--CLASE EQUIPO MEDICO
INSERT INTO clase_equipoMedico([id],[nombre]) VALUES(1,'I'),(2,'II');


--TIPO EQUIPO MEDICO
INSERT INTO tipo_equipoMedico([id],[nombre]) VALUES(1,'B'),(2,'BF'),(3,'CF');

--EQUIPO MEDICO
INSERT INTO equipo_medico([numero_serie],[nombre],[marca],[modelo],[fecha_mantenimiento],[numero_inventario],[id_clase_equipo_medico],[id_tipo_equipo_medico]) VALUES(1,'Nibh Ltd','Ac Metus PC','Q6B 5T4','18/01/20',6,1,3),(2,'Enim Corporation','Mi Company','H3Y 5I7','28/07/19',6,2,3),(3,'Arcu Vestibulum Industries','Dictum Incorporated','A0M 7B9','30/09/18',7,2,1),(4,'In Dolor Fusce Corporation','Risus Odio Ltd','P8D 2S3','11/08/19',7,1,1),(5,'Id Magna Foundation','Et Netus Et Institute','I8L 6O2','21/06/20',4,2,2),(6,'Egestas Company','Est Arcu Ac Ltd','N3H 8T2','26/09/18',1,1,3),(7,'Quis LLP','Orci Ltd','R1W 7L7','16/11/19',1,2,2),(8,'Mollis Lectus LLP','Curabitur Consequat Lectus Consulting','P3N 0B2','17/12/18',6,2,2),(9,'Varius Corporation','Felis Donec Limited','P1T 7O9','14/05/20',7,1,1),(10,'Ligula Donec Luctus LLP','Erat Associates','J0J 3Z6','01/05/20',8,2,2);
INSERT INTO equipo_medico([numero_serie],[nombre],[marca],[modelo],[fecha_mantenimiento],[numero_inventario],[id_clase_equipo_medico],[id_tipo_equipo_medico]) VALUES(11,'Tristique Inc.','Ipsum Phasellus Vitae LLC','E3Y 1B0','05/03/19',5,1,3),(12,'Vestibulum Consulting','Eu Turpis Nulla Ltd','A5W 1C0','14/05/20',2,1,3),(13,'Dapibus Id Blandit PC','Ipsum Ac Mi PC','W1A 0G0','28/02/19',5,1,3),(14,'Aliquet Magna Foundation','Magnis Dis Parturient Inc.','O1T 5N5','18/08/19',1,1,3),(15,'Fringilla Cursus Purus Corp.','Libero Institute','P4S 6O7','04/01/20',2,1,2),(16,'Facilisis Facilisis Magna Limited','Egestas Incorporated','U2H 5O7','23/06/20',4,1,2),(17,'Etiam Laoreet PC','Et Malesuada Fames Consulting','U6R 8E5','12/05/19',4,2,3),(18,'Urna Suscipit Nonummy Limited','Suspendisse Ltd','X3B 7I7','19/08/19',5,2,2),(19,'Malesuada Fames Ac Incorporated','Nibh Consulting','S6Q 7X6','17/02/20',5,2,1),(20,'Nec Tempus Mauris Industries','Libero Proin Foundation','C8D 8X3','02/11/18',7,1,2);
INSERT INTO equipo_medico([numero_serie],[nombre],[marca],[modelo],[fecha_mantenimiento],[numero_inventario],[id_clase_equipo_medico],[id_tipo_equipo_medico]) VALUES(21,'Risus LLC','Mauris Sagittis Ltd','R7S 4V7','01/03/19',3,2,2),(22,'Sit Amet Consectetuer LLC','Nec Enim Incorporated','M2I 7X7','14/04/20',9,2,2),(23,'Suspendisse Institute','Auctor LLP','X2X 2E5','30/09/19',8,1,1),(24,'Fames PC','At Consulting','V2N 6Q1','07/02/19',8,2,3),(25,'Consequat Consulting','Et Arcu Corp.','C0M 1N2','17/09/18',2,2,1),(26,'Urna Justo Limited','Vestibulum Corporation','S5L 1Y0','14/10/18',8,1,3),(27,'Aenean Corp.','Dis Parturient Incorporated','L7Y 5D8','21/01/20',6,2,1),(28,'Arcu Eu Inc.','Aliquet Lobortis Nisi LLP','C8Z 2V9','26/04/19',1,1,3),(29,'Malesuada Limited','Erat Eget Ipsum Inc.','L9D 6L1','18/04/19',4,1,2),(30,'Convallis Ltd','Malesuada Foundation','Q8J 3X3','05/04/20',1,2,1);

--AREA
INSERT INTO area([id],[nombre],[servicio_hospitalario],[responsable],[responsable_mantenimiento],[extension],[id_hospital],[id_em]) VALUES(1,'Anestiosologia','Anestesias','Skyler Medina','Lewis Craft','8102',19,9),(2,'Cardiologia','Cuidados al corazon','Nehru Espinoza','Naomi Chavez','3385',14,26),(3,'Cuidados intensivos','Pacientes en riesgo','Carl Horton','Finn Barber','5590',11,24),(4,'Digestivo','Enfermedades estomacales','Tamara Lott','Ignacia Lawson','9361',4,30),(5,'Hematologia','Golpes','Dustin Keller','Fritz Hyde','0161',5,23),(6,'Medicina interna','Ingreso de pacientes','Zia Merrill','Shea Downs','2796',11,18),(7,'Neumologia','Enfermedades pulmonares','Steel Case','Elizabeth Stein','5639',16,16),(8,'Pediatria','Pacientes infantes','Justine Mccullough','Bevis Tyson','8338',13,19),(9,'Urgencias','Emergencias','Elliott Velazquez','Chandler Robertson','7573',18,13),(10,'Rehabilitacion','Recuperacion','Keaton Gallagher','Velma Reid','1747',16,13);
INSERT INTO area([id],[nombre],[servicio_hospitalario],[responsable],[responsable_mantenimiento],[extension],[id_hospital],[id_em]) VALUES(11,'Cirugia General y Digestiva','Cirugias generales','Kane Bird','Moses Santiago','3722',3,7),(12,'Traumatologia','Cirugia y heridas graves','Regan Newton','Addison Gill','3263',19,26),(13,'Dermatologia','Cuido de Piel','Charissa Burgess','Donovan Salas','8523',8,24),(14,'Oftalmologia','Salud Visual','Sydnee Rowland','Cassandra Avila','7485',6,27),(15,'Otorrinolarinngologia','Salud Auditiva','Rogan Cantu','Lacota Wright','4025',2,7),(16,'Laboratorios Clinicos','Examenes varios','Kessie Bailey','Paki Flowers','9155',13,6),(17,'Radiodiagnostico','Examenes Radiograficos','Keaton Nielsen','Elliott Bolton','9113',12,12),(18,'Farmacia','Mediacamentos','Rashad Dominguez','Erin Frank','4111',4,26),(19,'Urologia','Salud en aparato urinario','Steven Cameron','Abra Mcintosh','9742',2,3),(20,'Sem Company','Fusce Dolor Consulting','Hammett Noel','Lillian Nicholson','2416',15,27);

--ACCESORIOS EQUIPO MEDICO
INSERT INTO accesorios_em([id],[nombre],[id_equipoMedico]) VALUES(1,'Hymenaeos Consulting',12),(2,'Purus LLP',14),(3,'Euismod Urna Inc.',11),(4,'Libero At Auctor Corp.',19),(5,'Posuere Cubilia Curae; Industries',23),(6,'Consequat Lectus Ltd',18),(7,'Pharetra Nibh Industries',23),(8,'Et Tristique Pellentesque Associates',15),(9,'A Tortor Nunc Company',1),(10,'Elementum Foundation',14);
INSERT INTO accesorios_em([id],[nombre],[id_equipoMedico]) VALUES(11,'Convallis Erat Eget Limited',15),(12,'Facilisis Company',9),(13,'Cras Pellentesque Corporation',28),(14,'Quisque Nonummy Ipsum Associates',28),(15,'Ac Institute',9),(16,'Lorem Industries',10),(17,'Adipiscing Ltd',3),(18,'A Associates',20),(19,'Convallis PC',9),(20,'In Consulting',23);
INSERT INTO accesorios_em([id],[nombre],[id_equipoMedico]) VALUES(21,'Vitae Orci Inc.',30),(22,'Quis Pede Praesent Corporation',5),(23,'Interdum Associates',21),(24,'Convallis Ligula Ltd',4),(25,'Ut Ltd',18),(26,'Tempus Lorem Incorporated',19),(27,'Hendrerit Donec Ltd',27),(28,'Sit Amet Lorem Industries',26),(29,'Tincidunt Vehicula LLC',28),(30,'Aliquam Enim Nec Inc.',6);
INSERT INTO accesorios_em([id],[nombre],[id_equipoMedico]) VALUES(31,'In Tincidunt Congue Consulting',9),(32,'Auctor Ullamcorper Nisl Corporation',28),(33,'Feugiat Tellus PC',29),(34,'Nonummy Company',6),(35,'Eu Nulla At Industries',3),(36,'Ac Risus LLP',27),(37,'Ullamcorper Consulting',2),(38,'Dui Lectus Rutrum Foundation',10),(39,'Nullam LLC',22),(40,'Dictum Ultricies Ligula Corporation',5);

--INSPECCION
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(1,'egestas blandit. Nam nulla magna, malesuada vel, convallis in, cursus et, eros. Proin','Sed diam lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas'),(2,'enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc mauris sapien, cursus','quis diam luctus lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per'),(3,'vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices','purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue'),(4,'aliquet vel, vulputate eu, odio. Phasellus at augue id ante dictum cursus. Nunc mauris elit,','faucibus id, libero. Donec consectetuer mauris id sapien. Cras dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis'),(5,'Proin dolor. Nulla semper tellus id nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam','lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus.'),(6,'nibh lacinia orci, consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu','nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna.'),(7,'Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet.','egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam'),(8,'vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec felis orci,','ridiculus mus. Proin vel arcu eu odio tristique pharetra. Quisque ac'),(9,'ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit,','per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas.'),(10,'congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec vitae','purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio. Phasellus at augue id');
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(11,'libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris','natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis'),(12,'pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget ipsum.','vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc nulla vulputate'),(13,'ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis placerat. Cras dictum ultricies','torquent per conubia nostra, per inceptos hymenaeos. Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc'),(14,'velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas.','rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus'),(15,'adipiscing lobortis risus. In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna','velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus'),(16,'non magna. Nam ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc mauris sapien,','ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus, lorem'),(17,'lectus quis massa. Mauris vestibulum, neque sed dictum eleifend, nunc risus varius orci, in consequat enim diam vel arcu. Curabitur ut odio vel','non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh.'),(18,'luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac sem','magna a tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque'),(19,'malesuada ut, sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing','arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus'),(20,'arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros nec tellus. Nunc lectus pede,','nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus');
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(21,'orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu','mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum'),(22,'facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede. Cum','nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo'),(23,'nibh. Aliquam ornare, libero at auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros','fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec'),(24,'amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus et','dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce'),(25,'Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis,','adipiscing ligula. Aenean gravida nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel'),(26,'et netus et malesuada fames ac turpis egestas. Fusce aliquet','justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et'),(27,'est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper','In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero'),(28,'adipiscing ligula. Aenean gravida nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu eu odio','ultricies ornare, elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi'),(29,'hendrerit consectetuer, cursus et, magna. Praesent interdum ligula eu enim. Etiam','ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales.'),(30,'ornare, facilisis eget, ipsum. Donec sollicitudin adipiscing ligula. Aenean gravida nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel arcu eu odio','parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum fermentum metus.');
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(31,'tellus eu augue porttitor interdum. Sed auctor odio a purus. Duis elementum, dui quis accumsan convallis,','consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget'),(32,'lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh. Donec','sem egestas blandit. Nam nulla magna, malesuada vel, convallis in,'),(33,'urna, nec luctus felis purus ac tellus. Suspendisse sed dolor.','nibh dolor, nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper'),(34,'imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac','pede blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae'),(35,'elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in faucibus','tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero at auctor'),(36,'scelerisque, lorem ipsum sodales purus, in molestie tortor nibh sit amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus. Aenean egestas hendrerit neque.','Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras'),(37,'ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis.','lorem, auctor quis, tristique ac, eleifend vitae, erat. Vivamus nisi. Mauris nulla.'),(38,'fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae','mus. Donec dignissim magna a tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices.'),(39,'Nam nulla magna, malesuada vel, convallis in, cursus et, eros. Proin ultrices. Duis volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer','purus. Maecenas libero est, congue a, aliquet vel, vulputate eu, odio. Phasellus at augue id'),(40,'mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna','metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate, risus a');
INSERT INTO inspeccion([id],[resultados],[observaciones]) VALUES(41,'Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit, a feugiat tellus lorem eu metus. In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede sagittis augue,','nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum placerat, augue. Sed'),(42,'amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum sapien. Aenean massa. Integer vitae nibh.','porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget,'),(43,'scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu,','quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend'),(44,'aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh.','velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit,'),(45,'felis, adipiscing fringilla, porttitor vulputate, posuere vulputate, lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor,','malesuada vel, convallis in, cursus et, eros. Proin ultrices. Duis volutpat'),(46,'Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna','posuere cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit congue. In'),(47,'fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut','Cras sed leo. Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis massa. Mauris vestibulum,'),(48,'Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum','elit erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit'),(49,'nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut, pellentesque','vitae erat vel pede blandit congue. In scelerisque scelerisque dui. Suspendisse'),(50,'lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi','est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis');

--EMXINS
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(28,1,CAST('20-06-08' AS date)),(25,2,CAST('2019-05-02' AS date)),(27,3,CAST('2018-11-24' AS DATE)),(1,4,CAST('2019-09-06' AS DATE)),(20,5,CAST('2019-02-16' AS date)),(17,6,CAST('2019-07-01' AS DATE)),(30,7,CAST('2018-09-18' AS DATE)),(10,8,CAST('2020-05-13' AS DATE)),(24,9,CAST('2019-07-11' AS DATE)),(26,10,CAST('2019-01-24' AS DATE));
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(21,11,CAST('2020-05-23' AS DATE)),(24,12,CAST('2019-09-19' AS DATE)),(20,13,CAST('2018-12-23' AS DATE)),(15,14,CAST('2019-03-30' AS DATE)),(17,15,CAST('2019-10-31' AS DATE)),(29,16,CAST('2018-11-09' AS DATE)),(29,17,CAST('2019-07-24' AS DATE)),(13,18,CAST('2019-08-28' AS DATE)),(21,19,CAST('2018-08-27' AS DATE)),(8,20,CAST('2020-01-20' AS DATE));
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(21,21,CAST('2020-04-20' AS DATE)),(29,22,CAST('2019-01-25' AS DATE)),(12,23,CAST('2019-02-24' AS DATE)),(29,24,CAST('2018-09-24' AS DATE)),(21,25,CAST('2018-12-08' AS DATE)),(13,26,CAST('2020-03-05' AS DATE)),(13,27,CAST('2019-01-19' AS DATE)),(4,28,CAST('2018-07-24' AS DATE)),(23,29,CAST('2018-09-01' AS DATE)),(6,30,CAST('2018-12-02' AS DATE));
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(2,31,CAST('2019-05-24' AS DATE)),(9,32,CAST('2019-06-16' AS DATE)),(25,33,CAST('2019-01-20' AS DATE)),(4,34,CAST('2019-05-01' AS DATE)),(7,35,CAST('2019-10-04' AS DATE)),(25,36,CAST('2019-04-07' AS DATE)),(22,37,CAST('2018-09-15' AS DATE)),(25,38,CAST('2019-09-27' AS DATE)),(8,39,CAST('2018-10-20' AS DATE)),(14,40,CAST('2019-05-15' AS DATE));
INSERT INTO EMXINS([id_em],[id_ins],[fecha_hora_inspeccion]) VALUES(18,41,CAST('2018-07-17' AS DATE)),(17,42,CAST('2018-07-14' AS DATE)),(30,43,CAST('2019-05-03' AS DATE)),(3,44,CAST('2019-06-10' AS DATE)),(4,45,CAST('2018-06-23' AS DATE)),(17,46,CAST('2019-08-19' AS DATE)),(25,47,CAST('2018-10-20' AS DATE)),(27,48,CAST('2018-08-06' AS DATE)),(27,49,CAST('2019-03-19' AS DATE)),(3,50,CAST('2018-10-27' AS DATE));



--PARAMETRO
INSERT INTO parametro([id],[nombre],[id_inspeccion]) VALUES(1,'Fusce Mollis Duis Corp.',29),(2,'Lorem Consulting',21),(3,'Dolor Fusce Feugiat LLP',20),(4,'Suspendisse Commodo Inc.',26),(5,'Elementum Purus Accumsan PC',42),(6,'Dui Lectus Rutrum Industries',3),(7,'Nec Inc.',24),(8,'Integer Urna Company',44),(9,'Arcu Curabitur Ut Corp.',33),(10,'Cursus Integer Limited',47);


--PUTOS DE MEDICION
INSERT INTO puntos_medicion([id],[nombre],[id_inspeccion]) VALUES(1,'R1',1),(2,'R2',40),(3,'R3',13),(4,'R4',47),(5,'R5',36),(6,'R6',18),(7,'R7',1),(8,'R8',16),(9,'R9',25),(10,'R10',38);

--EQUIPO DE INSPECCION
INSERT INTO equipo_inspeccion([no_serie],[nombre],[marca],[modelo],[fecha_calibracion],[certificado_calibracion]) VALUES(1,'Montes Incorporated','Imperdiet Nec Ltd','U6F 0A2','04/12/19','TZO11DGR8CB'),(2,'Rutrum Fusce Dolor Incorporated','Nunc Consulting','H1T 7G4','01/12/19','XDW33ZLR5VH'),(3,'Posuere Industries','Consectetuer Corp.','G2E 1V9','11/04/19','HLA45ARH6VW'),(4,'Cras Sed PC','Primis In Company','C1R 1B8','29/12/19','SNQ53KPR0LJ'),(5,'Tellus Non PC','Diam Pellentesque Habitant Incorporated','Q3F 9Z8','10/04/19','IMG26UKB9AH'),(6,'Ipsum Consulting','Congue In Associates','D7M 6Y9','12/03/19','LJX44OIO6ON'),(7,'Ut Tincidunt Orci Foundation','Suspendisse Sagittis Nullam Corp.','Z1U 0L2','12/11/18','KTI26XPL5MP'),(8,'Neque Inc.','Diam Lorem Auctor Incorporated','M3N 6K3','29/11/18','FFM35OVH4RI'),(9,'Egestas Nunc Sed Inc.','Felis Orci Adipiscing Institute','Z6I 6R1','30/04/19','XIW75ELM2DM'),(10,'Dolor Tempus Non Company','Luctus Aliquet Odio LLC','N0F 6F2','29/04/20','CPF04BJQ3CI');
INSERT INTO equipo_inspeccion([no_serie],[nombre],[marca],[modelo],[fecha_calibracion],[certificado_calibracion]) VALUES(11,'Ut Semper Corp.','Faucibus Id Libero Institute','H2L 5J0','02/05/20','CBY19DQQ6ND'),(12,'Magnis Dis Incorporated','Donec Consulting','O0C 8W4','19/09/19','JEE62RTJ6XY'),(13,'Non Consulting','Purus Sapien Corporation','I1I 2O9','12/12/18','TDR48ZEI4XS'),(14,'Enim Industries','Erat Vel Inc.','H2X 2T4','30/04/20','YPO84RDX6MB'),(15,'Sed PC','Facilisis Limited','G5Z 0H1','16/09/18','PFU64EMF3DG'),(16,'Libero Mauris Aliquam Incorporated','Tempor Bibendum Donec Industries','V1J 6W6','04/01/19','TAX19JPS6XY'),(17,'Vel LLC','Eu Ligula Aenean Foundation','D2A 7Z0','19/07/19','BWB33KDZ0PT'),(18,'Eu Nulla At Institute','Nec Leo Foundation','K6O 6T4','08/09/18','JSM23HNH1QE'),(19,'Duis Ac Foundation','Facilisi Sed Neque Corporation','B9T 8X9','10/06/20','DSI50OZS4YI'),(20,'Ac Feugiat Non Foundation','Aenean Euismod Associates','V7P 1M8','03/12/19','JHU84TPH3OB');

--INSXEI
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(1,9),(2,7),(3,5),(4,5),(5,15),(6,20),(7,3),(8,14),(9,14),(10,18);
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(11,10),(12,6),(13,8),(14,11),(15,16),(16,20),(17,7),(18,11),(19,14),(20,20);
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(21,6),(22,9),(23,17),(24,2),(25,20),(26,15),(27,15),(28,1),(29,10),(30,19);
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(31,1),(32,3),(33,15),(34,16),(35,14),(36,20),(37,1),(38,4),(39,20),(40,12);
INSERT INTO INSXEI([id_ins],[id_ei]) VALUES(41,15),(42,8),(43,14),(44,19),(45,1),(46,12),(47,8),(48,4),(49,7),(50,6);


--ACCESORIOS EQUIPO INSPECCION
INSERT INTO accesorios_ins([id],[nombre],[id_equipo_inspeccion]) VALUES(1,'Ante Consulting',17),(2,'Non Enim PC',8),(3,'Mi Fringilla Corporation',17),(4,'Ipsum Suspendisse Non Consulting',18),(5,'Posuere Cubilia Curae; Foundation',7),(6,'Elit LLC',01),(7,'Ipsum Incorporated',10),(8,'Eros Non Corporation',3),(9,'Sagittis Felis LLC',1),(10,'Egestas Nunc Industries',12);
INSERT INTO accesorios_ins([id],[nombre],[id_equipo_inspeccion]) VALUES(11,'Mauris LLP',5),(12,'Ultricies Adipiscing PC',3),(13,'Egestas Corp.',11),(14,'Dolor Nonummy Industries',7),(15,'Vitae Erat Institute',1),(16,'Duis Dignissim Tempor Industries',5),(17,'Tellus Id Associates',4),(18,'Nascetur Ridiculus Company',8),(19,'Mus Aenean Eget LLP',19),(20,'Luctus Sit Amet Company',16);
INSERT INTO accesorios_ins([id],[nombre],[id_equipo_inspeccion]) VALUES(21,'Rutrum Lorem Corporation',17),(22,'Scelerisque Scelerisque Industries',20),(23,'Quam Curabitur Vel Foundation',3),(24,'Ante Dictum Institute',15),(25,'Ut Sagittis Lobortis Industries',17),(26,'Ornare Facilisis Corporation',8),(27,'Consequat Corp.',17),(28,'Ullamcorper Magna Inc.',11),(29,'Nulla Ante Ltd',13),(30,'Eget Corp.',13);
INSERT INTO accesorios_ins([id],[nombre],[id_equipo_inspeccion]) VALUES(31,'Hendrerit Institute',12),(32,'Nulla Dignissim Maecenas Ltd',10),(33,'Mi Pede Nonummy Consulting',15),(34,'Vestibulum Accumsan Neque Foundation',13),(35,'Fermentum Arcu Foundation',14),(36,'Penatibus Foundation',14),(37,'Eu Elit Industries',5),(38,'Duis Volutpat Nunc Ltd',06),(39,'Elit Sed Consequat Corporation',3),(40,'Lectus Institute',19);

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












