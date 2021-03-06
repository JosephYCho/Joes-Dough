USE [OpenForce]
GO
/****** Object:  Table [dbo].[Pizzas]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizzas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Pizzas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PizzaToppings]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PizzaToppings](
	[PizzaId] [int] NOT NULL,
	[ToppingId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Toppings]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Toppings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Toppings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pizzas] ADD  CONSTRAINT [DF_Pizzas_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Pizzas] ADD  CONSTRAINT [DF_Pizzas_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[Toppings] ADD  CONSTRAINT [DF_Toppings_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Toppings] ADD  CONSTRAINT [DF_Toppings_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO
ALTER TABLE [dbo].[PizzaToppings]  WITH CHECK ADD  CONSTRAINT [FK_PizzaToppings_Pizzas] FOREIGN KEY([PizzaId])
REFERENCES [dbo].[Pizzas] ([Id])
GO
ALTER TABLE [dbo].[PizzaToppings] CHECK CONSTRAINT [FK_PizzaToppings_Pizzas]
GO
ALTER TABLE [dbo].[PizzaToppings]  WITH CHECK ADD  CONSTRAINT [FK_PizzaToppings_Toppings] FOREIGN KEY([ToppingId])
REFERENCES [dbo].[Toppings] ([Id])
GO
ALTER TABLE [dbo].[PizzaToppings] CHECK CONSTRAINT [FK_PizzaToppings_Toppings]
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_Delete]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_Delete]

@Id INT

AS
/*
	DECLARE
		@Id INT = 1
	EXEC dbo.Pizzas_Delete
		@Id
*/
BEGIN
	DELETE FROM dbo.Pizzas
	WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_Delete_V2]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_Delete_V2]
@Id INT

AS

/*
	DECLARE 
		@Id INT = 18
	EXEC dbo.Pizzas_Delete_V2
		@Id

*/
BEGIN

BEGIN TRAN
SET XACT_ABORT ON
	DELETE FROM dbo.PizzaToppings
	WHERE PizzaId = @Id
	DELETE FROM dbo.Pizzas
	WHERE Id = @Id
	
	

COMMIT TRANSACTION
	


END
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_GetAll]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_GetAll]


AS
/*
	EXEC dbo.Pizzas_GetAll

*/


BEGIN
	SELECT
		Id,
		Name,
		DateCreated,
		DateModified

	FROM dbo.Pizzas





END
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_GetAllToppingByPizzaId]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_GetAllToppingByPizzaId]

@PizzaId INT

AS



BEGIN

/*
	DECLARE
		@PizzaId INT = 23

	EXEC dbo.Pizzas_GetAllToppingByPizzaId
		@PizzaId
*/



SELECT
		t.Name
	
	FROM 
		dbo.Pizzas AS p
	INNER JOIN
		dbo.PizzaToppings as pt ON p.Id = pt.PizzaId
	INNER JOIN 
		dbo.Toppings as t ON pt.ToppingId = t.Id

	WHERE
		p.id = @PizzaId






END
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_GetAllWithToppings]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_GetAllWithToppings]

	--@Id INT 

AS

/*

	DECLARE 
		@Id INT = 23
	EXEC dbo.Pizzas_GetAllWithToppings
		@Id


*/


BEGIN

	SELECT 
		p.Id,
		p.Name,
		p.DateCreated,
		p.DateModified

	FROM 
		dbo.Pizzas AS p
	

	SELECT
		t.Name
	
	FROM 
		dbo.Pizzas AS p
	INNER JOIN
		dbo.PizzaToppings as pt ON p.Id = pt.PizzaId
	INNER JOIN 
		dbo.Toppings as t ON pt.ToppingId = t.Id

	WHERE
		p.id = pt.PizzaId


END
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_GetById]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_GetById]

@Id INT

AS
/*
	DECLARE
		@Id INT = 1
	EXEC dbo.Pizzas_GetById
		@Id

*/

BEGIN
	SELECT
		Id,
		Name,
		DateCreated,
		DateModified
	FROM dbo.Pizzas

	WHERE
		Id = @Id





END
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_Insert]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_Insert]

	@Id INT OUTPUT,
	@Name NVARCHAR(50)

AS

/*
	DECLARE
		@Id INT,
		@Name NVARCHAR(50) ='Pineapple Pizza'

	EXEC dbo.Pizzas_Insert
		@Id OUTPUT,
		@Name

*/


BEGIN
	INSERT INTO dbo.Pizzas
		(
			Name
		)
	VALUES
		(
			@Name
		)

	SET @Id = SCOPE_IDENTITY();


END
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_Update]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_Update]

	@Id INT,
	@Name NVARCHAR(50)

AS

/*
	DECLARE
		@Id INT = 1,
		@Name NVARCHAR(50) = 'Cheese Pizza'

	EXEC dbo.Pizzas_Update
		@Id,
		@Name

*/

BEGIN
	UPDATE dbo.Pizzas

	SET
		Name = @Name,
		DateModified = GETUTCDATE()

	WHERE
		Id = @Id



END
GO
/****** Object:  StoredProcedure [dbo].[Pizzas_Update_V2]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Pizzas_Update_V2]

	@Id INT,
	@Name NVARCHAR(50)

AS

/*
	DECLARE 
		@Id INT,
		@Name NVARCHAR(50) = 'Jamaal's Pizza'
	EXEC dbo.Pizzas_Update_V2
		@Id,
		@Name


	

*/

BEGIN
	BEGIN TRAN
	SET XACT_ABORT ON
		DELETE FROM dbo.PizzaToppings

		WHERE 
			PizzaId = @Id

		UPDATE dbo.Pizzas


		SET
			Name = @Name,
			DateModified = GETUTCDATE()

		WHERE
			Id = @Id

	COMMIT TRANSACTION

END
GO
/****** Object:  StoredProcedure [dbo].[PizzaToppings_Delete]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PizzaToppings_Delete]

	@PizzaId INT

AS

/*
	DECLARE
		@PizzaId INT = 4
	EXEC dbo. PizzaToppings_Delete
		@PizzaId


*/


BEGIN

	DELETE FROM dbo.PizzaToppings
	WHERE 
		PizzaId = @PizzaId
		


END
GO
/****** Object:  StoredProcedure [dbo].[PizzaToppings_GetAll]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PizzaToppings_GetAll]


AS
/*
	EXEC dbo.PizzaToppings_GetAll

*/


BEGIN


	SELECT 
		PizzaId,
		ToppingId
	FROM dbo.PizzaToppings

	


END
GO
/****** Object:  StoredProcedure [dbo].[PizzaToppings_Insert]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PizzaToppings_Insert]

	@PizzaId INT,
	@ToppingId INT

AS
/*
	DECLARE
		@PizzaId INT,
		@ToppingId INT

	EXEC dbo.PizzaToppings_Insert
		@PizzaId 
		@ToppingId

*/


BEGIN

	INSERT INTO dbo.PizzaToppings
		(
			PizzaId,
			ToppingId
		)
	VALUES
		(
			@PizzaId,
			@ToppingId
		)


END
GO
/****** Object:  StoredProcedure [dbo].[Toppings_Delete]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Toppings_Delete]

	@Id INT

AS

/*
	DECLARE
		@Id INT = 1
	EXEC dbo.Toppings_Delete
		@Id

*/


BEGIN

	DELETE FROM dbo.Toppings
	WHERE Id = @Id

END
GO
/****** Object:  StoredProcedure [dbo].[Toppings_GetAll]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Toppings_GetAll]

AS
/*
	EXEC dbo.Toppings_GetAll

*/

BEGIN
	
	SELECT
		Id,
		Name,
		DateCreated,
		DateModified
	FROM dbo.Toppings



END
GO
/****** Object:  StoredProcedure [dbo].[Toppings_GetById]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Toppings_GetById]

@Id INT

AS
/*

	DECLARE
		@Id INT = 1
	EXEC dbo.Toppings_GetById
		@Id

*/



BEGIN

	SELECT
		Id,
		Name,
		DateCreated,
		DateModified
	FROM dbo.Toppings

	WHERE 
		Id = @Id


END
GO
/****** Object:  StoredProcedure [dbo].[Toppings_Insert]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Toppings_Insert]

	@Id INT OUTPUT,
	@Name NVARCHAR(50)

AS
/*
	DECLARE
		@Id INT,
		@Name NVARCHAR(50)='cheese'
	EXEC dbo.Toppings_Insert
		@Id OUTPUT,
		@Name

*/



BEGIN


	INSERT INTO dbo.Toppings
		(
			Name
		)
	VALUES
		(
		@Name
		)

	SET @Id = SCOPE_IDENTITY();

END
GO
/****** Object:  StoredProcedure [dbo].[Toppings_Update]    Script Date: 5/8/2019 9:13:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Toppings_Update]

	@Id INT,
	@Name NVARCHAR(50)


AS

/*

	DECLARE
		@Id INT = 1,
		@Name NVARCHAR(50) = 'onions'

	EXEC dbo.Toppings_Update
		@Id,
		@Name

*/


BEGIN

	UPDATE dbo.Toppings

	SET
		Name = @Name,
		DateModified = GETUTCDATE()

	WHERE
		Id = @Id
		


END
GO
