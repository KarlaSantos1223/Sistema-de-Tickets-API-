-----------  RESTRICCIONES USUARIOS ------------
/*create table usuarios(
	id_usuario UNIQUEIDENTIFIER primary key default NEWID(),
	nombre_usuario nvarchar(50) not null,
	email_usuario nvarchar(50) not null,
	contrasenia_usuario nvarchar(20) not null,
	id_roll UNIQUEIDENTIFIER foreign key references  roles(id_roll) not null
);
go*/

use SistemaDeTicketsDB;
go

-- Restriccion email --
create rule Formato_correo as @correo like '%@%';
go
exec sp_bindrule Formato_correo, 'usuarios.email_usuario';
go

-- Nombre de usuario unico --
alter table usuarios add constraint Unico_nombre_usuario Unique(nombre_usuario);
go

-- Email unico --
alter table usuarios add constraint Unico_email_usuario Unique(email_usuario);
go

