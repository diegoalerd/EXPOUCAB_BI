create database ExpoUCABtransaccional;

Use ExpoUCABtransaccional;

CREATE TABLE Pais ( 
    cod_pais Int IDENTITY(1,1),
	nb_pais varchar(30) NOT NULL UNIQUE,
    CONSTRAINT cod_pais_PK PRIMARY KEY (cod_pais) 
);


CREATE TABLE Ciudad ( 
    cod_ciudad Int IDENTITY(1,1),
	nb_ciudad varchar(30) NOT NULL UNIQUE,
	cod_pais Int  NOT NULL,
    CONSTRAINT cod_ciudad_PK PRIMARY KEY (cod_ciudad),
	CONSTRAINT cod_pais_FK FOREIGN KEY (cod_pais) REFERENCES	Pais(cod_pais)
);

CREATE TABLE Sede ( 
    cod_sede Int IDENTITY(1,1),
	nb_sede varchar(30) NOT NULL UNIQUE,
	cod_ciudad Int NOT NULL
    CONSTRAINT cod_sede_PK PRIMARY KEY (cod_sede),
	CONSTRAINT cod_ciudad_FK FOREIGN KEY (cod_ciudad) REFERENCES Ciudad(cod_ciudad)
);


CREATE TABLE Tipo_Evento ( 
    cod_tipo_evento Int IDENTITY(1,1),
	nb_tipo_evento varchar(30) NOT NULL,
    CONSTRAINT cod_tipo_evento_PK PRIMARY KEY (cod_tipo_evento),
	CONSTRAINT nb_tipo_evento_Domain CHECK ((nb_tipo_evento='Feria') OR (nb_tipo_evento='Bazar') OR (nb_tipo_evento='Exposicion')),
);

CREATE TABLE Evento ( 
    cod_evento Int IDENTITY(1,1),
	nb_evento varchar(30) NOT NULL,
	fecha_incio Date NOT NULL,
	fecha_fin Date NOT NULL,
	descripcion varchar(255) NOT NULL,
	cod_sede Int NOT NULL,
	email varchar(255) NOT NULL,
	cod_tipo_evento Int NOT NULL,

    CONSTRAINT cod_evento_PK PRIMARY KEY (cod_evento),
	CONSTRAINT cod_sede_FK FOREIGN KEY (cod_sede) REFERENCES Sede(cod_sede),
	CONSTRAINT cod_tipo_evento_FK FOREIGN KEY (cod_tipo_evento) REFERENCES Tipo_Evento(cod_tipo_evento),

);

CREATE TABLE Tipo_Stand ( 
    cod_tipo_stand Int IDENTITY(1,1),
	nb_tipo_stand varchar(30) NOT NULL,
    CONSTRAINT cod_tipo_stand_PK PRIMARY KEY (cod_tipo_stand),
	CONSTRAINT nb_tipo_stand_Domain CHECK ((nb_tipo_stand='Minima') OR (nb_tipo_stand='Estandar') OR (nb_tipo_stand='Maxima')OR (nb_tipo_stand='Ajustable')),
);

CREATE TABLE Evento_Stand ( 
    cod_evento Int NOT NULL,
	cod_stand Int NOT NULL,
	cantidad_estimada Int NOT NULL,
	mts2 Int NOT NULL,
	precio Int NOT NULL,

    CONSTRAINT cod_evento_stand_PK PRIMARY KEY (cod_evento, cod_stand),
	CONSTRAINT cod_evento_FK FOREIGN KEY (cod_evento) REFERENCES Evento(cod_evento),
	CONSTRAINT cod_stand_FK FOREIGN KEY (cod_stand) REFERENCES Tipo_Stand(cod_tipo_stand),
);


CREATE TABLE Categoria ( 
    cod_categoria Int IDENTITY(1,1),
	nb_categoria varchar(30) NOT NULL,
    CONSTRAINT cod_categoria_PK PRIMARY KEY (cod_categoria),
	CONSTRAINT nb_categoria_Domain CHECK ((nb_categoria='Comida') OR (nb_categoria='Ropa y Calzado') OR (nb_categoria='Deporte')),
);

CREATE TABLE SubCategoria ( 
    cod_sub_categoria Int IDENTITY(1,1),
	nb_sub_categoria varchar(30) NOT NULL,
	cod_categoria Int NOT NULL,

    CONSTRAINT cod_sub_categoria_PK PRIMARY KEY (cod_sub_categoria),
	CONSTRAINT cod_categoria_FK FOREIGN KEY (cod_categoria) REFERENCES Categoria(cod_categoria),
	CONSTRAINT nb_SubCategoria_Domain CHECK ((nb_sub_categoria='Postres y Dulces') OR (nb_sub_categoria='Hamburguesas') OR (nb_sub_categoria='Ropa de Ninos')OR (nb_sub_categoria='Ropa Para Damas')),
);

CREATE TABLE Cliente ( 
    cod_cliente Int IDENTITY(1,1),
	nb_cliente varchar(30) NOT NULL,
	ci_rif varchar(30) NOT NULL UNIQUE,
	telefono varchar(30) NOT NULL,
	direccion varchar(255) NOT NULL,
	email varchar(30) NOT NULL,

    CONSTRAINT cod_cliente_PK PRIMARY KEY (cod_cliente),
);



CREATE TABLE Contrato ( 
    nro_stand Int IDENTITY(1,1),
	cod_evento Int NOT NULL,
	cod_tipo_stand Int NOT NULL,
	fecha_alquiler Date NOT NULL,
	mts2 Int NOT NULL,
	monto Int NOT NULL,

	cod_cliente Int NOT NULL,
	cod_sub_categoria Int NOT NULL,

    CONSTRAINT Contrato_PK PRIMARY KEY (nro_stand,cod_evento, cod_tipo_stand  ),
	CONSTRAINT cod_cliente_FK FOREIGN KEY (cod_cliente) REFERENCES Cliente(cod_cliente),
	CONSTRAINT cod_sub_categoria_FK FOREIGN KEY (cod_sub_categoria) REFERENCES SubCategoria(cod_sub_categoria),
);


CREATE TABLE Visitante ( 
    cod_visitante Int IDENTITY(1,1),
	cedula Int NOT NULL,
	nb_visitante varchar(30) NOT NULL,
	sexo char,
	email varchar(30) NOT NULL,
    CONSTRAINT cod_visitante_PK PRIMARY KEY (cod_visitante),
	CONSTRAINT sexo_Domain CHECK ((sexo='M') OR (sexo='F')),
);



CREATE TABLE LeyendaEstrellas ( 
    cod_leyenda_estrellas Int IDENTITY(1,1),
	nb_descripcion varchar(255) NOT NULL,

    CONSTRAINT cod_leyenda_estrellas_PK PRIMARY KEY (cod_leyenda_estrellas),
	CONSTRAINT nb_descripcion_Domain CHECK ((nb_descripcion='Malo') OR (nb_descripcion='Regular') OR (nb_descripcion='Bueno') OR (nb_descripcion='Muy Bueno')OR (nb_descripcion='Excelente')),
);

CREATE TABLE Entrada ( 
    nro_entrada Int IDENTITY(1,1),
	cod_evento Int NOT NULL,
	fecha_entrada Date NOT NULL,
	hora_entrada Time NOT NULL,
	cod_visitante int NOT NULL,
	recomienda_amigo char NOT NULL,
	calificacion int,
	cod_leyenda_estrellas int,

    CONSTRAINT nro_entrada_PK PRIMARY KEY (nro_entrada),
	CONSTRAINT cod_evento_Entrada_FK FOREIGN KEY (cod_evento) REFERENCES Evento(cod_evento),
	CONSTRAINT cod_visitante_FK FOREIGN KEY (cod_visitante) REFERENCES Visitante(cod_visitante),
	CONSTRAINT cod_leyenda_estrellas_FK FOREIGN KEY (cod_leyenda_estrellas) REFERENCES LeyendaEstrellas(cod_leyenda_estrellas),

);






Use ExpoUCABtransaccional;

CREATE TABLE DIM_SEDE ( 
    sk_sede Int IDENTITY(1,1),
	cod_pais Int  NOT NULL,
	nb_pais varchar(100) NOT NULL,
	cod_ciudad Int NOT NULL,
	nb_ciudad varchar(100) NOT NULL,
	cod_sede Int NOT NULL,
	nb_sede varchar(100) NOT NULL,
    CONSTRAINT sk_sede_PK PRIMARY KEY (sk_sede) 
);


CREATE TABLE DIM_LEYENDA ( 
    sk_leyenda Int IDENTITY(1,1),
	cod_leyenda Int  NOT NULL,
	nb_pais varchar(100) NOT NULL,
    CONSTRAINT sk_leyeda_PK PRIMARY KEY (sk_leyenda),
);

CREATE TABLE DIM_VISITANTE ( 
    sk_visitante Int IDENTITY(1,1),
	cod_visitante Int NOT NULL,
	cedula Int NOT NULL,
	nb_visitante varchar(100) NOT NULL,
	sexo varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
    CONSTRAINT sk_visitante_PK PRIMARY KEY (sk_visitante),
	CONSTRAINT sexo_Domain_visitante CHECK ((sexo='M') OR (sexo='F'))
);


CREATE TABLE DIM_EVENTO ( 
	sk_evento Int IDENTITY(1,1),
    cod_tipo_evento Int NOT NULL,
	nb_tipo_evento varchar(100) NOT NULL,
	cod_evento Int NOT NULL,
	nb_evento varchar(100) NOT NULL,
	descripcion varchar(100) NOT NULL,
    CONSTRAINT sk_evento_PK PRIMARY KEY (sk_evento),
	CONSTRAINT nb_tipo_evento_Domain_Dim CHECK ((nb_tipo_evento='Feria') OR (nb_tipo_evento='Bazar') OR (nb_tipo_evento='Exposicion')),
);

CREATE TABLE DIM_TIPO_STAND ( 
	sk_tipo_stand Int IDENTITY(1,1),
    cod_tipo_stand Int NOT NULL,
	nb_tipo_stand varchar(30) NOT NULL,
    CONSTRAINT sk_tipo_stand_PK_ PRIMARY KEY (sk_tipo_stand),
	CONSTRAINT nb_tipo_stand_Domain_Dim CHECK ((nb_tipo_stand='Minima') OR (nb_tipo_stand='Estandar') OR (nb_tipo_stand='Maxima')OR (nb_tipo_stand='Ajustable')),
);

CREATE TABLE DIM_TIEMPO ( 
	sk_tiempo Int IDENTITY(1,1),
    cod_anio Int NOT NULL,
	cod_trimestre Int NOT NULL,
	des_trimestre varchar(100) NOT NULL,
	cod_mes Int NOT NULL,
	desc_mes varchar(100) NOT NULL,
	desc_mes_corta varchar(100) NOT NULL,
	cod_semana Int NOT NULL,
	cod_dia_anio Int NOT NULL,
	cod_dia_mes Int NOT NULL,
	cod_dia_semana Int NOT NULL,
	desc_dia_semana varchar(30) NOT NULL,
	fecha Date NOT NULL

    CONSTRAINT sk_tiempo_PK PRIMARY KEY (sk_tiempo),
);


CREATE TABLE DIM_CLIENTE ( 
	sk_cliente Int IDENTITY(1,1),
    cod_cliente Int NOT NULL,
	nb_cliente varchar(30) NOT NULL,
	ci_rif varchar(30) NOT NULL,
	telefono BIGINT NOT NULL,
	direccion varchar(255) NOT NULL,
	email varchar(30) NOT NULL,

    CONSTRAINT sk_cliente_PK PRIMARY KEY (sk_cliente),
);

CREATE TABLE DIM_CATEGORIA ( 
	sk_categoria Int IDENTITY(1,1),
    cod_sub_categoria Int NOT NULL,
	nb_sub_categoria varchar(30) NOT NULL,
	cod_categoria Int NOT NULL,
	nb_categoria varchar(30) NOT NULL,
    CONSTRAINT sk_categoria_PK PRIMARY KEY (sk_categoria),
	CONSTRAINT nb_SubCategoria_Domain_Dim CHECK ((nb_sub_categoria='Postres y Dulces') OR (nb_sub_categoria='Hamburguesas') OR (nb_sub_categoria='Ropa de Ninos')OR (nb_sub_categoria='Ropa Para Damas')),
);

CREATE TABLE FACT_EVENTO ( 
	sk_evento Int NOT NULL,
	sk_sede Int NOT NULL,
	sk_fec_evento Int NOT NULL,
    
	cantidad_evento Int NOT NULL DEFAULT 1,
	cantidad_estim_visitantes Int NOT NULL  DEFAULT 35,
	META_INGRESO decimal(10,4) NOT NULL DEFAULT 1850,

	CONSTRAINT sk_fact_evento_PK PRIMARY KEY (sk_evento, sk_sede, sk_fec_evento),

	CONSTRAINT sk_fact_evento_FK FOREIGN KEY (sk_evento) REFERENCES DIM_EVENTO(sk_evento),
	CONSTRAINT sk_sede_FK FOREIGN KEY (sk_sede) REFERENCES DIM_SEDE(sk_sede),
	CONSTRAINT sk_fec_evento_FK FOREIGN KEY (sk_fec_evento) REFERENCES DIM_TIEMPO(sk_tiempo),

	);

	CREATE TABLE FACT_VISITA ( 
	sk_evento Int NOT NULL,
	sk_visitante Int NOT NULL,
	sk_fec_entrada Int NOT NULL,
	sk_leyenda_estrellas Int NOT NULL,
	num_entrada Int,
	
    
	hora_entrada datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	cantidad_visita Int NOT NULL DEFAULT 1,
	calificacion varchar(100) NOT NULL,
	recomienda_amigo varchar(100) NOT NULL,

	CONSTRAINT sk_fact_visita_PK PRIMARY KEY (sk_evento, sk_visitante, sk_fec_entrada, sk_leyenda_estrellas, num_entrada),

	CONSTRAINT sk_fact_visita_evento_FK FOREIGN KEY (sk_evento) REFERENCES DIM_EVENTO(sk_evento),
	CONSTRAINT sk_visitante_FK FOREIGN KEY (sk_visitante) REFERENCES DIM_VISITANTE(sk_visitante),
	CONSTRAINT sk_fec_entrada_FK FOREIGN KEY (sk_fec_entrada) REFERENCES DIM_TIEMPO(sk_tiempo),
	CONSTRAINT sk_fact_visita_leyenda_estrellas_FK FOREIGN KEY (sk_leyenda_estrellas) REFERENCES DIM_LEYENDA(sk_leyenda),

	CONSTRAINT calificacion_Domain_Fact CHECK ((calificacion='Malo') OR (calificacion='Regular') OR (calificacion='Bueno')OR (calificacion='Muy Bueno') OR (calificacion='Excelente')),

	);

	CREATE TABLE FACT_EVENTO_STAND ( 
	sk_evento Int NOT NULL,
	sk_tipo_stand Int NOT NULL,
    
	cantidad_estimada Int NOT NULL,
	mt2 decimal(10,4) NOT NULL,
	precio decimal(10,4) NOT NULL,

	CONSTRAINT sk_fact_evento_stand_PK PRIMARY KEY (sk_evento, sk_tipo_stand),

	CONSTRAINT sk_fact_evento_stand_evento_FK FOREIGN KEY (sk_evento) REFERENCES DIM_EVENTO(sk_evento),
	CONSTRAINT sk_fact_evento_stand_tipo_stand_FK FOREIGN KEY (sk_tipo_stand) REFERENCES DIM_TIPO_STAND(sk_tipo_stand),

	);

	CREATE SEQUENCE Seq_Alquiler_num_stand
    START WITH 1
    INCREMENT BY 1 ;
	GO

	CREATE TABLE FACT_ALQUILER ( 
	sk_evento Int NOT NULL,
	sk_cliente Int NOT NULL,
	sk_fec_alquiler Int NOT NULL,
	sk_tipo_stand Int NOT NULL,
	sk_categoria Int NOT NULL,
	num_contrato Int NOT NULL DEFAULT (NEXT VALUE FOR Seq_Alquiler_num_stand),
	num_stand Int NOT NULL,
    
	cantidad Int NOT NULL DEFAULT 1,
	mt2 decimal(10,4) NOT NULL,
	precio decimal(10,4) NOT NULL,

	CONSTRAINT sk_fact_alquiler_PK PRIMARY KEY (sk_evento, sk_cliente, sk_fec_alquiler, sk_tipo_stand, sk_categoria, num_contrato, num_stand),

	CONSTRAINT sk_evento_alquiler_FK FOREIGN KEY (sk_evento) REFERENCES DIM_EVENTO(sk_evento),
	CONSTRAINT sk_cliente_FK FOREIGN KEY (sk_cliente) REFERENCES DIM_CLIENTE(sk_cliente),
	CONSTRAINT sk_fec_alquiler_FK FOREIGN KEY (sk_fec_alquiler) REFERENCES DIM_TIEMPO(sk_tiempo),
	CONSTRAINT sk_fact_alquiler_tipo_stand_FK FOREIGN KEY (sk_tipo_stand) REFERENCES DIM_TIPO_STAND(sk_tipo_stand),
	CONSTRAINT sk_categoria_FK FOREIGN KEY (sk_categoria) REFERENCES DIM_CATEGORIA(sk_categoria),

	);





	


Use ExpoUCABtransaccional;

INSERT INTO Pais values ('Venezuela');
insert into Pais (nb_pais) values ('Indonesia');
insert into Pais (nb_pais) values ('Ucrania');
insert into Pais (nb_pais) values ('Canada');
insert into Pais (nb_pais) values ('Colombia');
insert into Pais (nb_pais) values ('Ecuador');
insert into Pais (nb_pais) values ('Brazil');
insert into Pais (nb_pais) values ('Republica Dominicana');
insert into Pais (nb_pais) values ('Guadeloupe');
insert into Pais (nb_pais) values ('Japan');


insert into Ciudad (nb_ciudad, cod_pais) values ('Valencia', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('Barquisimeto', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('Maracaibo', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('Caracas', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('Puerto La Cruz', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('Lecheria', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('San Cristobal', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('Margarita', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('San Fernando', 1);
insert into Ciudad (nb_ciudad, cod_pais) values ('Bogota', 5);
insert into Ciudad (nb_ciudad, cod_pais) values ('Medellin', 5);
insert into Ciudad (nb_ciudad, cod_pais) values ('Cali', 5);
insert into Ciudad (nb_ciudad, cod_pais) values ('Punta Cana', 8);
insert into Ciudad (nb_ciudad, cod_pais) values ('Santo Domingo', 8);
insert into Ciudad (nb_ciudad, cod_pais) values ('Quito', 7);
insert into Ciudad (nb_ciudad, cod_pais) values ('Liskov', 4);
insert into Ciudad (nb_ciudad, cod_pais) values ('Indoon', 4);
insert into Ciudad (nb_ciudad, cod_pais) values ('Brasilia', 8);
insert into Ciudad (nb_ciudad, cod_pais) values ('Tokio', 10);
insert into Ciudad (nb_ciudad, cod_pais) values ('Jagupit', 10);





insert into Sede (nb_sede, cod_ciudad) values ('Hoard', 1);
insert into Sede (nb_sede, cod_ciudad) values ('Village Green', 1);
insert into Sede (nb_sede, cod_ciudad) values ('Claremont', 2);
insert into Sede (nb_sede, cod_ciudad) values ('Farmco', 2);
insert into Sede (nb_sede, cod_ciudad) values ('Arapahoe', 3);
insert into Sede (nb_sede, cod_ciudad) values ('Towne', 3);
insert into Sede (nb_sede, cod_ciudad) values ('Bashford', 4);
insert into Sede (nb_sede, cod_ciudad) values ('Kingsford', 4);
insert into Sede (nb_sede, cod_ciudad) values ('American Ash', 5);
insert into Sede (nb_sede, cod_ciudad) values ('Cambridge', 5);
insert into Sede (nb_sede, cod_ciudad) values ('Hollow Ridge', 6);
insert into Sede (nb_sede, cod_ciudad) values ('Stephen', 6);
insert into Sede (nb_sede, cod_ciudad) values ('Killdeer', 7);
insert into Sede (nb_sede, cod_ciudad) values ('Moulton', 7);
insert into Sede (nb_sede, cod_ciudad) values ('Loomis', 10);
insert into Sede (nb_sede, cod_ciudad) values ('Lighthouse Bay', 11);
insert into Sede (nb_sede, cod_ciudad) values ('Annamark', 12);
insert into Sede (nb_sede, cod_ciudad) values ('Shoshone', 13);
insert into Sede (nb_sede, cod_ciudad) values ('Gulseth', 14);
insert into Sede (nb_sede, cod_ciudad) values ('Pine View', 20);

insert into Sede (nb_sede, cod_ciudad) values ('Clarendon', 1);
insert into Sede (nb_sede, cod_ciudad) values ('Parkside', 2);
insert into Sede (nb_sede, cod_ciudad) values ('Dayton', 3);
insert into Sede (nb_sede, cod_ciudad) values ('Redwing', 4);
insert into Sede (nb_sede, cod_ciudad) values ('Arrowood', 5);
insert into Sede (nb_sede, cod_ciudad) values ('Nancy', 6);
insert into Sede (nb_sede, cod_ciudad) values ('Pearson', 7);
insert into Sede (nb_sede, cod_ciudad) values ('Texas', 8);
insert into Sede (nb_sede, cod_ciudad) values ('8th', 9);
insert into Sede (nb_sede, cod_ciudad) values ('Elmside', 10);
insert into Sede (nb_sede, cod_ciudad) values ('Stuart', 11);
insert into Sede (nb_sede, cod_ciudad) values ('Morrow', 12);
insert into Sede (nb_sede, cod_ciudad) values ('Annamarkload', 13);
insert into Sede (nb_sede, cod_ciudad) values ('Homewood', 14);
insert into Sede (nb_sede, cod_ciudad) values ('Cottonwood', 15);
insert into Sede (nb_sede, cod_ciudad) values ('Carberry', 16);
insert into Sede (nb_sede, cod_ciudad) values ('Tennyson', 17);
insert into Sede (nb_sede, cod_ciudad) values ('Reinke', 18);
insert into Sede (nb_sede, cod_ciudad) values ('Melody', 19);
insert into Sede (nb_sede, cod_ciudad) values ('Continental', 20);



insert into Tipo_Evento (nb_tipo_evento) values ('Feria');
insert into Tipo_Evento (nb_tipo_evento) values ('Bazar');
insert into Tipo_Evento (nb_tipo_evento) values ('Exposicion');





insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Brickson Park', '1/22/2020', '1/25/2020', 'Orange', 1, 'ngoggan0@dyndns.org', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Novick', '2/10/2020', '2/28/2020', 'Maroon', 2, 'rtarver1@usgs.gov', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Steensland', '3/2/2020', '3/8/2020', 'Goldenrod', 3, 'tsteljes2@sciencedirect.com', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Harbort', '4/16/2020', '4/30/2020', 'Red', 4, 'jkix3@google.com.hk', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('West', '5/1/2020', '5/9/2020', 'Goldenrod', 5, 'zspraberry4@mtv.com', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Derek', '6/10/2020', '6/14/2020', 'Indigo', 6, 'squiddinton5@yahoo.co.jp', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Anhalt', '7/9/2020', '7/18/2020', 'Goldenrod', 7, 'ppakenham6@angelfire.com', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Montana', '8/6/2020', '8/24/2020', 'Red', 8, 'imushett7@ucla.edu', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Grasskamp', '9/11/2020', '9/7/2020', 'Fuscia', 9, 'spacey8@symantec.com', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('4th', '12/10/2020', '12/28/2020', 'Khaki', 10, 'sliebrecht9@ucoz.ru', 2);

insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Gerald', '1/10/2021', '1/14/2021', 'Goldenrod', 11, 'gpopplestonea@google.co.jp', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Dexter', '2/5/2021', '2/13/2021', 'Pink', 12, 'pjobkeb@blogs.com', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Paget', '3/7/2021', '3/23/2021', 'Blue', 13, 'cboshardc@utexas.edu', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Towne', '4/1/2021', '4/9/2021', 'Indigo', 14, 'porteltd@elegantthemes.com', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Lakewood Gardens', '5/17/2021', '5/20/2021', 'Purple', 15, 'smuzzinie@apple.com', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Vahlen', '6/16/2021', '6/28/2021', 'Turquoise', 16, 'slawlerf@symantec.com', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Montana', '7/17/2021', '7/28/2021', 'Yellow', 17, 'tlinkeg@ow.ly', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Hermina', '8/14/2021', '8/22/2021', 'Maroon', 18, 'wbarrimh@youku.com', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Dawn', '9/16/2021', '9/21/2021', 'Fuscia', 19, 'flystei@eepurl.com', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Heffernan', '10/15/2021', '10/17/2021', 'Pink', 20, 'dfyldesj@noaa.gov', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Nelson', '11/26/2021', '11/30/2021', 'Maroon', 1, 'cparkek@spotify.com', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Miller', '12/23/2021', '12/27/2021', 'Purple', 20, 'clourencol@arizona.edu', 2);

insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Loomis', '1/28/2022', '2/16/2022', 'Yellow', 1, 'wgrzesiak0@marriott.com', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Talisman', '1/5/2022', '1/16/2022', 'Violet', 2, 'dbestiman1@cloudflare.com', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Spenser', '2/4/2022', '2/15/2022', 'Violet', 3, 'aodornan2@biblegateway.com', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Meadow Vale', '2/14/2022', '2/18/2022', 'Turquoise', 4, 'imckeveney3@paginegialle.it', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Superior', '3/7/2022', '3/12/2022', 'Violet', 5, 'llooks4@wikia.com', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Algoma', '4/8/2022', '4/20/2022', 'Green', 6, 'rkadwallider5@wired.com', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Mendota', '4/20/2022', '4/30/2022', 'Puce', 7, 'jkonke6@people.com.cn', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Washington', '5/25/2022', '6/10/2022', 'Mauv', 8, 'smilligan7@nsw.gov.au', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Garrison', '6/1/2022', '6/8/2022', 'Purple', 9, 'ccordes8@wired.com', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Sage', '5/7/2022', '5/16/2022', 'Yellow', 10, 'dguidoni9@diigo.com', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Luster', '4/7/2022', '4/30/2022', 'Orange', 11, 'aandrejevica@gizmodo.com', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Tennessee', '3/13/2022', '3/24/2022', 'Orange', 12, 'atrazzib@japanpost.jp', 3);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Loomis', '3/19/2022', '3/27/2022', 'Fuscia', 13, 'nkenwellc@army.mil', 1);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('American Ash', '5/18/2022', '6/13/2022', 'Blue', 14, 'cdefilippod@360.cn', 2);
insert into Evento (nb_evento, fecha_incio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) values ('Anthes', '2/13/2022', '2/18/2022', 'Pink', 15, 'ttourote@storify.com', 3);




insert into Tipo_Stand (nb_tipo_stand) values ('Minima');
insert into Tipo_Stand (nb_tipo_stand) values ('Estandar');
insert into Tipo_Stand (nb_tipo_stand) values ('Maxima');
insert into Tipo_Stand (nb_tipo_stand) values ('Ajustable');




insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (1, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (1, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (1, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (1, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (2, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (2, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (2, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (2, 4, 6, 30, 160);


insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (3, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (3, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (3, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (3, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (4, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (4, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (4, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (4, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (5, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (5, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (5, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (5, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (6, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (6, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (6, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (6, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (7, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (7, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (7, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (7, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (8, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (8, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (8, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (8, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (9, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (9, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (9, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (9, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (10, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (10, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (10, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (10, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (11, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (11, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (11, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (11, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (12, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (12, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (12, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (12, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (13, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (13, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (13, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (13, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (14, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (14, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (14, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (14, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (15, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (15, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (15, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (15, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (16, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (16, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (16, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (16, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (17, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (17, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (17, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (17, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (18, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (18, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (18, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (18, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (19, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (19, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (19, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (19, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (20, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (20, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (20, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (20, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (21, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (21, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (21, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (21, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (22, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (22, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (22, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (22, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (23, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (23, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (23, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (23, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (24, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (24, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (24, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (24, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (25, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (25, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (25, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (25, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (26, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (26, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (26, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (26, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (27, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (27, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (27, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (27, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (28, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (28, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (28, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (28, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (29, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (29, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (29, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (29, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (30, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (30, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (30, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (30, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (31, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (31, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (31, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (31, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (32, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (32, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (33, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (34, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (35, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (35, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (35, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (35, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (36, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (36, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (36, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (36, 4, 6, 30, 160);

insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (37, 1, 10, 15, 100);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (37, 2, 8, 20, 120);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (37, 3, 7, 25, 140);
insert into Evento_Stand (cod_evento, cod_stand, cantidad_estimada, mts2, precio) values (37, 4, 6, 30, 160);






insert into Categoria (nb_categoria) values ('Comida');
insert into Categoria (nb_categoria) values ('Ropa y Calzado');
insert into Categoria (nb_categoria) values ('Deporte');






insert into SubCategoria (nb_sub_categoria, cod_categoria) values ('Postres y Dulces', 1);
insert into SubCategoria (nb_sub_categoria, cod_categoria) values ('Hamburguesas', 1);
insert into SubCategoria (nb_sub_categoria, cod_categoria) values ('Ropa de Ninos', 2);
insert into SubCategoria (nb_sub_categoria, cod_categoria) values ('Ropa Para Damas', 2);



insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Hunt', 'V10547436', '5202950838', '348 Boyd Point', 'hhallford0@dailymail.co.uk');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Breena', 'V10547459', '5202950835', '53 Center Junction', 'bcarff1@opensource.org');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Alaine', 'V10547458', '5437054748', '2653 Lawn Court', 'amathivon2@ameblo.jp');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Yolanda', 'V10547457', '9687869817', '5 Eastwood Plaza', 'ylammerts3@fda.gov');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Berti', 'V10547456', '2338948526', '5 Express Park', 'bbezarra4@weather.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Tabbitha', 'V10547455', '3407557567', '93659 Tony Avenue', 'tjodkowski5@paypal.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Douglass', 'V10547454', '3028394839', '0554 Chive Court', 'dtayspell6@xing.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Krishna', 'V10547453', '4176485454', '00733 Tennyson Drive', 'kplester7@sphinn.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Brnaba', 'V10547452', '2274519093', '54 Nevada Court', 'bwilse8@tripod.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Johan', 'V10547451', '7551874898', '5364 Bashford Plaza', 'jgamett9@tinyurl.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Robbie', 'V10547450', '5445095916', '1 Prentice Court', 'rbleythina@pagesporange.fr');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Gaynor', 'V10547449', '9893519529', '8 Delaware Point', 'gmorrottb@furl.net');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Herschel', 'V10547448', '7054498345', '1 Holy Cross Pass', 'hwhittickc@sakura.ne.jp');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Anatollo', 'V10547447', '1856875572', '99 Debra Street', 'ahendricksd@cafepress.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Cornelle', 'V10547446', '5654371525', '30 Acker Terrace', 'cguerolae@jugem.jp');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Katheryn', 'V10547445', '6387922814', '64 Prentice Place', 'kcullefordf@qq.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Beulah', 'V10547444', '3626162952', '29576 Dwight Pass', 'blesurfg@abc.net.au');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Fleur', 'V10547443', '3655838993', '1461 Forster Road', 'fandrzejczakh@prlog.org');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Mehetabel', 'V10547442', '8853561506', '01 Pepper Wood Parkway', 'mhanwayi@earthlink.net');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Tommi', 'V10547441', '3226840841', '3 Declaration Place', 'tsivillj@list-manage.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Hermia', 'J10547440', '1078801025', '22779 Elmside Center', 'hkenealyk@blogs.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Hyacinth', 'J10547439', '8399260441', '309 Dunning Center', 'hsleel@cbc.ca');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Ignatius', 'J10547438', '6649929272', '5041 Kinsman Street', 'iblunnm@baidu.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Trista', 'J10547437', '6148970548', '224 Derek Place', 'tmatzken@answers.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Bernadine', 'J10547436', '9773970606', '6148 Kipling Crossing', 'bedwardsono@mapquest.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Alissa', 'J10547435', '7383040676', '0 Scofield Point', 'abagnellp@networkad.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Margaretta', 'J10547434', '4187913863', '4832 Kensington Avenue', 'mastq@netvibes.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Alikee', 'J10547433', '4411173733', '43370 Fair Oaks Avenue', 'ahasemanr@latimes.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Moyra', 'J10547432', '8776792900', '777 Lighthouse Bay Way', 'mstonalls@discovery.com');
insert into Cliente (nb_cliente, ci_rif, telefono, direccion, email) values ('Astrix', 'J10547431', '3459027306', '2 4th Avenue', 'aurent@senate.gov');






insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 2, '1/16/2020', 22, 144, 8, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 2, '1/16/2020', 22, 142, 30, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 3, '1/20/2020', 30, 139, 23, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 3, '1/16/2020', 26, 150, 15, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 1, '1/18/2020', 20, 157, 5, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 4, '1/17/2020', 30, 135, 9, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 2, '1/20/2020', 27, 156, 16, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 4, '1/17/2020', 26, 107, 20, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 1, '1/17/2020', 17, 141, 23, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (1, 1, '1/16/2020', 23, 143, 21, 4);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 1, '2/1/2020', 16, 119, 5, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 4, '2/9/2020', 25, 130, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 1, '2/1/2020', 28, 111, 16, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 2, '2/6/2020', 18, 136, 25, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 1, '2/7/2020', 30, 107, 14, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 2, '2/1/2020', 25, 142, 30, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 3, '2/3/2020', 23, 136, 18, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 4, '2/2/2020', 29, 125, 14, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 4, '2/4/2020', 27, 139, 13, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (2, 3, '2/8/2020', 15, 121, 15, 1);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 2, '2/28/2020', 26, 155, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 4, '2/28/2020', 25, 134, 26, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 2, '2/26/2020', 21, 128, 5, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 1, '2/26/2020', 27, 110, 14, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 4, '2/26/2020', 19, 144, 4, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 3, '2/29/2020', 17, 131, 17, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 2, '2/27/2020', 17, 133, 15, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 1, '2/28/2020', 16, 118, 20, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 4, '2/27/2020', 22, 114, 9, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (3, 3, '3/1/2020', 30, 104, 22, 4);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 3, '4/1/2020', 22, 129, 11, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 1, '4/4/2020', 18, 142, 24, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 3, '4/13/2020', 27, 129, 30, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 2, '4/3/2020', 24, 110, 26, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 4, '4/4/2020', 17, 118, 28, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 1, '4/15/2020', 27, 128, 1, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 2, '4/6/2020', 29, 123, 26, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 2, '4/10/2020', 22, 142, 16, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 3, '4/1/2020', 26, 138, 5, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (4, 4, '4/11/2020', 21, 128, 15, 2);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 4, '4/25/2020', 23, 154, 27, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 4, '4/23/2020', 18, 109, 18, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 1, '4/28/2020', 21, 135, 16, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 3, '4/30/2020', 26, 140, 20, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 4, '4/28/2020', 30, 124, 10, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 2, '4/27/2020', 17, 131, 16, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 3, '4/28/2020', 29, 118, 28, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 3, '4/23/2020', 28, 125, 27, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 4, '4/23/2020', 19, 136, 28, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (5, 3, '4/28/2020', 24, 119, 15, 2);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 1, '5/20/2020', 20, 138, 7, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 1, '5/28/2020', 28, 142, 13, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 4, '5/26/2020', 22, 132, 4, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 2, '5/4/2020', 22, 159, 26, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 1, '5/11/2020', 24, 112, 5, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 1, '5/9/2020', 22, 130, 22, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 1, '5/4/2020', 16, 132, 9, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 2, '5/2/2020', 17, 103, 23, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 3, '5/25/2020', 29, 102, 18, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (6, 3, '6/6/2020', 28, 105, 17, 1);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 2, '7/3/2020', 20, 141, 1, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 4, '7/8/2020', 21, 157, 19, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 3, '7/4/2020', 30, 117, 25, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 3, '7/8/2020', 17, 137, 5, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 4, '7/1/2020', 17, 104, 28, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 2, '7/4/2020', 19, 150, 12, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 1, '7/3/2020', 26, 148, 20, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 4, '7/1/2020', 15, 149, 16, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 3, '7/7/2020', 30, 118, 14, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (7, 2, '7/3/2020', 15, 135, 4, 4);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 1, '7/31/2020', 30, 138, 13, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 3, '8/4/2020', 19, 113, 24, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 4, '7/22/2020', 25, 102, 6, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 1, '7/30/2020', 21, 115, 14, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 1, '7/23/2020', 23, 158, 6, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 2, '7/27/2020', 27, 159, 10, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 3, '7/22/2020', 29, 152, 18, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 3, '8/5/2020', 19, 110, 3, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 4, '8/5/2020', 17, 135, 20, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (8, 1, '7/25/2020', 20, 121, 7, 2);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 3, '8/27/2020', 16, 129, 21, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 1, '9/2/2020', 26, 134, 1, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 1, '8/31/2020', 18, 141, 9, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 2, '8/28/2020', 15, 103, 15, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 3, '9/9/2020', 16, 119, 3, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 1, '8/31/2020', 20, 134, 12, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 4, '9/6/2020', 30, 121, 8, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 4, '9/2/2020', 28, 142, 24, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 2, '9/2/2020', 19, 131, 25, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 3, '9/5/2020', 15, 142, 4, 1);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 3, '12/5/2020', 17, 135, 6, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 1, '12/7/2020', 23, 121, 26, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 1, '12/6/2020', 29, 146, 1, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 2, '12/3/2020', 21, 148, 30, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 2, '12/7/2020', 19, 157, 14, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 4, '11/29/2020', 24, 134, 12, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 4, '12/4/2020', 15, 159, 22, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 3, '12/6/2020', 30, 140, 3, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 2, '11/26/2020', 25, 102, 3, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (9, 4, '12/7/2020', 19, 148, 1, 1);

---2021---
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 4, '12/27/2020', 24, 118, 13, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 1, '12/10/2020', 18, 152, 28, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 4, '12/27/2020', 17, 111, 19, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 4, '1/4/2021', 27, 161, 13, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 4, '12/29/2020', 17, 124, 29, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 3, '12/31/2020', 23, 130, 13, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 2, '12/11/2020', 29, 137, 30, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 1, '12/16/2020', 27, 145, 2, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 3, '1/5/2021', 27, 131, 8, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (11, 1, '12/17/2020', 22, 166, 12, 1);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 3, '1/22/2021', 26, 153, 6, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 1, '1/22/2021', 27, 120, 17, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 4, '1/27/2021', 28, 166, 11, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 1, '1/21/2021', 30, 154, 18, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 3, '2/3/2021', 28, 114, 1, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 2, '1/29/2021', 20, 144, 17, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 1, '1/31/2021', 18, 152, 25, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 1, '2/3/2021', 23, 134, 21, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 1, '1/29/2021', 16, 154, 16, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (12, 2, '1/24/2021', 18, 159, 22, 4);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 1, '2/23/2021', 21, 133, 12, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 1, '3/2/2021', 15, 115, 30, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 2, '2/28/2021', 18, 113, 20, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 4, '2/28/2021', 30, 143, 26, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 3, '3/3/2021', 28, 145, 18, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 3, '3/5/2021', 30, 146, 7, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 1, '2/19/2021', 29, 122, 1, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 2, '3/1/2021', 30, 103, 11, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 3, '3/5/2021', 29, 151, 11, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (13, 1, '2/17/2021', 29, 137, 20, 1);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 4, '3/20/2021', 29, 117, 2, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 1, '3/17/2021', 24, 125, 5, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 2, '3/26/2021', 21, 147, 5, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 4, '3/27/2021', 26, 106, 19, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 2, '3/24/2021', 21, 111, 19, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 2, '3/23/2021', 29, 160, 10, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 2, '3/18/2021', 25, 161, 17, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 1, '3/15/2021', 30, 135, 25, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 1, '3/24/2021', 16, 130, 9, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (14, 4, '3/27/2021', 29, 158, 30, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 3, '4/16/2021', 18, 158, 11, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 1, '4/30/2021', 20, 105, 29, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 1, '4/30/2021', 20, 105, 29, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 1, '4/28/2021', 15, 148, 20, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 4, '4/10/2021', 24, 101, 6, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 4, '5/6/2021', 29, 116, 15, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 1, '5/15/2021', 20, 163, 5, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 1, '4/16/2021', 20, 142, 23, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 4, '5/13/2021', 20, 123, 6, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 4, '4/19/2021', 22, 145, 2, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (15, 2, '5/5/2021', 25, 167, 9, 2);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 2, '5/25/2021', 29, 101, 19, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 3, '6/12/2021', 28, 142, 27, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 1, '6/10/2021', 23, 167, 5, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 1, '6/8/2021', 30, 165, 14, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 3, '5/22/2021', 23, 165, 25, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 3, '5/27/2021', 22, 164, 28, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 1, '5/30/2021', 19, 118, 12, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 1, '6/12/2021', 16, 155, 19, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 1, '5/25/2021', 23, 129, 30, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (16, 1, '6/11/2021', 15, 108, 8, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 3, '6/24/2021', 29, 170, 13, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 2, '6/22/2021', 23, 111, 18, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 2, '6/18/2021', 25, 157, 15, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 2, '6/20/2021', 19, 160, 30, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 2, '6/20/2021', 22, 103, 9, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 3, '6/15/2021', 28, 152, 3, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 3, '6/27/2021', 22, 144, 10, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 2, '7/8/2021', 20, 100, 12, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 2, '7/8/2021', 18, 135, 11, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (17, 1, '7/5/2021', 27, 121, 15, 2);


insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 3, '8/10/2021', 27, 112, 2, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 4, '8/8/2021', 19, 100, 19, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 4, '8/10/2021', 23, 123, 30, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 1, '7/28/2021', 26, 107, 21, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 1, '8/8/2021', 22, 112, 23, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 2, '8/8/2021', 19, 110, 1, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 4, '8/12/2021', 20, 120, 4, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 1, '8/8/2021', 17, 127, 25, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 3, '8/2/2021', 20, 166, 15, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (18, 1, '8/3/2021', 19, 133, 14, 4);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 1, '8/14/2021', 25, 153, 24, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 4, '9/4/2021', 28, 148, 7, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 2, '8/28/2021', 27, 134, 7, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 1, '8/24/2021', 18, 135, 17, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 4, '8/20/2021', 16, 125, 4, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 4, '8/20/2021', 27, 162, 29, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 2, '8/22/2021', 29, 170, 12, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 4, '8/23/2021', 27, 103, 6, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 1, '9/4/2021', 23, 116, 14, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (19, 3, '8/30/2021', 15, 107, 8, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 3, '10/7/2021', 28, 148, 28, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 3, '9/26/2021', 15, 161, 17, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 2, '10/2/2021', 21, 110, 14, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 2, '9/21/2021', 15, 140, 8, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 2, '10/7/2021', 23, 142, 17, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 3, '9/24/2021', 26, 118, 7, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 2, '9/30/2021', 24, 108, 1, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 4, '10/11/2021', 20, 139, 27, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 2, '10/4/2021', 18, 108, 14, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (20, 1, '9/24/2021', 30, 143, 24, 1);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 2, '11/6/2021', 21, 151, 23, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 2, '10/16/2021', 29, 137, 22, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 4, '10/24/2021', 27, 157, 23, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 3, '10/18/2021', 20, 164, 17, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 2, '10/12/2021', 19, 101, 25, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 4, '10/28/2021', 29, 133, 28, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 3, '11/17/2021', 17, 153, 9, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 4, '11/5/2021', 22, 106, 15, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 3, '11/7/2021', 18, 114, 17, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (21, 3, '11/11/2021', 18, 128, 6, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 3, '11/15/2021', 30, 164, 8, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 3, '12/1/2021', 15, 159, 25, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 4, '12/15/2021', 20, 151, 20, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 3, '11/25/2021', 22, 101, 10, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 2, '11/18/2021', 21, 120, 15, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 2, '12/20/2021', 27, 104, 1, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 3, '12/8/2021', 22, 169, 12, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 3, '12/13/2021', 29, 131, 7, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 4, '12/2/2021', 23, 105, 23, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (22, 4, '12/8/2021', 24, 155, 12, 1);

---2022---
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 1, '1/23/2022', 19, 113, 17, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 2, '1/22/2022', 16, 106, 3, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 1, '1/19/2022', 16, 117, 8, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 4, '1/17/2022', 29, 142, 24, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 2, '1/12/2022', 30, 147, 28, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 2, '1/3/2022', 22, 103, 20, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 3, '1/6/2022', 29, 155, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 4, '1/7/2022', 27, 105, 21, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 1, '1/13/2022', 30, 133, 15, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (23, 4, '1/9/2022', 22, 152, 14, 4);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 3, '12/17/2021', 28, 112, 10, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 3, '12/21/2021', 20, 133, 14, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 2, '12/22/2021', 27, 115, 8, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 4, '12/31/2021', 26, 101, 21, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 2, '12/27/2021', 23, 155, 29, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 1, '1/1/2022', 16, 123, 20, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 3, '12/18/2021', 29, 164, 17, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 4, '1/2/2022', 27, 148, 22, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 2, '12/17/2021', 22, 114, 10, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (24, 3, '12/22/2021', 22, 137, 13, 1);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 4, '1/30/2022', 23, 161, 15, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 3, '1/26/2022', 30, 150, 7, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 1, '1/29/2022', 27, 152, 7, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 1, '2/2/2022', 30, 148, 24, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 2, '1/28/2022', 22, 140, 10, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 1, '1/29/2022', 30, 111, 16, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 2, '1/25/2022', 17, 123, 22, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 1, '1/21/2022', 19, 110, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 1, '1/31/2022', 29, 112, 12, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (25, 4, '1/27/2022', 29, 100, 1, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 2, '2/9/2022', 23, 150, 26, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 2, '1/25/2022', 19, 168, 21, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 3, '2/10/2022', 17, 129, 17, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 1, '2/11/2022', 19, 156, 14, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 2, '2/7/2022', 15, 121, 29, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 3, '2/9/2022', 21, 134, 13, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 4, '2/6/2022', 26, 116, 20, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 2, '1/31/2022', 27, 143, 19, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 1, '2/2/2022', 21, 133, 6, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (26, 1, '1/30/2022', 21, 137, 3, 4);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 2, '2/25/2022', 29, 157, 27, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 1, '3/2/2022', 17, 144, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 4, '3/4/2022', 15, 118, 21, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 4, '2/28/2022', 28, 155, 8, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 3, '3/3/2022', 22, 169, 1, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 4, '2/25/2022', 30, 159, 24, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 3, '2/19/2022', 17, 126, 21, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 3, '3/2/2022', 27, 149, 18, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 4, '3/3/2022', 21, 168, 18, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (27, 1, '2/17/2022', 30, 164, 12, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 1, '3/18/2022', 18, 154, 1, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 1, '3/28/2022', 26, 167, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 1, '3/17/2022', 27, 150, 23, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 4, '3/14/2022', 22, 119, 5, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 1, '3/11/2022', 16, 127, 3, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 4, '3/14/2022', 19, 127, 22, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 1, '3/28/2022', 28, 141, 26, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 3, '3/29/2022', 25, 122, 24, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 4, '4/6/2022', 30, 137, 19, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (28, 3, '3/26/2022', 21, 158, 8, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 3, '4/17/2022', 21, 166, 12, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 1, '4/15/2022', 21, 148, 24, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 3, '4/2/2022', 18, 141, 2, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 4, '4/3/2022', 22, 118, 6, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 1, '3/28/2022', 24, 132, 3, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 4, '4/8/2022', 19, 142, 22, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 2, '4/1/2022', 27, 159, 19, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 4, '4/6/2022', 17, 114, 29, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 4, '4/5/2022', 16, 128, 1, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (29, 2, '4/15/2022', 26, 142, 22, 2);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 1, '4/28/2022', 21, 165, 13, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 4, '4/20/2022', 24, 128, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 4, '4/26/2022', 27, 147, 28, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 3, '4/23/2022', 27, 162, 25, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 4, '5/14/2022', 16, 152, 17, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 3, '5/19/2022', 22, 145, 19, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 1, '4/20/2022', 17, 147, 10, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 2, '5/22/2022', 18, 136, 11, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 3, '4/22/2022', 24, 130, 23, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (30, 2, '4/28/2022', 15, 133, 3, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 3, '5/23/2022', 15, 132, 1, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 3, '5/30/2022', 29, 113, 17, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 2, '5/24/2022', 19, 125, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 4, '5/22/2022', 27, 114, 30, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 3, '5/26/2022', 26, 113, 2, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 1, '5/21/2022', 29, 125, 18, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 2, '5/24/2022', 27, 143, 21, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 3, '5/26/2022', 29, 129, 18, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 3, '5/24/2022', 21, 135, 23, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (31, 1, '5/28/2022', 16, 137, 22, 4);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 2, '4/16/2022', 23, 112, 4, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 3, '4/12/2022', 16, 124, 26, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 3, '4/5/2022', 18, 128, 25, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 1, '4/14/2022', 19, 151, 15, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 4, '5/3/2022', 26, 161, 21, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 2, '4/20/2022', 23, 101, 1, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 2, '5/3/2022', 15, 115, 9, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 2, '4/12/2022', 21, 139, 9, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 3, '5/2/2022', 27, 135, 6, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (32, 4, '5/1/2022', 27, 161, 28, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 2, '3/23/2022', 30, 123, 25, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 4, '3/18/2022', 24, 164, 17, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 2, '3/30/2022', 22, 104, 15, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 3, '3/30/2022', 25, 152, 9, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 2, '4/2/2022', 15, 136, 29, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 3, '4/5/2022', 21, 115, 10, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 2, '4/4/2022', 24, 110, 23, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 2, '3/25/2022', 15, 166, 18, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 4, '4/3/2022', 29, 158, 24, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (33, 3, '4/2/2022', 25, 149, 26, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 3, '2/27/2022', 30, 132, 6, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 3, '3/7/2022', 17, 107, 20, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 2, '3/7/2022', 26, 169, 4, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 2, '3/9/2022', 19, 148, 29, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 4, '2/23/2022', 30, 129, 1, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 2, '3/11/2022', 15, 162, 5, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 1, '3/11/2022', 19, 101, 25, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 4, '2/24/2022', 28, 106, 29, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 1, '3/5/2022', 15, 170, 28, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (34, 1, '3/8/2022', 17, 163, 10, 4);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 1, '3/7/2022', 29, 156, 25, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 4, '2/27/2022', 30, 144, 12, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 3, '3/6/2022', 29, 137, 9, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 4, '3/6/2022', 21, 103, 2, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 1, '2/24/2022', 23, 144, 28, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 3, '3/9/2022', 25, 116, 4, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 3, '3/13/2022', 27, 145, 4, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 3, '3/4/2022', 26, 141, 22, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 2, '3/4/2022', 21, 122, 15, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (35, 4, '2/24/2022', 15, 113, 4, 3);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 2, '4/15/2022', 23, 144, 26, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 2, '5/4/2022', 17, 135, 6, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 3, '4/26/2022', 16, 143, 22, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 3, '4/15/2022', 20, 133, 10, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 2, '4/26/2022', 15, 108, 22, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 3, '4/15/2022', 26, 143, 8, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 1, '4/30/2022', 30, 124, 18, 4);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 4, '4/14/2022', 23, 153, 4, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 4, '4/29/2022', 26, 135, 2, 2);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (36, 4, '5/4/2022', 23, 124, 6, 4);

insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 4, '2/3/2022', 25, 134, 11, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 2, '1/28/2022', 29, 144, 3, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 1, '1/29/2022', 18, 165, 1, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 1, '1/30/2022', 28, 148, 2, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 2, '1/31/2022', 27, 136, 9, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 2, '1/28/2022', 16, 135, 5, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 1, '2/7/2022', 30, 101, 10, 3);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 4, '2/1/2022', 26, 145, 17, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 2, '2/7/2022', 25, 126, 10, 1);
insert into Contrato (cod_evento, cod_tipo_stand, fecha_alquiler, mts2, monto, cod_cliente, cod_sub_categoria) values (37, 4, '2/11/2022', 28, 154, 18, 2);


insert into Visitante (cedula, nb_visitante, sexo, email) values (22072755, 'Solarbreeze', 'M', 'tmcgrirl0@bing.com');
insert into Visitante (cedula, nb_visitante, sexo, email) values (24949681, 'Fixflex', 'M', 'thearnshaw1@buzzfeed.com');
insert into Visitante (cedula, nb_visitante, sexo, email) values (25676552, 'Voyatouch', 'M', 'jhinstock2@weibo.com');
insert into Visitante (cedula, nb_visitante, sexo, email) values (23304370, 'Latlux', 'M', 'fchurchin3@usnews.com');
insert into Visitante (cedula, nb_visitante, sexo, email) values (26582695, 'Asoka', 'F', 'whussy4@gizmodo.com');
insert into Visitante (cedula, nb_visitante, sexo, email) values (23844286, 'Job', 'F', 'thartburn5@1und1.de');
insert into Visitante (cedula, nb_visitante, sexo, email) values (20004049, 'Otcom', 'F', 'bgegg6@techcrunch.com');
insert into Visitante (cedula, nb_visitante, sexo, email) values (17852089, 'Stim', 'M', 'iangless7@mac.com');
insert into Visitante (cedula, nb_visitante, sexo, email) values (20781677, 'Ronstring', 'M', 'fvenners8@mysql.com');
insert into Visitante (cedula, nb_visitante, sexo, email) values (23618646, 'Greenlam', 'F', 'csillito9@telegraph.co.uk');

insert into LeyendaEstrellas(nb_descripcion) values ('Malo');
insert into LeyendaEstrellas(nb_descripcion) values ('Regular');
insert into LeyendaEstrellas(nb_descripcion) values ('Bueno');
insert into LeyendaEstrellas(nb_descripcion) values ('Muy Bueno');
insert into LeyendaEstrellas(nb_descripcion) values ('Excelente');

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '2/3/2022', '12:34', 8, 'S', 1, 1);
insert into Entrada  (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/23/2020', '1:10', 4, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/22/2020', '7:59', 9, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/24/2020', '6:55', 1, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/24/2020', '1:56', 10, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/24/2020', '5:24', 4, 'S', 1, 1);
insert into Entrada(cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/22/2020', '9:15', 10, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/23/2020', '1:14', 6, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/23/2020', '4:44', 3, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (1, '1/23/2020', '6:36', 3, 'N', 1, 1);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/25/2020', '4:25', 3, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/25/2020', '10:33', 7, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/26/2020', '12:57', 4, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/23/2020', '11:34', 8, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/18/2020', '6:15', 6, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/17/2020', '8:58', 10, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/20/2020', '11:29', 2, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/20/2020', '12:22', 9, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/22/2020', '12:03', 1, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (2, '2/21/2020', '6:04', 7, 'N', 5, 5);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/4/2020', '5:53', 3, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/6/2020', '6:38', 9, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/4/2020', '4:47', 3, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/7/2020', '3:20', 9, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/6/2020', '10:57', 4, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/6/2020', '10:12', 4, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/2/2020', '9:53', 3, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/6/2020', '9:39', 2, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/4/2020', '1:19', 1, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (3, '3/7/2020', '1:44', 10, 'S', 3, 3);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/20/2020', '3:50', 9, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/25/2020', '6:26', 6, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/26/2020', '2:25', 1, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/28/2020', '12:39', 5, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/28/2020', '6:10', 2, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/19/2020', '2:35', 6, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/28/2020', '3:51', 1, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/26/2020', '1:53', 2, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/18/2020', '9:36', 5, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (4, '4/28/2020', '7:17', 4, 'S', 4, 4);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/20/2020', '4:18', 5, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/10/2020', '10:32', 9, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/9/2020', '3:31', 2, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/16/2020', '2:28', 4, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/30/2020', '10:17', 9, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/18/2020', '12:48', 8, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/18/2020', '7:16', 6, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/29/2020', '12:13', 7, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/20/2020', '3:35', 1, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (5, '4/21/2020', '4:00', 9, 'N', 1, 1);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/11/2020', '5:22', 5, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/12/2020', '5:40', 1, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/13/2020', '1:57', 4, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/13/2020', '7:05', 1, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/12/2020', '12:31', 2, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/10/2020', '8:25', 9, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/13/2020', '7:38', 5, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/13/2020', '7:42', 1, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/12/2020', '8:07', 1, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (6, '6/13/2020', '4:52', 10, 'N', 5, 5);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/12/2020', '6:58', 6, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/10/2020', '5:45', 8, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/15/2020', '10:11', 7, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/13/2020', '9:30', 6, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/11/2020', '4:56', 5, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/17/2020', '8:14', 9, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/16/2020', '6:59', 3, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/12/2020', '7:57', 9, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/15/2020', '9:46', 7, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (7, '7/10/2020', '6:58', 5, 'S', 1, 1);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/19/2020', '4:12', 7, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/16/2020', '12:22', 2, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/6/2020', '8:10', 3, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/21/2020', '6:46', 5, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/18/2020', '11:20', 8, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/6/2020', '8:07', 3, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/21/2020', '1:09', 8, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/21/2020', '11:39', 7, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/19/2020', '1:23', 10, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (8, '8/6/2020', '4:37', 3, 'S', 3, 3);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/7/2020', '12:26', 4, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/7/2020', '7:38', 10, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/8/2020', '8:33', 3, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/8/2020', '11:33', 8, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/8/2020', '10:13', 2, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/7/2020', '4:47', 5, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/8/2020', '10:19', 4, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/8/2020', '6:14', 3, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/7/2020', '12:17', 1, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '9/7/2020', '12:07', 5, 'N', 1, 1);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/18/2020', '11:24', 4, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/24/2020', '8:14', 10, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/23/2020', '9:34', 10, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/15/2020', '5:36', 7, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/24/2020', '12:48', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/14/2020', '9:27', 8, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/16/2020', '5:31', 3, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/23/2020', '8:33', 8, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/27/2020', '2:29', 2, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (9, '12/17/2020', '8:18', 3, 'S', 4, 4);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/9/2021', '3:33', 8, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/9/2021', '3:43', 5, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/10/2021', '11:15', 5, 'N', 2,2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/8/2021', '11:38', 10, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/8/2021', '5:08', 5, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/13/2021', '5:09', 9, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/3/2021', '12:06', 7, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/3/2021', '8:07', 10, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/7/2021', '8:46', 2, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (11, '1/4/2021', '4:45', 3, 'N', 5, 5);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/10/2021', '8:59', 4, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/8/2021', '7:10', 4, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/8/2021', '8:03', 10, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/12/2021', '7:07', 8, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/12/2021', '11:39', 4, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/12/2021', '8:40', 4, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/11/2021', '1:03', 7, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/8/2021', '7:23', 6, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/6/2021', '5:36', 2, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (12, '2/8/2021', '10:58', 5, 'N', 2, 2);



insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/10/2021', '1:34 ', 9, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/21/2021', '5:20 ', 6, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/21/2021', '6:59 ', 8, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/9/2021', '11:20 ', 1, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/10/2021', '9:48 ', 9, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/16/2021', '7:27 ', 6, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/16/2021', '12:26 ', 2, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/22/2021', '2:43 ', 4, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/22/2021', '2:08 ', 3, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (13, '3/13/2021', '1:50 ', 9, 'N', 5, 5);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/1/2021', '9:49 ', 3, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/2/2021', '4:11 ', 5, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/2/2021', '6:17 ', 2, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/2/2021', '12:15 ', 4, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/8/2021', '9:26 ', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/7/2021', '9:39 ', 4, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/6/2021', '11:56 ', 1, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/3/2021', '3:06 ', 5, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/3/2021', '7:36 ', 1, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (14, '4/7/2021', '6:19 ', 10, 'S', 2, 2);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/11/2021', '7:29 ', 2, 'S', 3, 3)
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/12/2021', '2:26 ', 2, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/18/2021', '9:00 ', 9, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/7/2021', '8:03 ', 10, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/8/2021', '12:30 ', 3, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/16/2021', '12:28 ', 10, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/19/2021', '12:36 ', 6, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/9/2021', '1:05 ', 10, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/19/2021', '8:04 ', 8, 'M', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (15, '5/10/2021', '7:09 ', 6, 'S', 4, 4);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/17/2021', '3:27 ', 1, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/24/2021', '3:40 ', 7, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/18/2021', '2:36 ', 4, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/16/2021', '12:24 ', 7, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/26/2021', '11:45 ', 3, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/23/2021', '4:01 ', 7, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/20/2021', '2:11 ', 3, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/16/2021', '2:53 ', 9, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/23/2021', '5:08 ', 2, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (16, '6/20/2021', '9:18 ', 3, 'S', 3, 3);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/26/2021', '3:06 ', 5, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/18/2021', '12:45 ', 3, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/27/2021', '3:07 ', 9, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/24/2021', '8:00 ', 6, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/17/2021', '4:24 ', 1, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/23/2021', '7:32 ', 9, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/22/2021', '10:09 ', 9, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/19/2021', '7:53 ', 9, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/24/2021', '8:57 ', 7, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (17, '7/20/2021', '10:34 ', 1, 'S', 3, 3);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/16/2021', '2:48 ', 8, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/19/2021', '7:55 ', 6, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/14/2021', '8:07 ', 2, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/21/2021', '4:12 ', 4, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/14/2021', '2:32 ', 6, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/18/2021', '10:40 ', 8, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/19/2021', '4:42 ', 1, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/14/2021', '4:40 ', 2, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/16/2021', '5:07 ', 5, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (18, '8/21/2021', '6:26 ', 7, 'S', 2, 2);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/18/2021', '3:28 ', 5, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/18/2021', '8:01 ', 5, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/19/2021', '6:43 ', 5, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/18/2021', '6:20 ', 7, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/19/2021', '4:55 ', 1, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/20/2021', '7:56 ', 1, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/20/2021', '2:43 ', 4, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/16/2021', '11:38 ', 10, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/19/2021', '9:02 ', 9, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (19, '9/18/2021', '4:36 ', 2, 'N', 1, 1);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/16/2021', '10:53 ', 9, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/16/2021', '9:13 ', 3, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/16/2021', '11:12 ', 7, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/15/2021', '11:27 ', 4, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/16/2021', '4:28 ', 2, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/16/2021', '3:54 ', 3, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/16/2021', '8:27 ', 9, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/15/2021', '1:41 ', 6, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/16/2021', '2:14 ', 3, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (20, '10/16/2021', '4:32 ', 8, 'N', 3, 3);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/26/2021', '2:52 ', 1, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/26/2021', '6:36 ', 10, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/27/2021', '2:39 ', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/26/2021', '5:29 ', 6, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/26/2021', '9:08 ', 6, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/28/2021', '12:51 ', 4, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/27/2021', '10:56 ', 6, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/28/2021', '7:54 ', 7, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/26/2021', '12:48 ', 3, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (21, '11/26/2021', '11:39 ', 1, 'N', 4, 4);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/25/2021', '7:46 ', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/24/2021', '6:02 ', 9, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/26/2021', '12:23 ', 5, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/25/2021', '2:50 ', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/23/2021', '1:52 ', 4, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/25/2021', '5:27 ', 4, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/24/2021', '6:51 ', 4, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/24/2021', '8:10 ', 1, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/23/2021', '1:11 ', 2, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (22, '12/24/2021', '9:17 ', 8, 'S', 5, 5);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '2/12/2022', '3:21 ', 2, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '2/4/2022', '11:53 ', 10, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '2/4/2022', '11:23 ', 7, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '2/8/2022', '2:17 ', 10, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '1/31/2022', '2:55 ', 3, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '2/8/2022', '3:04 ', 1, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '2/8/2022', '11:55 ', 7, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '2/11/2022', '5:44 ', 3, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '1/29/2022', '6:24 ', 8, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (23, '2/8/2022', '4:57 ', 7, 'S', 5, 5);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/12/2022', '10:26 ', 1, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/10/2022', '11:07 ', 2, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/13/2022', '6:24 ', 5, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/6/2022', '3:23 ', 8, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/13/2022', '12:40 ', 6, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/12/2022', '1:27 ', 6, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/5/2022', '5:22 ', 6, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/13/2022', '7:57 ', 5, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/14/2022', '12:40 ', 3, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (24, '1/5/2022', '6:24 ', 6, 'N', 4, 4);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/18/2022', '8:32 ', 6, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/21/2022', '1:21 ', 6, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/24/2022', '12:56 ', 9, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/25/2022', '11:53 ', 9, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/21/2022', '5:03 ', 4, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/16/2022', '5:27 ', 7, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/24/2022', '3:27 ', 1, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '2/2/2022', '1:46 ', 5, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/26/2022', '3:02 ', 3, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (25, '1/16/2022', '1:18 ', 8, 'N', 3, 3);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/14/2022', '2:04 ', 2, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/17/2022', '12:43 ', 2, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/15/2022', '8:31 ', 8, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/15/2022', '10:22 ', 4, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/14/2022', '6:50 ', 6, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/16/2022', '9:01 ', 8, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/14/2022', '2:46 ', 10, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/16/2022', '5:15 ', 7, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/15/2022', '6:10 ', 3, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (26, '2/17/2022', '8:11 ', 5, 'N', 2, 2);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/10/2022', '12:01 ', 6, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/8/2022', '9:22 ', 5, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/9/2022', '2:17 ', 6, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/9/2022', '8:03 ', 9, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/8/2022', '4:37 ', 9, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/8/2022', '2:32 ', 2, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/10/2022', '1:15 ', 5, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/11/2022', '5:15 ', 5, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/9/2022', '11:34 ', 3, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (27, '3/9/2022', '11:09 ', 1, 'N', 4, 1);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/19/2022', '4:26 ', 2, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/8/2022', '7:51 ', 2, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/16/2022', '6:20 ', 4, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/10/2022', '11:06 ', 10, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/14/2022', '6:27 ', 3, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/8/2022', '5:25 ', 7, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/17/2022', '2:40 ', 2, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/10/2022', '9:48 ', 7, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/18/2022', '8:56 ', 1, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (28, '4/18/2022', '11:40 ', 9, 'N', 5, 5);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/24/2022', '12:09 ', 5, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/27/2022', '3:52 ', 2, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/23/2022', '12:32 ', 4, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/22/2022', '3:08 ', 4, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/22/2022', '10:57 ', 5, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/20/2022', '1:03 ', 4, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/27/2022', '12:50 ', 8, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/25/2022', '6:08 ', 6, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/28/2022', '1:09 ', 7, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (29, '4/24/2022', '9:07 ', 5, 'S', 3, 3);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '6/6/2022', '5:38 ', 8, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '5/27/2022', '12:56 ', 2, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '5/25/2022', '4:42 ', 10, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '6/6/2022', '3:15 ', 4, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '5/29/2022', '8:41 ', 5, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '5/25/2022', '6:29 ', 8, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '6/8/2022', '1:21 ', 10, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '6/3/2022', '2:44 ', 10, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '6/8/2022', '10:00 ', 5, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (30, '6/3/2022', '2:35 ', 8, 'S', 2, 2);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/1/2022', '11:47 ', 9, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/2/2022', '3:51 ', 5, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/2/2022', '8:29 ', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/2/2022', '11:42 ', 6, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/4/2022', '9:37 ', 8, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/7/2022', '1:24 ', 2, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/2/2022', '7:06 ', 6, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/6/2022', '7:47 ', 4, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/1/2022', '3:28 ', 2, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (31, '6/3/2022', '8:32 ', 1, 'S', 5, 5);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/13/2022', '3:08 ', 7, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/12/2022', '1:13 ', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/14/2022', '11:26 ', 8, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/11/2022', '11:19 ', 6, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/7/2022', '12:53 ', 2, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/8/2022', '5:06 ', 3, 'S', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/7/2022', '4:24 ', 8, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/7/2022', '1:39 ', 6, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/13/2022', '4:59 ', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (32, '5/15/2022', '5:32 ', 8, 'S', 5, 5);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/27/2022', '12:24 ', 1, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/26/2022', '6:09 ', 1, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/11/2022', '6:23 ', 7, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/7/2022', '12:48 ', 10, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/15/2022', '7:12 ', 6, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/11/2022', '2:47 ', 2, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/11/2022', '3:20 ', 4, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/15/2022', '8:11 ', 10, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/15/2022', '10:14 ', 6, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (33, '7/23/2022', '4:46 ', 9, 'N', 2, 2);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/14/2022', '8:33 ', 7, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/19/2022', '12:34 ', 8, 'S', 4, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/14/2022', '9:44 ', 3, 'N', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/14/2022', '6:46 ', 3, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/23/2022', '11:00 ', 1, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/22/2022', '2:34 ', 9, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/17/2022', '8:44 ', 10, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/13/2022', '9:56 ', 1, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/18/2022', '3:43 ', 7, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (34, '3/15/2022', '2:32 ', 5, 'S', 2, 2);


insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/23/2022', '11:16 ', 2, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/20/2022', '7:48 ', 9, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/25/2022', '5:06 ', 1, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/22/2022', '7:59 ', 10, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/22/2022', '1:16 ', 1, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/24/2022', '5:59 ', 9, 'N', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/19/2022', '10:52 ', 9, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/23/2022', '2:30 ', 9, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/21/2022', '11:09 ', 4, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (35, '3/21/2022', '4:41 ', 4, 'N', 1, 1);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '5/30/2022', '8:24 ', 10, 'S', 2, 2);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '5/19/2022', '9:48 ', 4, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '6/9/2022', '6:17 ', 8, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '6/4/2022', '8:13 ', 10, 'N', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '6/1/2022', '5:11 ', 2, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '6/8/2022', '6:29 ', 2, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '5/19/2022', '6:28 ', 9, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '6/5/2022', '4:55 ', 7, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '5/20/2022', '9:56 ', 6, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (36, '6/12/2022', '10:39 ', 1, 'S', 4, 4);

insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/17/2022', '6:28 ', 5, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/13/2022', '3:47 ', 7, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/16/2022', '8:57 ', 9, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/16/2022', '1:54 ', 5, 'N', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/14/2022', '10:17 ', 10, 'S', 5, 5);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/14/2022', '6:01 ', 8, 'S', 4, 4);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/15/2022', '9:32 ', 3, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/16/2022', '11:37 ', 5, 'N', 1, 1);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/17/2022', '4:31 ', 9, 'S', 3, 3);
insert into Entrada (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas) values (37, '2/15/2022', '7:02', 1, 'S', 1, 1);


