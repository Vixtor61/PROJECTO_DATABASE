CREATE TABLE municipio(
	id INT NOT NULL,
	nombre VARCHAR(20)
	CONSTRAINT pk_municipio PRIMARY KEY (id)
	);

	

CREATE TABLE hospital(
	id INT NOT NULL,
	nombre VARCHAR(20),
	direccion VARCHAR(50),
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

CREATE TABLE accesorios(
	id INT NOT NULL,
	nombre VARCHAR(20),
	id_equipoMedico INT,
	CONSTRAINT pk_accesorios PRIMARY KEY (id),
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
	id INT NOT NULL,
	nombre VARCHAR(20),
	id_equipoMedico INT,
	CONSTRAINT pk_tipoEM PRIMARY KEY (id),
	CONSTRAINT fk_equipo__medico FOREIGN KEY(id_equipoMedico) REFERENCES equipo_medico(numero_serie)
	);


