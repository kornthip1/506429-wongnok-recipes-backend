USE [master]
GO
/****** Object:  Database [WongnokDB]    Script Date: 25/5/2568 15:38:14 ******/
CREATE DATABASE [WongnokDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WongnokDB', FILENAME = N'C:\Users\KornthipWh\WongnokDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WongnokDB_log', FILENAME = N'C:\Users\KornthipWh\WongnokDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [WongnokDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WongnokDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WongnokDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WongnokDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WongnokDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WongnokDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WongnokDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [WongnokDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WongnokDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WongnokDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WongnokDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WongnokDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WongnokDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WongnokDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WongnokDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WongnokDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WongnokDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WongnokDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WongnokDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WongnokDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WongnokDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WongnokDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WongnokDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WongnokDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WongnokDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WongnokDB] SET  MULTI_USER 
GO
ALTER DATABASE [WongnokDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WongnokDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WongnokDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WongnokDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WongnokDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WongnokDB] SET QUERY_STORE = OFF
GO
USE [WongnokDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [WongnokDB]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipe](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Recipe_ID]  AS ('MENU'+CONVERT([varchar](10),[ID])),
	[USERID] [int] NULL,
	[MenuName] [varchar](200) NULL,
	[Ingredient] [varchar](max) NULL,
	[Step] [varchar](max) NULL,
	[Times] [varchar](10) NULL,
	[Levels] [varchar](10) NULL,
	[ImageRecipe] [varchar](max) NULL,
	[Rating] [varchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ref_Time]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ref_Time](
	[Time_ID] [varchar](10) NULL,
	[Period_Desc] [varchar](200) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction_Rating]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction_Rating](
	[RecipeID] [varchar](200) NULL,
	[UserID] [int] NULL,
	[Score] [decimal](18, 2) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Uername] [varchar](200) NULL,
	[FirstName] [varchar](200) NULL,
	[LastName] [varchar](200) NULL,
	[Email] [varchar](200) NULL,
	[Password] [varchar](200) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spChcek_Login]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spChcek_Login](

	       @UserName	 varchar(200)	,
           @Password	 varchar(max)	

)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT   [ID]
		  , CONCAT([FirstName] , ' ',[LastName])  AS  [Uername]
		  ,[FirstName]
		  ,[LastName]
		  ,[Email]
		  ,[Password]
		  ,[CreatedDate]
		  ,[UpdatedDate]
	  FROM [WongnokDB].[dbo].[User]	 WITH(NOLOCK)
	  WHERE [Email] = @UserName
	  and [Password] =  @Password

END
GO
/****** Object:  StoredProcedure [dbo].[spDelete_RecipeByID]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDelete_RecipeByID](

	@RecipeID  Varchar(10)

)
	
AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		DELETE FROM [WongnokDB].[dbo].[Recipe]  WHERE  [Recipe_ID] = @RecipeID



END
GO
/****** Object:  StoredProcedure [dbo].[spInsert_Recipe]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsert_Recipe](

	       @MenuName	 varchar(200)	,
           @Ingredient	 varchar(max)	,
           @Step		varchar(max)	,
           @Times		varchar(10)	,
           @Levels		varchar(10)	,
           @ImageRecipe	 varchar(max)=NULL	,
		   @USERID  varchar(100),
		   @RecipeID  varchar(100)

)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--IF NOT EXISTS (select 1 from [dbo].[Recipe]  WHERE [Uername] = @Uername)
	--BEGIN
	IF LEFT(@RecipeID,4) <> 'MENU' 
	BEGIN

			INSERT INTO [dbo].[Recipe]
				   ([USERID]
				   ,[MenuName]
				   ,[Ingredient]
				   ,[Step]
				   ,[Times]
				   ,[Levels]
				   ,[ImageRecipe]
           
				   ,[CreatedDate]
				   )
			 VALUES
				   ( @USERID
				   ,@MenuName
				   ,@Ingredient
				   ,@Step
				   ,@Times
				   ,@Levels
				   ,@ImageRecipe
				   ,GETDATE()
				   )

		SELECT 'Success'  As Result


	END
	ELSE 
	BEGIN

		UPDATE [dbo].[Recipe]
		SET   
			   [MenuName] = @MenuName
			  ,[Ingredient] = @Ingredient
			  ,[Step] = @Step
			  ,[Times] = @Times
			  ,[Levels] = @Levels
			  ,[ImageRecipe] = @ImageRecipe
			  ,[UpdatedDate] = getdate()
		WHERE [Recipe_ID]  = @RecipeID
		
	END


END
GO
/****** Object:  StoredProcedure [dbo].[spInsert_Transaction_Rating]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsert_Transaction_Rating](

			@RecipeID  varchar(100),
		    @USERID  varchar(100),
		    @Score int
	       
		   

)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT  EXISTS (SELECT 1 FROM [Transaction_Rating] WHERE [RecipeID] = @RecipeID AND [UserID] = @USERID)
	BEGIN
		INSERT INTO [dbo].[Transaction_Rating]
			   ([RecipeID]
			   ,[UserID]
			   ,[Score]
			   ,[CreatedDate]
			   )
		 VALUES
			   (@RecipeID
			   ,@USERID
			   ,@Score
			   ,GETDATE()
			   )

		SELECT 'Success' AS Result;


		----- update total  score
		Declare @ScoreToral  decimal(18,2)
		SELECT  @ScoreToral = SUM([Score])/COUNT([UserID]) 
		FROM [dbo].[Transaction_Rating]
		WHERE [RecipeID] = @RecipeID


		UPDATE [WongnokDB].[dbo].[Recipe]
		SET [Rating] = @ScoreToral
		WHERE [Recipe_ID] = @RecipeID


	END
	ELSE
	BEGIN
		SELECT 'Exists' AS Result;
	END


END
GO
/****** Object:  StoredProcedure [dbo].[spInsert_User]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsert_User](

	@Uername Varchar(200)=NULL,
	@FirstName Varchar(200),
	@LastName Varchar(200)
	,@Email Varchar(200)
	,@Password Varchar(200)

)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS (select 1 from [dbo].[User]  WHERE [Email] = @Email)
	BEGIN

			INSERT INTO [dbo].[User]
				   ([Uername]
				   ,[FirstName]
				   ,[LastName]
				   ,[Email]
				   ,[Password]
				   ,[CreatedDate]
				   )
			 VALUES
				   (@Uername
				   ,@FirstName
				   ,@LastName
				   ,@Email
				   ,@Password
				   ,GETDATE()
				   )

		SELECT 'success'  As Result

	END
	ELSE 
	BEGIN
		SELECT 'Already User'  As Result;
	END


END
GO
/****** Object:  StoredProcedure [dbo].[spSelect_Recipe]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSelect_Recipe]
	
AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;


		select [RecipeID] , count([UserID]) AS Voter
		INTO #DataVote
		from [WongnokDB].[dbo].[Transaction_Rating]
		group by [RecipeID]

		SELECT [ID]
		  ,[Recipe_ID]
		  ,[USERID]
		  ,[MenuName]
		  ,[Ingredient]
		  ,[Step]
		  ,T2.Period_Desc AS [Times]
		  ,[Levels]
		  ,[ImageRecipe]
		  ,[Rating]
		  ,T3.Voter
		  ,T1.[CreatedDate]
		  ,[UpdatedDate]
	  FROM [WongnokDB].[dbo].[Recipe] T1 WITH(NOLOCK)
	  LEFT JOIN Ref_Time T2
	  ON T1.Times = T2.Time_ID
	  LEFT JOIN #DataVote T3
	  ON T1.Recipe_ID = T3.RecipeID

	  DROP TABLE #DataVote
END
GO
/****** Object:  StoredProcedure [dbo].[spSelect_RecipeByID]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSelect_RecipeByID](

	@UserID  int

)
	
AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		SELECT [ID]
		  ,[Recipe_ID]
		  ,[USERID]
		  ,[MenuName]
		  ,[Ingredient]
		  ,[Step]
		  ,T2.Period_Desc AS [Times]
		  ,[Levels]
		  ,[ImageRecipe]
		  ,[Rating]
		  ,T1.[CreatedDate]
		  ,[UpdatedDate]
	  FROM [WongnokDB].[dbo].[Recipe] T1 WITH(NOLOCK)
	  LEFT JOIN Ref_Time T2
	  ON T1.Times = T2.Time_ID
	  where [USERID] = @UserID


END
GO
/****** Object:  StoredProcedure [dbo].[spTest]    Script Date: 25/5/2568 15:38:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spTest] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 'success'
END
GO
USE [master]
GO
ALTER DATABASE [WongnokDB] SET  READ_WRITE 
GO
