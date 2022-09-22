--Karla Gabriela Navarro Raudales  20191003134    Sección: 0800

USE Tarea1

CREATE TABLE aerolinea(
codigo_aerolinea varchar(10) primary key not null,
descuento integer not null,
)

ALTER TABLE aerolinea ADD Constraint ck_descuento
check (descuento >= 10)


CREATE TABLE cliente(
identidad_cliente varchar(30) primary key not null,
nombre_cliente varchar(60) not null,
telefono varchar(10) not null
)

CREATE TABLE boleto(
codigo_boleto varchar(10) primary key not null,
no_vuelo varchar(60) not null,
fecha date not null,
destino varchar(60) not null,
codigo_aerolinea varchar(10) not null,
identidad_cliente varchar(30) not null
)

ALTER TABLE boleto ADD Constraint fk_boleto_aerolinea
foreign key (codigo_aerolinea) references aerolinea(codigo_aerolinea)

ALTER TABLE boleto ADD Constraint fk_boleto_cliente
foreign key (identidad_cliente) references cliente(identidad_cliente)

Alter Table boleto ADD Constraint ck_destino
check (destino in ('México', 'Guatemala', 'Panamá'))



CREATE TABLE hotel(
codigo_hotel varchar(10) primary key not null,
nombre_hotel varchar(60) not null,
direccion varchar(60)
)


CREATE TABLE reserva(
codigo_hotel varchar(10) not null,
identidad_cliente varchar(30) not null,
fechain date not null,
fechaout date not null,
cantidad_personas integer default '0' not null
)

ALTER TABLE reserva ADD Constraint pk_reserva
primary key (codigo_hotel, identidad_cliente)

ALTER TABLE reserva ADD Constraint fk_reserva_hotel
foreign key (codigo_hotel) references hotel(codigo_hotel)

ALTER TABLE reserva ADD Constraint fk_reserva_cliente
foreign key (identidad_cliente) references cliente(identidad_cliente)


--Inserts

Insert into aerolinea values ('001', '20')
Insert into aerolinea values ('002', '50')

SELECT *FROM aerolinea


Insert into cliente values ('0801200019543', 'Sara Navarro', '98765633')
Insert into cliente values ('0801200509876', 'Hector Gutierez', '99778899')

SELECT *FROM cliente


Insert into boleto values ('0001', 'carga', '2022-09-30', 'México', '001', '0801200019543')
Insert into boleto values ('0002', 'ligero', '2022-10-07', 'Panamá', '002', '0801200509876')

SELECT *FROM boleto


Insert into hotel values ('1', 'Clarion', 'Palmira')
Insert into hotel values ('2', 'Intercontinental', 'Las Lomas')

SELECT *FROM hotel


Insert into reserva values ('1', '0801200019543', '2022-09-30', '2022-10-27', '0')
Insert into reserva values ('2', '0801200509876', '2022-10-07', '2022-12-12', '0')


SELECT *FROM reserva