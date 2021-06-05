CREATE PROC UsuarioProcedure
	@nombre       varchar(50) ,
	@direccion    varchar(100),
	@telefono     varchar(100),
	@codigoPostal int ,
	@tipoUsuario  varchar(50) ,
	@username	  varchar(50),
	@password	  varchar(30),
	@EdoMunId	  int
AS 
BEGIN
	IF NOT EXISTS (SELECT * FROM Usuarios WHERE username=@username)
	BEGIN
		BEGIN TRAN CREAR_USUARIO
			INSERT INTO Usuarios 
			(nombre,direccion,telefono,codigoPostal,tipoUsuario,username,password,EdoMunId)
			VALUES (@nombre,@direccion,@telefono,@codigoPostal,@tipoUsuario,@username,@password,@EdoMunId)
				IF @@ERROR = 0
			BEGIN
				PRINT 'USUARIO CREADO CON EXITO'
					COMMIT TRAN CREAR_USUARIO
					END
				ELSE
			BEGIN
			PRINT 'OCURRIO UN ERROR AL INSERTAR'
				ROLLBACK TRAN CREAR_USUARIO
			END
		END
	ELSE
	IF EXISTS (SELECT * FROM Usuarios WHERE username=@username)
		BEGIN
		PRINT 'ESTE USUARIO YA EXISTE'
			RETURN
		END
	END
GO

--Stored Procedures Read
CREATE PROC UsuariosLeer
	@EdoMunId int
AS 
	BEGIN 
		SELECT * FROM Usuarios inner join Edo_Mun on Usuarios.EdoMunId=@EdoMunId WHERE Edo_Mun.EdoMunId = @EdoMunId
	END
GO

--Stored Procedures Update
CREATE PROC UsuariosUpdate
    @nombre       varchar(50) ,
	@direccion    varchar(100),
	@telefono     varchar(100),
	@codigoPostal int ,
	@tipoUsuario  varchar(50) ,
	@username	  varchar(50),
	@password	  varchar(30),
	@EdoMunId	  int
AS 
BEGIN 
	IF NOT EXISTS (SELECT * FROM Usuarios WHERE username=@username)
	BEGIN
		PRINT 'ESTE USUARIO NO EXISTE'
			RETURN
	END
	IF EXISTS (SELECT * FROM Usuarios WHERE username=@username)
	BEGIN
		UPDATE Usuarios
		SET nombre = @nombre,
			direccion = @direccion,
			telefono = @telefono,
			codigoPostal = @codigoPostal,
			tipoUsuario = @tipoUsuario,
			username = @username,
			password = @password,
			EdoMunId = @EdoMunId	 
		WHERE  username = @username
		PRINT 'USUARIO ACTUALIZADO'
			RETURN
	END
END
GO

--Stored Procedures Delete
CREATE PROCEDURE UsuariosDelete 
    @username varchar(50)
AS 
BEGIN
	IF NOT EXISTS (SELECT * FROM Usuarios WHERE username=@username)
	BEGIN
		PRINT 'ESTE USUARIO NO EXISTE'
			RETURN
	END
	IF EXISTS (SELECT * FROM Usuarios WHERE username=@username)
	BEGIN
		DELETE Usuarios WHERE  username = @username
		PRINT 'USUARIO ELIMINADO'
		RETURN
	END
END
 