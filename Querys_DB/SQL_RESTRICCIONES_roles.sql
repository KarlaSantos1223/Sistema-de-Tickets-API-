-----------  RESTRICCIONES ROLES ------------
/*create table roles(
	id_roll UNIQUEIDENTIFIER PRIMARY KEY default NEWID(),
	nombre_roll nvarchar(50) not null,
	descripcion_roll nvarchar(100) not null
);
go */

use SistemaDeTicketsDB;
go

-- nombre de rol unico --
alter table roles add constraint UNICO_nombre_roll UNIQUE(nombre_roll)
go



-----------  RESTRICCIONES POLIZA ------------
/*create table polizas(
	id_poliza UNIQUEIDENTIFIER primary key default NEWID(),
	nombre_poliza nvarchar(50) not null,
	descripcion_poliza nvarchar(100) not null,
	diasVigencia_poliza int not null
);
go */

use SistemaDeTicketsDB;
go

-- nombre de poliza unico --
alter table polizas add constraint UNICO_nombre_poliza UNIQUE(nombre_poliza)
go

