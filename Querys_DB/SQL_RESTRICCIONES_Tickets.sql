-----------  RESTRICCIONES TICKETS ------------
/*create table tickets(
	id_ticket UNIQUEIDENTIFIER primary key default NEWID(),
	folio_ticket  int identity(1,1),
	id_cliente UNIQUEIDENTIFIER foreign key references clientes(id_cliente) not null,
	tipo_ticket  nvarchar(50) not null,
	descripcion_ticket  nvarchar(200) not null,
	estatus_ticket  nvarchar(50),
	fechaApertura_ticket  date not null,
	id_usuario UNIQUEIDENTIFIER foreign key references usuarios(id_usuario)
);
go*/

use SistemaDeTicketsDB;
go

-- estatus por defecto de los tickets creados --
create default estatus_abierto_default as 'abierto';
go
exec sp_bindefault estatus_abierto_default, 'tickets.estatus_ticket';
go

/*Asignar los valores validos para el estatus de un ticket como:
	- abierto (ticket creado)
	- cerrado (se completo la solicitud del ticket)
	- en progreso (se esta trabajando en completar la solicitud)
	- en espera (se presento un problema temporal que impide completar la solicitud)
	- cerrado incompleto (no se pudo completar la solicitud / la solicitud no era valida)
*/
alter table tickets add constraint ck_estatus_ticket 
CHECK( estatus_ticket = 'abierto' or
	   estatus_ticket = 'cerrado' or
	   estatus_ticket = 'en progreso' or
	   estatus_ticket = 'en espera' or
	   estatus_ticket = 'cerrado incompleto'
);
go

-- Asignar fecha por default a la fecha de apertura del ticket
create default fecha_de_hoy as GETDATE();
go
exec sp_bindefault fecha_de_hoy, 'tickets.fechaApertura_ticket';
go

-- nombre de rol unico --
alter table roles add constraint UNICO_nombre_roll UNIQUE(nombre_roll)
go

-- asignar a un usuario ADMINISTRADOR por default --
