-----------  RESTRICCIONES USUARIOS ------------
/*create table clientes(
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
go*/

use SistemaDeTicketsDB;
go

-- Validar que solo se ingresen las prioridades baja, media, alta ó urgente --
alter table clientes add constraint ck_prioridad_cliente
check(prioridad_cliente ='baja' or prioridad_cliente ='media' or prioridad_cliente ='alta' or
prioridad_cliente ='urgente');
go
-- Reglas para texto (nombre) --
create rule rl_nombres as @texto not like '%[^a-záéíóúñ ]%'; -- Permite letras (minús), tildes, ñ y espacios
go

exec sp_bindrule rl_nombres, 'clientes.nombre_cliente';
go
exec sp_bindrule rl_nombres, 'clientes.aPaterno_cliente';
go
exec sp_bindrule rl_nombres, 'clientes.aMaterno_cliente';
go

-- En caso de que no exista apellido materno o paterno --
create default cadena_vacia as ' ';
go

exec sp_bindefault cadena_vacia, 'clientes.aPaterno_cliente';
go
exec sp_bindefault cadena_vacia, 'clientes.aMaterno_cliente';
go
exec sp_bindefault cadena_vacia, 'clientes.comentarios_cliente';
go