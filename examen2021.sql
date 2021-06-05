create database examen2021
use examen2021

create table Estados(
	estadosId int not null,
	estado varchar(255)  not null,
	primary key(estadosId),
);

create table Municipio(
	municipioId int not null,
	municipio varchar(255)  not null,
	primary key(municipioId)
);

create table Edo_Mun(
	EdoMunId int identity(1,1) not null,
	municipioId int not null,
	estadosId int not null,
	primary key(EdoMunId),
	foreign key(estadosId) references Estados,
	foreign key(municipioId) references Municipio,
);

create table Usuarios(
	usuarioId int identity(1,1) not null,
	nombre varchar(50) not null,
	direccion varchar(100) not null,
	telefono  varchar(100) not null,
	codigoPostal int not null,
	tipoUsuario varchar(50) not null,
	username varchar(50) unique not null,
	password varchar(30) not null,
	EdoMunId int not null,
	primary key(usuarioId),
	foreign key(EdoMunId) references Edo_Mun 
);
--consulta presonalizada
select * from Usuarios inner join Edo_Mun on Usuarios.EdoMunId=1890 where Edo_Mun.EdoMunId=1890

--seleccionar un solo estado con su municipio
select * from Edo_Mun 
	inner join Municipio on Municipio.municipioId=1890 
	inner join Estados on Estados.estadosId=26 
		where Edo_Mun.EdoMunId=1890 
				and Municipio.municipio='hermosillo' 
				and Estados.estado='Sonora'

exec UsuarioProcedure 'carlos','ramon valdez 854 machi lopez', 6621838830,83120,'Administrador','userExamen', '*Examen2021',1890

exec UsuariosDelete 'userExamen'

exec UsuariosUpdate 'carlos','ramon valdez 854 machi lopez', 6621838830,83120,'Administrador','userExamen', '*Examen2021',1890

exec UsuariosLeer 1890
