USE [master]
GO

/****** Object: Database [Bank] Script Date: 30/11/2023 1:45:04 ******/
CREATE DATABASE [Bank]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Banco', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Banco.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Banco_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Banco_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Bank] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bank].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bank] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bank] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bank] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bank] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bank] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bank] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bank] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bank] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bank] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bank] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bank] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bank] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bank] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bank] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bank] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bank] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bank] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bank] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bank] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bank] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bank] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bank] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Bank] SET  MULTI_USER 
GO
ALTER DATABASE [Bank] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bank] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bank] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bank] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bank] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bank] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Bank] SET QUERY_STORE = ON
GO
ALTER DATABASE [Bank] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Bank]
GO

/****** Object:  Table [dbo].[Account]    Script Date: 30/11/2023 1:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [AccountType] [int] NOT NULL,
    [ClientID] [int] NULL,
    [Balance] [decimal](10, 2) NOT NULL,
    [RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
    [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[AccountType]    Script Date: 30/11/2023 1:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountType](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [varchar](100) NOT NULL,
    [RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
    [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Administrator]    Script Date: 30/11/2023 1:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Administrator](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [varchar](200) NOT NULL,
    [PhoneNumber] [varchar](40) NOT NULL,
    [Email] [varchar](50) NOT NULL,
    [Pwd] [varchar](50) NOT NULL,
    [AdminType] [varchar](30) NOT NULL,
    [RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
    [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BankTransaction]    Script Date: 30/11/2023 1:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankTransaction](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [AccountID] [int] NOT NULL,
    [TransactionType] [int] NOT NULL,
    [Amount] [decimal](10, 2) NOT NULL,
    [ExternalAccount] [int] NULL,
    [RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
    [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Client]    Script Date: 30/11/2023 1:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [varchar](200) NOT NULL,
    [PhoneNumber] [varchar](40) NOT NULL,
    [Email] [varchar](50) NULL,
    [RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
    [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[TransactionType]    Script Date: 30/11/2023 1:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionType](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Name] [varchar](100) NOT NULL,
    [RegDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
    [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[Account] ON 
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (1, 1, 1, CAST(5000.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (2, 2, 2, CAST(800.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (3, 3, 3, CAST(10000.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (4, 1, 4, CAST(250.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (5, 2, 5, CAST(1200.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (6, 3, 6, CAST(15000.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (7, 1, 7, CAST(300.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (8, 2, 8, CAST(5000.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (9, 3, 9, CAST(7500.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (10, 1, 10, CAST(1000.00 AS Decimal(10, 2)), CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (11, 1, 1, CAST(300.00 AS Decimal(10, 2)), CAST(N'2023-11-29T22:44:02.730' AS DateTime))
INSERT [dbo].[Account] ([ID], [AccountType], [ClientID], [Balance], [RegDate]) VALUES (12, 1, 1, CAST(1000.00 AS Decimal(10, 2)), CAST(N'2023-11-29T23:18:04.533' AS DateTime))
SET IDENTITY_INSERT [dbo].[Account] OFF
GO

SET IDENTITY_INSERT [dbo].[AccountType] ON 
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (1, N'Savings Account', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (2, N'Checking Account', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (3, N'Fixed Deposit Account', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (4, N'Money Market Account', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (5, N'Certificate of Deposit', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (6, N'Retirement Account', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (7, N'Business Account', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (8, N'Joint Account', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (9, N'Student Account', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
INSERT [dbo].[AccountType] ([ID], [Name], [RegDate]) VALUES (10, N'Money Market Savings', CAST(N'2023-11-28T18:12:44.650' AS DateTime))
SET IDENTITY_INSERT [dbo].[AccountType] OFF
GO

SET IDENTITY_INSERT [dbo].[Administrator] ON 
INSERT [dbo].[Administrator] ([ID], [Name], [PhoneNumber], [Email], [Pwd], [AdminType], [RegDate]) VALUES (3, N'James', N'123-456-7890', N'james@gmail.com', N'1234', N'SuperAdmin', CAST(N'2023-11-30T01:13:20.973' AS DateTime))
INSERT [dbo].[Administrator] ([ID], [Name], [PhoneNumber], [Email], [Pwd], [AdminType], [RegDate]) VALUES (4, N'Carlos', N'987-654-3210', N'carlos@gmail.com', N'1234', N'Viewer', CAST(N'2023-11-30T01:13:20.973' AS DateTime))
SET IDENTITY_INSERT [dbo].[Administrator] OFF
GO

SET IDENTITY_INSERT [dbo].[BankTransaction] ON 
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (1, 1, 1, CAST(1000.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (2, 2, 2, CAST(200.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (3, 3, 1, CAST(5000.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (4, 4, 2, CAST(50.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (5, 5, 1, CAST(800.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (6, 6, 2, CAST(1000.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (7, 7, 1, CAST(200.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (8, 8, 2, CAST(1500.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (9, 9, 1, CAST(3000.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[BankTransaction] ([ID], [AccountID], [TransactionType], [Amount], [ExternalAccount], [RegDate]) VALUES (10, 10, 2, CAST(500.00 AS Decimal(10, 2)), NULL, CAST(N'2023-11-28T18:12:44.653' AS DateTime))
SET IDENTITY_INSERT [dbo].[BankTransaction] OFF
GO

SET IDENTITY_INSERT [dbo].[Client] ON 
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (1, N'John Doe', N'555-1234', N'john.doe@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (2, N'Jane Smith', N'555-5678', N'jane.smith@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (3, N'Robert Johnson', N'555-9012', N'robert.j@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (4, N'Mary White', N'555-3456', N'mary.white@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (5, N'Michael Brown', N'555-7890', N'michael.b@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (6, N'Emily Davis', N'555-2345', N'emily.d@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (7, N'David Wilson', N'555-6789', N'david.w@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (8, N'Olivia Moore', N'555-0123', N'olivia.m@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (9, N'William Lee', N'555-4567', N'william.l@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (10, N'Sophia Anderson', N'555-8901', N'sophia.a@email.com', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[Client] ([ID], [Name], [PhoneNumber], [Email], [RegDate]) VALUES (11, N'Clara', N'099005214', N'clara@gmail.com', CAST(N'2023-11-29T00:30:54.963' AS DateTime))
SET IDENTITY_INSERT [dbo].[Client] OFF
GO

SET IDENTITY_INSERT [dbo].[TransactionType] ON 
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (1, N'Deposit', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (2, N'Withdrawal', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (3, N'Transfer', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (4, N'Payment', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (5, N'Purchase', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (6, N'Interest', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (7, N'Fee', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (8, N'Adjustment', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (9, N'Conversion', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
INSERT [dbo].[TransactionType] ([ID], [Name], [RegDate]) VALUES (10, N'Other', CAST(N'2023-11-28T18:12:44.653' AS DateTime))
SET IDENTITY_INSERT [dbo].[TransactionType] OFF
GO

ALTER TABLE [dbo].[Account] ADD  DEFAULT (getdate()) FOR [RegDate]
GO

ALTER TABLE [dbo].[AccountType] ADD  DEFAULT (getdate()) FOR [RegDate]
GO

ALTER TABLE [dbo].[Administrator] ADD  DEFAULT (getdate()) FOR [RegDate]
GO

ALTER TABLE [dbo].[BankTransaction] ADD  DEFAULT (getdate()) FOR [RegDate]
GO

ALTER TABLE [dbo].[Client] ADD  DEFAULT (getdate()) FOR [RegDate]
GO

ALTER TABLE [dbo].[TransactionType] ADD  DEFAULT (getdate()) FOR [RegDate]
GO

ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([AccountType])
REFERENCES [dbo].[AccountType] ([ID])
GO

ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([AccountType])
REFERENCES [dbo].[AccountType] ([ID])
GO

ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ID])
GO

ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ID])
GO

ALTER TABLE [dbo].[BankTransaction]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID])
GO

ALTER TABLE [dbo].[BankTransaction]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID])
GO

ALTER TABLE [dbo].[BankTransaction]  WITH CHECK ADD FOREIGN KEY([TransactionType])
REFERENCES [dbo].[TransactionType] ([ID])
GO

ALTER TABLE [dbo].[BankTransaction]  WITH CHECK ADD FOREIGN KEY([TransactionType])
REFERENCES [dbo].[TransactionType] ([ID])
GO

-- Configurar eliminación en cascada para la clave foránea en la tabla BankTransaction
ALTER TABLE [dbo].[BankTransaction]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID])
ON DELETE CASCADE;

USE [master]
GO

ALTER DATABASE [Bank] SET  READ_WRITE 
GO


