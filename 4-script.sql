
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









