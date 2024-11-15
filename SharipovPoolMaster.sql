USE [master]
GO
/****** Object:  Database [SharipovPolMaster]    Script Date: 11.11.2024 9:21:57 ******/
CREATE DATABASE [SharipovPolMaster]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SharipovPolMaster', FILENAME = N'W:\Program file\MSSQL16.MSSQLSERVER\MSSQL\DATA\SharipovPolMaster.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SharipovPolMaster_log', FILENAME = N'W:\Program file\MSSQL16.MSSQLSERVER\MSSQL\DATA\SharipovPolMaster_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SharipovPolMaster].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SharipovPolMaster] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET ARITHABORT OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SharipovPolMaster] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SharipovPolMaster] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SharipovPolMaster] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SharipovPolMaster] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SharipovPolMaster] SET  MULTI_USER 
GO
ALTER DATABASE [SharipovPolMaster] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SharipovPolMaster] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SharipovPolMaster] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SharipovPolMaster] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SharipovPolMaster] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SharipovPolMaster', N'ON'
GO
USE [SharipovPolMaster]
GO
/****** Object:  User [egor]    Script Date: 11.11.2024 9:21:58 ******/
CREATE USER [egor] FOR LOGIN [egor] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [egor]
GO
/****** Object:  Table [dbo].[Единицы измерения]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Единицы измерения](
	[ИД] [int] IDENTITY(1,1) NOT NULL,
	[Единица измерения] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Единицы измерения] PRIMARY KEY CLUSTERED 
(
	[ИД] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Заявки]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Заявки](
	[ИД] [int] NOT NULL,
	[Продукт] [nvarchar](10) NOT NULL,
	[Партнер] [int] NOT NULL,
	[Количество продукции] [int] NOT NULL,
	[Дата продажи] [date] NOT NULL,
	[ИД Сотрудника] [int] NULL,
 CONSTRAINT [PK_Заявки] PRIMARY KEY CLUSTERED 
(
	[ИД] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[История изменений количества материала на складе]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[История изменений количества материала на складе](
	[Артикул] [nvarchar](10) NOT NULL,
	[Дата] [date] NOT NULL,
	[Количество] [int] NOT NULL,
 CONSTRAINT [PK_история изменений количества материала на складе] PRIMARY KEY CLUSTERED 
(
	[Артикул] ASC,
	[Дата] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[История изменения минимальной стоимости для партнера]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[История изменения минимальной стоимости для партнера](
	[Артикул] [nvarchar](10) NOT NULL,
	[Партнер] [int] NOT NULL,
	[Минимальная стоимость] [decimal](18, 2) NOT NULL,
	[Дата] [date] NULL,
 CONSTRAINT [PK_История изменения минимальной стоимости для партнера] PRIMARY KEY CLUSTERED 
(
	[Артикул] ASC,
	[Партнер] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[История поставок материалов]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[История поставок материалов](
	[Артикул] [nvarchar](10) NOT NULL,
	[Поставщик] [int] NOT NULL,
	[Дата] [date] NOT NULL,
	[Количество] [int] NOT NULL,
	[ИД Сотрудника] [int] NOT NULL,
 CONSTRAINT [PK_История поставок материалов_1] PRIMARY KEY CLUSTERED 
(
	[Артикул] ASC,
	[Поставщик] ASC,
	[ИД Сотрудника] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Материалы]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Материалы](
	[Артикул] [nvarchar](10) NOT NULL,
	[Тип продукции] [int] NOT NULL,
	[Наимнование продукции] [nvarchar](50) NOT NULL,
	[Минимальная стоимость для партнера] [float] NOT NULL,
	[Поставщик] [int] NOT NULL,
	[Количество в упаковке] [int] NOT NULL,
	[Единица измерения] [int] NOT NULL,
	[Описание] [nvarchar](50) NULL,
	[Изображение] [image] NULL,
	[Стоимость] [decimal](18, 2) NOT NULL,
	[Количество на складе] [int] NOT NULL,
	[Минимальное допустимое количество] [int] NOT NULL,
 CONSTRAINT [PK_Материалы_1] PRIMARY KEY CLUSTERED 
(
	[Артикул] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Материалы для продукции]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Материалы для продукции](
	[Артикул] [nvarchar](10) NOT NULL,
	[Материал] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Материалы для продукции] PRIMARY KEY CLUSTERED 
(
	[Артикул] ASC,
	[Материал] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Партнеры]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Партнеры](
	[ИД] [int] IDENTITY(1,1) NOT NULL,
	[Форма организации] [int] NOT NULL,
	[Наименование] [nvarchar](100) NOT NULL,
	[Фамилия] [nvarchar](50) NOT NULL,
	[Имя] [nvarchar](50) NOT NULL,
	[Отчество] [nvarchar](50) NULL,
	[Электронная почта] [nvarchar](50) NOT NULL,
	[Телефон] [nvarchar](50) NOT NULL,
	[Индекс] [int] NOT NULL,
	[Область] [nvarchar](50) NOT NULL,
	[Город] [nvarchar](50) NOT NULL,
	[Улица] [nvarchar](50) NOT NULL,
	[Дом] [nvarchar](10) NOT NULL,
	[ИНН] [nvarchar](20) NOT NULL,
	[Рейтинг] [float] NOT NULL,
 CONSTRAINT [PK_Партнеры] PRIMARY KEY CLUSTERED 
(
	[ИД] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Поставщики]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Поставщики](
	[ИД] [int] IDENTITY(1,1) NOT NULL,
	[Наимнование поставщика] [nvarchar](50) NOT NULL,
	[ИНН] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Поставщики] PRIMARY KEY CLUSTERED 
(
	[ИД] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Продукция]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Продукция](
	[Артикул] [nvarchar](10) NOT NULL,
	[Тип продукции] [int] NOT NULL,
	[Наименование] [nvarchar](500) NOT NULL,
	[Минимальная стоимость для партнера] [decimal](18, 2) NOT NULL,
	[Описание] [nvarchar](50) NULL,
	[Изображение] [image] NULL,
	[Длинна] [int] NULL,
	[Ширина] [int] NULL,
	[Высота] [int] NULL,
	[Вес без упаковки] [float] NULL,
	[Вес с упаковкой] [float] NULL,
	[Сертификат качества] [image] NULL,
	[Номер стандарта] [nvarchar](10) NULL,
	[Время изготовления] [int] NULL,
	[Себестоимость] [decimal](18, 2) NULL,
	[Номер цеха] [int] NULL,
	[Количество человек на производстве] [int] NULL,
 CONSTRAINT [PK_Продукция_1] PRIMARY KEY CLUSTERED 
(
	[Артикул] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Сотрудники]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Сотрудники](
	[ИД] [int] IDENTITY(1,1) NOT NULL,
	[Фамилия] [nvarchar](50) NOT NULL,
	[Имя] [nvarchar](50) NOT NULL,
	[Отчество] [nvarchar](50) NULL,
	[Дата рождения] [date] NOT NULL,
	[Кем выдан] [nvarchar](max) NOT NULL,
	[Дата выдачи] [date] NOT NULL,
	[Код подразделения] [nvarchar](7) NOT NULL,
	[Серия] [nvarchar](4) NOT NULL,
	[Номер] [nvarchar](6) NOT NULL,
	[Номер расчетного счета] [nvarchar](20) NOT NULL,
	[Номер корреспондентского счета] [nvarchar](20) NOT NULL,
	[БИК] [int] NOT NULL,
	[Полное наименование банка] [nvarchar](30) NOT NULL,
	[Наличие семьи] [bit] NOT NULL,
	[Состояние здоровья] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Сотрудники] PRIMARY KEY CLUSTERED 
(
	[ИД] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Тип материала]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Тип материала](
	[ИД] [int] IDENTITY(1,1) NOT NULL,
	[Процент брака материала] [float] NOT NULL,
	[Тип материала] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Тип материала] PRIMARY KEY CLUSTERED 
(
	[ИД] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Тип продукции]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Тип продукции](
	[ИД] [int] NOT NULL,
	[Тип продукции] [nvarchar](50) NOT NULL,
	[Коэффициент типа продукции] [float] NOT NULL,
 CONSTRAINT [PK_Тип продукции] PRIMARY KEY CLUSTERED 
(
	[ИД] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Форма организации]    Script Date: 11.11.2024 9:21:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Форма организации](
	[ИД] [int] IDENTITY(1,1) NOT NULL,
	[Тип партнера] [nvarchar](3) NOT NULL,
 CONSTRAINT [PK_Форма организации] PRIMARY KEY CLUSTERED 
(
	[ИД] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Единицы измерения] ON 

INSERT [dbo].[Единицы измерения] ([ИД], [Единица измерения]) VALUES (1, N'шт        ')
INSERT [dbo].[Единицы измерения] ([ИД], [Единица измерения]) VALUES (2, N'м         ')
SET IDENTITY_INSERT [dbo].[Единицы измерения] OFF
GO
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (1, N'8858958', 2, 35000, CAST(N'2022-12-02' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (2, N'8858958', 3, 2500, CAST(N'2024-07-05' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (3, N'8858958', 5, 25000, CAST(N'2024-06-12' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (4, N'7750282', 1, 12350, CAST(N'2023-12-18' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (5, N'7750282', 2, 1000, CAST(N'2024-06-07' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (6, N'7750282', 4, 37200, CAST(N'2024-03-12' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (7, N'7750282', 5, 50000, CAST(N'2023-09-19' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (8, N'7750282', 1, 37400, CAST(N'2024-06-07' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (9, N'7750282', 4, 59050, CAST(N'2023-03-20' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (10, N'7750282', 5, 670000, CAST(N'2023-11-10' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (11, N'8758385', 1, 15500, CAST(N'2023-03-23' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (12, N'8758385', 2, 7550, CAST(N'2024-07-01' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (13, N'8758385', 3, 7250, CAST(N'2023-01-22' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (14, N'8758385', 5, 35000, CAST(N'2024-04-15' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (15, N'5012543', 2, 1250, CAST(N'2023-05-17' AS Date), NULL)
INSERT [dbo].[Заявки] ([ИД], [Продукт], [Партнер], [Количество продукции], [Дата продажи], [ИД Сотрудника]) VALUES (16, N'5012543', 4, 4500, CAST(N'2024-05-14' AS Date), NULL)
GO
INSERT [dbo].[Материалы] ([Артикул], [Тип продукции], [Наимнование продукции], [Минимальная стоимость для партнера], [Поставщик], [Количество в упаковке], [Единица измерения], [Описание], [Изображение], [Стоимость], [Количество на складе], [Минимальное допустимое количество]) VALUES (N'123', 1, N'Линолиум', 700, 3, 1, 2, N'Серый', NULL, CAST(1100.00 AS Decimal(18, 2)), 5, 2)
INSERT [dbo].[Материалы] ([Артикул], [Тип продукции], [Наимнование продукции], [Минимальная стоимость для партнера], [Поставщик], [Количество в упаковке], [Единица измерения], [Описание], [Изображение], [Стоимость], [Количество на складе], [Минимальное допустимое количество]) VALUES (N'436', 2, N'Ламинат', 1500, 2, 12, 1, N'Тёмный дуб', NULL, CAST(2300.00 AS Decimal(18, 2)), 15, 3)
INSERT [dbo].[Материалы] ([Артикул], [Тип продукции], [Наимнование продукции], [Минимальная стоимость для партнера], [Поставщик], [Количество в упаковке], [Единица измерения], [Описание], [Изображение], [Стоимость], [Количество на складе], [Минимальное допустимое количество]) VALUES (N'789', 3, N'Паркет', 4500, 4, 20, 1, N'Береза', NULL, CAST(5500.00 AS Decimal(18, 2)), 8, 5)
GO
SET IDENTITY_INSERT [dbo].[Партнеры] ON 

INSERT [dbo].[Партнеры] ([ИД], [Форма организации], [Наименование], [Фамилия], [Имя], [Отчество], [Электронная почта], [Телефон], [Индекс], [Область], [Город], [Улица], [Дом], [ИНН], [Рейтинг]) VALUES (1, 1, N'База Строитель', N'Иванова', N'Александра', N'Ивановна', N'aleksandraivanova@ml.ru', N'4931234567', 652050, N' Кемеровская область', N'Юрга', N' ул. Лесная', N'15', N'2222455179', 7)
INSERT [dbo].[Партнеры] ([ИД], [Форма организации], [Наименование], [Фамилия], [Имя], [Отчество], [Электронная почта], [Телефон], [Индекс], [Область], [Город], [Улица], [Дом], [ИНН], [Рейтинг]) VALUES (2, 2, N'Паркет 29', N'Петров', N'Василий', N'Петрович', N'vppetrov@vl.ru', N'9871235678', 164500, N' Архангельская область', N'Северодвинск', N' ул. Строителей', N'18', N'3333888520', 7)
INSERT [dbo].[Партнеры] ([ИД], [Форма организации], [Наименование], [Фамилия], [Имя], [Отчество], [Электронная почта], [Телефон], [Индекс], [Область], [Город], [Улица], [Дом], [ИНН], [Рейтинг]) VALUES (3, 3, N'Стройсервис', N'Соловьев', N'Андрей', N'Николаевич', N'ansolovev@st.ru', N'8122233200', 188910, N' Ленинградская область', N'Приморск', N' ул. Парковая', N'21', N'4440391035', 7)
INSERT [dbo].[Партнеры] ([ИД], [Форма организации], [Наименование], [Фамилия], [Имя], [Отчество], [Электронная почта], [Телефон], [Индекс], [Область], [Город], [Улица], [Дом], [ИНН], [Рейтинг]) VALUES (4, 4, N'Ремонт и отделка', N'Воробьева', N'Екатерина', N'Валерьевна', N'ekaterina.vorobeva@ml.ru', N'4442223311', 143960, N' Московская область', N'Реутов', N' ул. Свободы', N'51', N'1111520857', 5)
INSERT [dbo].[Партнеры] ([ИД], [Форма организации], [Наименование], [Фамилия], [Имя], [Отчество], [Электронная почта], [Телефон], [Индекс], [Область], [Город], [Улица], [Дом], [ИНН], [Рейтинг]) VALUES (5, 1, N'МонтажПро', N'Степанов', N'Степан', N'Сергеевич', N'stepanov@stepan.ru', N'9128883333', 309500, N' Белгородская область', N'Старый Оскол', N' ул. Рабочая', N'122', N'5552431140', 10)
SET IDENTITY_INSERT [dbo].[Партнеры] OFF
GO
SET IDENTITY_INSERT [dbo].[Поставщики] ON 

INSERT [dbo].[Поставщики] ([ИД], [Наимнование поставщика], [ИНН]) VALUES (2, N'pOl99', N'7473067445')
INSERT [dbo].[Поставщики] ([ИД], [Наимнование поставщика], [ИНН]) VALUES (3, N'Adobler', N'7237732018')
INSERT [dbo].[Поставщики] ([ИД], [Наимнование поставщика], [ИНН]) VALUES (4, N'Кедр24', N'7693616980')
SET IDENTITY_INSERT [dbo].[Поставщики] OFF
GO
INSERT [dbo].[Продукция] ([Артикул], [Тип продукции], [Наименование], [Минимальная стоимость для партнера], [Описание], [Изображение], [Длинна], [Ширина], [Высота], [Вес без упаковки], [Вес с упаковкой], [Сертификат качества], [Номер стандарта], [Время изготовления], [Себестоимость], [Номер цеха], [Количество человек на производстве]) VALUES (N'5012543', 4, N'Пробковое напольное клеевое покрытие 32 класс 4 мм', CAST(5450.59 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Продукция] ([Артикул], [Тип продукции], [Наименование], [Минимальная стоимость для партнера], [Описание], [Изображение], [Длинна], [Ширина], [Высота], [Вес без упаковки], [Вес с упаковкой], [Сертификат качества], [Номер стандарта], [Время изготовления], [Себестоимость], [Номер цеха], [Количество человек на производстве]) VALUES (N'7028748', 1, N'Ламинат Дуб серый 32 класс 8 мм с фаской', CAST(3890.41 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Продукция] ([Артикул], [Тип продукции], [Наименование], [Минимальная стоимость для партнера], [Описание], [Изображение], [Длинна], [Ширина], [Высота], [Вес без упаковки], [Вес с упаковкой], [Сертификат качества], [Номер стандарта], [Время изготовления], [Себестоимость], [Номер цеха], [Количество человек на производстве]) VALUES (N'7750282', 1, N'Ламинат Дуб дымчато-белый 33 класс 12 мм', CAST(1799.33 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Продукция] ([Артикул], [Тип продукции], [Наименование], [Минимальная стоимость для партнера], [Описание], [Изображение], [Длинна], [Ширина], [Высота], [Вес без упаковки], [Вес с упаковкой], [Сертификат качества], [Номер стандарта], [Время изготовления], [Себестоимость], [Номер цеха], [Количество человек на производстве]) VALUES (N'8758385', 3, N'Паркетная доска Ясень темный однополосная 14 мм', CAST(4456.90 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Продукция] ([Артикул], [Тип продукции], [Наименование], [Минимальная стоимость для партнера], [Описание], [Изображение], [Длинна], [Ширина], [Высота], [Вес без упаковки], [Вес с упаковкой], [Сертификат качества], [Номер стандарта], [Время изготовления], [Себестоимость], [Номер цеха], [Количество человек на производстве]) VALUES (N'8858958', 3, N'Инженерная доска Дуб Французская елка однополосная 12 мм', CAST(7330.99 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Сотрудники] ON 

INSERT [dbo].[Сотрудники] ([ИД], [Фамилия], [Имя], [Отчество], [Дата рождения], [Кем выдан], [Дата выдачи], [Код подразделения], [Серия], [Номер], [Номер расчетного счета], [Номер корреспондентского счета], [БИК], [Полное наименование банка], [Наличие семьи], [Состояние здоровья]) VALUES (13, N'Расстегаев', N'Александр', N'Сергеевич', CAST(N'2005-07-24' AS Date), N'МВД ПО РЕСПУБЛИКЕ БАШКОРТОРСТАН', CAST(N'2019-07-07' AS Date), N'330-510', N'8019', N'993109', N'50120990700000003250', N'50733144200000007452', 512583318, N'НацБизЦентБанк', 0, N'Здоров')
INSERT [dbo].[Сотрудники] ([ИД], [Фамилия], [Имя], [Отчество], [Дата рождения], [Кем выдан], [Дата выдачи], [Код подразделения], [Серия], [Номер], [Номер расчетного счета], [Номер корреспондентского счета], [БИК], [Полное наименование банка], [Наличие семьи], [Состояние здоровья]) VALUES (17, N'Иванов', N'Олег', N'Эдуардовчи', CAST(N'2005-07-25' AS Date), N'МВД ПО РЕСПУБЛИКЕ БАШКОРТОСТАН', CAST(N'2019-06-26' AS Date), N'401-603', N'8019', N'548732', N'50189863100000001919', N'40463230100000005492', 224753262, N'КомСберХолБанк', 1, N'Здоров')
INSERT [dbo].[Сотрудники] ([ИД], [Фамилия], [Имя], [Отчество], [Дата рождения], [Кем выдан], [Дата выдачи], [Код подразделения], [Серия], [Номер], [Номер расчетного счета], [Номер корреспондентского счета], [БИК], [Полное наименование банка], [Наличие семьи], [Состояние здоровья]) VALUES (20, N'Хабирова', N'Рената', N'Рамисовна', CAST(N'2005-07-26' AS Date), N'МВД ПО РЕСПУБЛИКЕ БАШКОРТОСТАН', CAST(N'2019-05-05' AS Date), N'879-522', N'8019', N'329451', N'50282268600000002059', N'40797639100000005951', 289437717, N'ЦентПромКредитБанк', 1, N'Здоров')
SET IDENTITY_INSERT [dbo].[Сотрудники] OFF
GO
SET IDENTITY_INSERT [dbo].[Тип материала] ON 

INSERT [dbo].[Тип материала] ([ИД], [Процент брака материала], [Тип материала]) VALUES (1, 10, N'Ламинат')
INSERT [dbo].[Тип материала] ([ИД], [Процент брака материала], [Тип материала]) VALUES (2, 7, N'Линолиум')
INSERT [dbo].[Тип материала] ([ИД], [Процент брака материала], [Тип материала]) VALUES (3, 20, N'Паркет')
SET IDENTITY_INSERT [dbo].[Тип материала] OFF
GO
INSERT [dbo].[Тип продукции] ([ИД], [Тип продукции], [Коэффициент типа продукции]) VALUES (1, N'Ламинат', 2.35)
INSERT [dbo].[Тип продукции] ([ИД], [Тип продукции], [Коэффициент типа продукции]) VALUES (2, N'Массивная доска', 5.15)
INSERT [dbo].[Тип продукции] ([ИД], [Тип продукции], [Коэффициент типа продукции]) VALUES (3, N'Паркетная доска', 4.34)
INSERT [dbo].[Тип продукции] ([ИД], [Тип продукции], [Коэффициент типа продукции]) VALUES (4, N'Пробковое покрытие', 1.5)
GO
SET IDENTITY_INSERT [dbo].[Форма организации] ON 

INSERT [dbo].[Форма организации] ([ИД], [Тип партнера]) VALUES (1, N'ЗАО')
INSERT [dbo].[Форма организации] ([ИД], [Тип партнера]) VALUES (2, N'ООО')
INSERT [dbo].[Форма организации] ([ИД], [Тип партнера]) VALUES (3, N'ПАО')
INSERT [dbo].[Форма организации] ([ИД], [Тип партнера]) VALUES (4, N'ОАО')
SET IDENTITY_INSERT [dbo].[Форма организации] OFF
GO
ALTER TABLE [dbo].[Заявки]  WITH CHECK ADD  CONSTRAINT [FK_Заявки_Партнеры] FOREIGN KEY([Партнер])
REFERENCES [dbo].[Партнеры] ([ИД])
GO
ALTER TABLE [dbo].[Заявки] CHECK CONSTRAINT [FK_Заявки_Партнеры]
GO
ALTER TABLE [dbo].[Заявки]  WITH CHECK ADD  CONSTRAINT [FK_Заявки_Продукция] FOREIGN KEY([Продукт])
REFERENCES [dbo].[Продукция] ([Артикул])
GO
ALTER TABLE [dbo].[Заявки] CHECK CONSTRAINT [FK_Заявки_Продукция]
GO
ALTER TABLE [dbo].[Заявки]  WITH CHECK ADD  CONSTRAINT [FK_Заявки_Сотрудники] FOREIGN KEY([ИД Сотрудника])
REFERENCES [dbo].[Сотрудники] ([ИД])
GO
ALTER TABLE [dbo].[Заявки] CHECK CONSTRAINT [FK_Заявки_Сотрудники]
GO
ALTER TABLE [dbo].[История изменений количества материала на складе]  WITH CHECK ADD  CONSTRAINT [FK_История изменений количества материала на складе_Материалы] FOREIGN KEY([Артикул])
REFERENCES [dbo].[Материалы] ([Артикул])
GO
ALTER TABLE [dbo].[История изменений количества материала на складе] CHECK CONSTRAINT [FK_История изменений количества материала на складе_Материалы]
GO
ALTER TABLE [dbo].[История изменения минимальной стоимости для партнера]  WITH CHECK ADD  CONSTRAINT [FK_История изменения минимальной стоимости для партнера_Партнеры] FOREIGN KEY([Партнер])
REFERENCES [dbo].[Партнеры] ([ИД])
GO
ALTER TABLE [dbo].[История изменения минимальной стоимости для партнера] CHECK CONSTRAINT [FK_История изменения минимальной стоимости для партнера_Партнеры]
GO
ALTER TABLE [dbo].[История изменения минимальной стоимости для партнера]  WITH CHECK ADD  CONSTRAINT [FK_История изменения минимальной стоимости для партнера_Продукция] FOREIGN KEY([Артикул])
REFERENCES [dbo].[Продукция] ([Артикул])
GO
ALTER TABLE [dbo].[История изменения минимальной стоимости для партнера] CHECK CONSTRAINT [FK_История изменения минимальной стоимости для партнера_Продукция]
GO
ALTER TABLE [dbo].[История поставок материалов]  WITH CHECK ADD  CONSTRAINT [FK_История поставок материалов_Материалы] FOREIGN KEY([Артикул])
REFERENCES [dbo].[Материалы] ([Артикул])
GO
ALTER TABLE [dbo].[История поставок материалов] CHECK CONSTRAINT [FK_История поставок материалов_Материалы]
GO
ALTER TABLE [dbo].[История поставок материалов]  WITH CHECK ADD  CONSTRAINT [FK_История поставок материалов_Поставщики] FOREIGN KEY([Поставщик])
REFERENCES [dbo].[Поставщики] ([ИД])
GO
ALTER TABLE [dbo].[История поставок материалов] CHECK CONSTRAINT [FK_История поставок материалов_Поставщики]
GO
ALTER TABLE [dbo].[История поставок материалов]  WITH CHECK ADD  CONSTRAINT [FK_История поставок материалов_Сотрудники] FOREIGN KEY([ИД Сотрудника])
REFERENCES [dbo].[Сотрудники] ([ИД])
GO
ALTER TABLE [dbo].[История поставок материалов] CHECK CONSTRAINT [FK_История поставок материалов_Сотрудники]
GO
ALTER TABLE [dbo].[Материалы]  WITH CHECK ADD  CONSTRAINT [FK_Материалы_Единицы измерения] FOREIGN KEY([Единица измерения])
REFERENCES [dbo].[Единицы измерения] ([ИД])
GO
ALTER TABLE [dbo].[Материалы] CHECK CONSTRAINT [FK_Материалы_Единицы измерения]
GO
ALTER TABLE [dbo].[Материалы]  WITH CHECK ADD  CONSTRAINT [FK_Материалы_Поставщики] FOREIGN KEY([Поставщик])
REFERENCES [dbo].[Поставщики] ([ИД])
GO
ALTER TABLE [dbo].[Материалы] CHECK CONSTRAINT [FK_Материалы_Поставщики]
GO
ALTER TABLE [dbo].[Материалы]  WITH CHECK ADD  CONSTRAINT [FK_Материалы_Тип материала] FOREIGN KEY([Тип продукции])
REFERENCES [dbo].[Тип материала] ([ИД])
GO
ALTER TABLE [dbo].[Материалы] CHECK CONSTRAINT [FK_Материалы_Тип материала]
GO
ALTER TABLE [dbo].[Материалы для продукции]  WITH CHECK ADD  CONSTRAINT [FK_Материалы для продукции_Материалы] FOREIGN KEY([Материал])
REFERENCES [dbo].[Материалы] ([Артикул])
GO
ALTER TABLE [dbo].[Материалы для продукции] CHECK CONSTRAINT [FK_Материалы для продукции_Материалы]
GO
ALTER TABLE [dbo].[Материалы для продукции]  WITH CHECK ADD  CONSTRAINT [FK_Материалы для продукции_Продукция] FOREIGN KEY([Артикул])
REFERENCES [dbo].[Продукция] ([Артикул])
GO
ALTER TABLE [dbo].[Материалы для продукции] CHECK CONSTRAINT [FK_Материалы для продукции_Продукция]
GO
ALTER TABLE [dbo].[Партнеры]  WITH CHECK ADD  CONSTRAINT [FK_Партнеры_Форма организации] FOREIGN KEY([Форма организации])
REFERENCES [dbo].[Форма организации] ([ИД])
GO
ALTER TABLE [dbo].[Партнеры] CHECK CONSTRAINT [FK_Партнеры_Форма организации]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [FK_Продукция_Тип продукции] FOREIGN KEY([Тип продукции])
REFERENCES [dbo].[Тип продукции] ([ИД])
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [FK_Продукция_Тип продукции]
GO
ALTER TABLE [dbo].[Заявки]  WITH CHECK ADD  CONSTRAINT [Ограничение количество продукции] CHECK  (([Количество продукции]>(0)))
GO
ALTER TABLE [dbo].[Заявки] CHECK CONSTRAINT [Ограничение количество продукции]
GO
ALTER TABLE [dbo].[История изменений количества материала на складе]  WITH CHECK ADD  CONSTRAINT [CK_История изменений количества материала на складе] CHECK  (([Количество]>(0)))
GO
ALTER TABLE [dbo].[История изменений количества материала на складе] CHECK CONSTRAINT [CK_История изменений количества материала на складе]
GO
ALTER TABLE [dbo].[История изменения минимальной стоимости для партнера]  WITH CHECK ADD  CONSTRAINT [Ограничение История изменения минимальной стоимости для партнера] CHECK  (([Минимальная стоимость]>(0)))
GO
ALTER TABLE [dbo].[История изменения минимальной стоимости для партнера] CHECK CONSTRAINT [Ограничение История изменения минимальной стоимости для партнера]
GO
ALTER TABLE [dbo].[История поставок материалов]  WITH CHECK ADD  CONSTRAINT [Ограничение количество] CHECK  (([Количество]>(0)))
GO
ALTER TABLE [dbo].[История поставок материалов] CHECK CONSTRAINT [Ограничение количество]
GO
ALTER TABLE [dbo].[Материалы]  WITH CHECK ADD  CONSTRAINT [Ограничение количество в упаковке] CHECK  (([Количество в упаковке]>(0)))
GO
ALTER TABLE [dbo].[Материалы] CHECK CONSTRAINT [Ограничение количество в упаковке]
GO
ALTER TABLE [dbo].[Материалы]  WITH CHECK ADD  CONSTRAINT [Ограничение минимальное допустимое количество] CHECK  (([Минимальное допустимое количество]>(0)))
GO
ALTER TABLE [dbo].[Материалы] CHECK CONSTRAINT [Ограничение минимальное допустимое количество]
GO
ALTER TABLE [dbo].[Материалы]  WITH CHECK ADD  CONSTRAINT [Ограничение минимальной стоимости для партнера] CHECK  (([Минимальная стоимость для партнера]>(0)))
GO
ALTER TABLE [dbo].[Материалы] CHECK CONSTRAINT [Ограничение минимальной стоимости для партнера]
GO
ALTER TABLE [dbo].[Материалы]  WITH CHECK ADD  CONSTRAINT [Ограничение стоимости материал] CHECK  (([Стоимость]>(0)))
GO
ALTER TABLE [dbo].[Материалы] CHECK CONSTRAINT [Ограничение стоимости материал]
GO
ALTER TABLE [dbo].[Партнеры]  WITH CHECK ADD  CONSTRAINT [Ограничение ИНН] CHECK  (((len([ИНН])=(10) OR len([ИНН])=(12)) AND isnumeric([ИНН])=(1)))
GO
ALTER TABLE [dbo].[Партнеры] CHECK CONSTRAINT [Ограничение ИНН]
GO
ALTER TABLE [dbo].[Партнеры]  WITH CHECK ADD  CONSTRAINT [Ограничение электронная почта] CHECK  (([Электронная почта] like '%@%.%'))
GO
ALTER TABLE [dbo].[Партнеры] CHECK CONSTRAINT [Ограничение электронная почта]
GO
ALTER TABLE [dbo].[Поставщики]  WITH CHECK ADD  CONSTRAINT [Ограничение ИНН2] CHECK  (((len([ИНН])=(10) OR len([ИНН])=(12)) AND isnumeric([ИНН])=(1)))
GO
ALTER TABLE [dbo].[Поставщики] CHECK CONSTRAINT [Ограничение ИНН2]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение веса без упаковки] CHECK  (([Вес без упаковки]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение веса без упаковки]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение веса с упаковкой] CHECK  (([Вес с упаковкой]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение веса с упаковкой]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение высоты] CHECK  (([Высота]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение высоты]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение длинны] CHECK  (([Длинна]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение длинны]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение количество человек на производстве] CHECK  (([Количество человек на производстве]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение количество человек на производстве]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение номер цеха] CHECK  (([Номер цеха]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение номер цеха]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение себестоимости] CHECK  (([Себестоимость]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение себестоимости]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение стоимости] CHECK  (([Минимальная стоимость для партнера]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение стоимости]
GO
ALTER TABLE [dbo].[Продукция]  WITH CHECK ADD  CONSTRAINT [Ограничение ширины] CHECK  (([Ширина]>(0)))
GO
ALTER TABLE [dbo].[Продукция] CHECK CONSTRAINT [Ограничение ширины]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [Ограничение код подразделения] CHECK  (([Код подразделения] like '[0-9][0-9][0-9]-[0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [Ограничение код подразделения]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [Ограничение номер] CHECK  (([Номер] like '[0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [Ограничение номер]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [Ограничение номер корреспондентского счета] CHECK  (([Номер корреспондентского счета] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [Ограничение номер корреспондентского счета]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [Ограничение расчетного счета] CHECK  (([Номер расчетного счета] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [Ограничение расчетного счета]
GO
ALTER TABLE [dbo].[Сотрудники]  WITH CHECK ADD  CONSTRAINT [Ограничение серия] CHECK  (([Серия] like '[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Сотрудники] CHECK CONSTRAINT [Ограничение серия]
GO
ALTER TABLE [dbo].[Тип материала]  WITH CHECK ADD  CONSTRAINT [Ограничение процент брака материала] CHECK  (([Процент брака материала]>(0)))
GO
ALTER TABLE [dbo].[Тип материала] CHECK CONSTRAINT [Ограничение процент брака материала]
GO
USE [master]
GO
ALTER DATABASE [SharipovPolMaster] SET  READ_WRITE 
GO
