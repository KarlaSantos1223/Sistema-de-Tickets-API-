create database SistemaDeTicketsDB;
go

use master;
go

drop database SistemaDeTicketsDB;
go

use SistemaDeTicketsDB;
go

create table roles(
	id_roll UNIQUEIDENTIFIER PRIMARY KEY default NEWID(),
	nombre_roll nvarchar(50) not null,
	descripcion_roll nvarchar(100) not null
);
go 

create table polizas(
	id_poliza UNIQUEIDENTIFIER primary key default NEWID(),
	nombre_poliza nvarchar(50) not null,
	descripcion_poliza nvarchar(100) not null,
	diasVigencia_poliza int not null
);
go

create table usuarios(
	id_usuario UNIQUEIDENTIFIER primary key default NEWID(),
	nombre_usuario nvarchar(50) not null,
	email_usuario nvarchar(50) not null,
	contrasenia_usuario nvarchar(20) not null,
	id_roll UNIQUEIDENTIFIER foreign key references  roles(id_roll) not null
);
go

create table clientes(
	id_cliente UNIQUEIDENTIFIER primary key default NEWID(),
	nombre_cliente nvarchar(50) not null,
	aPaterno_cliente nvarchar(50),
	aMaterno_cliente nvarchar(50),
	prioridad_cliente nvarchar(30) not null,
	id_poliza UNIQUEIDENTIFIER foreign key references polizas(id_poliza),
	fechaLiberacionApp_cliente date not null,
	numeroWA_cliente nvarchar(13) not null,
	comentarios_cliente nvarchar(100)
);
go

create table tickets(
	id_ticket UNIQUEIDENTIFIER primary key default NEWID(),
	folio_ticket  int identity(1,1),
	id_cliente UNIQUEIDENTIFIER foreign key references clientes(id_cliente) not null,
	tipo_ticket  nvarchar(50) not null,
	descripcion_ticket  nvarchar(200) not null,
	estatus_ticket  nvarchar(50),
	fechaApertura_ticket  date not null,
	id_usuario UNIQUEIDENTIFIER foreign key references usuarios(id_usuario)
);
go

create table historicoAtencionTicket(
	id_historico UNIQUEIDENTIFIER primary key default NEWID(),
	id_ticket UNIQUEIDENTIFIER foreign key references tickets(id_ticket) not null,
	detalles_historico nvarchar(150) not null,
	fecha date not null,
	id_usuario UNIQUEIDENTIFIER foreign key references usuarios(id_usuario) not null
);
go

create table documentos(
	id_documento UNIQUEIDENTIFIER primary key default NEWID(),
	tipo_documento nvarchar(50),
	url_documento nvarchar(120),
	id_historico UNIQUEIDENTIFIER foreign key references historicoAtencionTicket(id_historico) not null
);
go