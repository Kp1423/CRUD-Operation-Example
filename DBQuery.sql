USE [master]
GO
/****** Object:  Database [DevItPractical]    Script Date: 25-03-2021 11:35:09 ******/
CREATE DATABASE [DevItPractical]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DevItPractical', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DevItPractical.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DevItPractical_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DevItPractical_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DevItPractical] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DevItPractical].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DevItPractical] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DevItPractical] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DevItPractical] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DevItPractical] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DevItPractical] SET ARITHABORT OFF 
GO
ALTER DATABASE [DevItPractical] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DevItPractical] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DevItPractical] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DevItPractical] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DevItPractical] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DevItPractical] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DevItPractical] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DevItPractical] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DevItPractical] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DevItPractical] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DevItPractical] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DevItPractical] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DevItPractical] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DevItPractical] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DevItPractical] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DevItPractical] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DevItPractical] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DevItPractical] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DevItPractical] SET  MULTI_USER 
GO
ALTER DATABASE [DevItPractical] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DevItPractical] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DevItPractical] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DevItPractical] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DevItPractical] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DevItPractical]
GO
/****** Object:  Table [dbo].[CustomerMaster]    Script Date: 25-03-2021 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerMaster](
	[CustId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[OrderDate] [datetime] NULL,
	[Quantity] [int] NULL,
	[Amount] [int] NULL,
	[ItemId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemMaster]    Script Date: 25-03-2021 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemMaster](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](50) NULL,
	[Price] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[CustomerMaster]  WITH CHECK ADD  CONSTRAINT [FK_CustomerItem] FOREIGN KEY([ItemId])
REFERENCES [dbo].[ItemMaster] ([ItemId])
GO
ALTER TABLE [dbo].[CustomerMaster] CHECK CONSTRAINT [FK_CustomerItem]
GO
/*********************************Add Items into ItemMaster***************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
USE DevItPractical
GO
INSERT INTO ItemMaster (ItemName, Price) VALUES ('Item 1',10),
('Item 2',20),
('Item 3',30),
('Item 4',40),
('Item 5',50),
('Item 6',60),
('Item 7',70),
('Item 8',80),
('Item 9',90),
('Item 10',100);
GO
/****** Object:  StoredProcedure [dbo].[PR_DeleteOrder]    Script Date: 25-03-2021 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[PR_DeleteOrder]
@CustId int
AS
BEGIN
	Delete From CustomerMaster Where CustId = @CustId
END 

GO
/****** Object:  StoredProcedure [dbo].[PR_GetItemList]    Script Date: 25-03-2021 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[PR_GetItemList]
AS
BEGIN
	SELECT ItemId ,ItemName From ItemMaster order by ItemId asc
END 

GO
/****** Object:  StoredProcedure [dbo].[PR_GetOrder]    Script Date: 25-03-2021 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[PR_GetOrder]
AS
BEGIN
	SELECT c.CustId as Sr, c.CustomerName, c.OrderDate, i.ItemName, i.Price, c.Quantity, c.Amount
	From CustomerMaster c
	left join ItemMaster i
	ON c.ItemId = i.ItemId

END 

GO
/****** Object:  StoredProcedure [dbo].[PR_InsertOrder]    Script Date: 25-03-2021 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[PR_InsertOrder]
@CustName nvarchar(50),
@ItemId int,
@OrderDate datetime,
@Quantity int
AS
BEGIN
	declare @price int = (Select Price from ItemMaster where ItemId = @ItemId);
	declare @totalprice int = (@price * @Quantity);

	INSERT INTO CustomerMaster (CustomerName, OrderDate, Quantity, Amount, ItemId)  
	VALUES (@CustName, @OrderDate, @Quantity, @totalprice, @ItemId)
END 

GO
/****** Object:  StoredProcedure [dbo].[PR_UpdateOrder]    Script Date: 25-03-2021 11:35:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[PR_UpdateOrder]
@CustName nvarchar(50),
@ItemId int,
@OrderDate datetime,
@Quantity int,
@CustId int
AS
BEGIN
	declare @price int = (Select Price from ItemMaster where ItemId = @ItemId);
	declare @totalprice int = (@price * @Quantity);

	Update CustomerMaster Set CustomerName = @CustName, OrderDate =@OrderDate, Quantity =@Quantity,
	Amount = @totalprice, ItemId = @ItemId Where CustId = @CustId
END 

GO
USE [master]
GO
ALTER DATABASE [DevItPractical] SET  READ_WRITE 
GO
