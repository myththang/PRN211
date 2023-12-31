USE [master]
GO
/****** Object:  Database [prn_as]    Script Date: 8/8/2023 5:45:51 PM ******/
CREATE DATABASE [prn_as]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'prn_as', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\prn_as.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'prn_as_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\prn_as_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [prn_as] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [prn_as].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [prn_as] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [prn_as] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [prn_as] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [prn_as] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [prn_as] SET ARITHABORT OFF 
GO
ALTER DATABASE [prn_as] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [prn_as] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [prn_as] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [prn_as] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [prn_as] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [prn_as] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [prn_as] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [prn_as] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [prn_as] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [prn_as] SET  ENABLE_BROKER 
GO
ALTER DATABASE [prn_as] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [prn_as] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [prn_as] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [prn_as] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [prn_as] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [prn_as] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [prn_as] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [prn_as] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [prn_as] SET  MULTI_USER 
GO
ALTER DATABASE [prn_as] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [prn_as] SET DB_CHAINING OFF 
GO
ALTER DATABASE [prn_as] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [prn_as] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [prn_as] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [prn_as] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [prn_as] SET QUERY_STORE = ON
GO
ALTER DATABASE [prn_as] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [prn_as]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 8/8/2023 5:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 8/8/2023 5:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassSubjects]    Script Date: 8/8/2023 5:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassSubjects](
	[ClassSubjectID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NULL,
	[SubjectID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassSubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pending]    Script Date: 8/8/2023 5:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pending](
	[MoveID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NULL,
	[ClassSubjectID] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MoveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentEnrollment]    Script Date: 8/8/2023 5:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentEnrollment](
	[EnrollmentID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NULL,
	[ClassSubjectID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 8/8/2023 5:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[StudentName] [nvarchar](50) NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 8/8/2023 5:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subjects](
	[SubjectID] [int] IDENTITY(1,1) NOT NULL,
	[SubjectName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timetable]    Script Date: 8/8/2023 5:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timetable](
	[TimetableID] [int] IDENTITY(1,1) NOT NULL,
	[ClassSubjectID] [int] NULL,
	[DayOfWeek] [int] NULL,
	[TimeSlot] [int] NULL,
	[StartTime] [date] NULL,
	[EndTime] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[TimetableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([AdminID], [Name], [Username], [Password]) VALUES (1, NULL, N'admin', N'123')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 

INSERT [dbo].[Classes] ([ClassID], [ClassName]) VALUES (1, N'SE1701')
INSERT [dbo].[Classes] ([ClassID], [ClassName]) VALUES (2, N'SE1702')
INSERT [dbo].[Classes] ([ClassID], [ClassName]) VALUES (3, N'SE1703')
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[ClassSubjects] ON 

INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (1, 1, 1)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (2, 1, 2)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (3, 1, 3)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (4, 1, 4)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (5, 2, 1)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (6, 2, 2)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (7, 2, 3)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (8, 2, 4)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (10, 3, 1)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (11, 3, 2)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (12, 3, 3)
INSERT [dbo].[ClassSubjects] ([ClassSubjectID], [ClassID], [SubjectID]) VALUES (13, 3, 4)
SET IDENTITY_INSERT [dbo].[ClassSubjects] OFF
GO
SET IDENTITY_INSERT [dbo].[Pending] ON 

INSERT [dbo].[Pending] ([MoveID], [StudentID], [ClassSubjectID], [Status]) VALUES (1, 1, 1, 0)
INSERT [dbo].[Pending] ([MoveID], [StudentID], [ClassSubjectID], [Status]) VALUES (2, 1, 5, 0)
INSERT [dbo].[Pending] ([MoveID], [StudentID], [ClassSubjectID], [Status]) VALUES (3, 1, 6, 0)
INSERT [dbo].[Pending] ([MoveID], [StudentID], [ClassSubjectID], [Status]) VALUES (4, 1, 1, 0)
INSERT [dbo].[Pending] ([MoveID], [StudentID], [ClassSubjectID], [Status]) VALUES (5, 1, 6, 0)
INSERT [dbo].[Pending] ([MoveID], [StudentID], [ClassSubjectID], [Status]) VALUES (6, 1, 1, 0)
INSERT [dbo].[Pending] ([MoveID], [StudentID], [ClassSubjectID], [Status]) VALUES (7, 1, 2, 0)
SET IDENTITY_INSERT [dbo].[Pending] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentEnrollment] ON 

INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (1, 1, 1)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (2, 1, 6)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (3, 1, 3)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (5, 1, 4)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (6, 2, 10)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (7, 2, 6)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (8, 2, 7)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (9, 2, 8)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (10, 3, 10)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (11, 3, 11)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (12, 3, 12)
INSERT [dbo].[StudentEnrollment] ([EnrollmentID], [StudentID], [ClassSubjectID]) VALUES (13, 3, 13)
SET IDENTITY_INSERT [dbo].[StudentEnrollment] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([StudentID], [StudentName], [Username], [Password]) VALUES (1, N'Nguyen Van A', N'a@gmail.com', N'123')
INSERT [dbo].[Students] ([StudentID], [StudentName], [Username], [Password]) VALUES (2, N'Nguyen Van B', N'b@gmail.com', N'123')
INSERT [dbo].[Students] ([StudentID], [StudentName], [Username], [Password]) VALUES (3, N'Nguyen Van C', N'c@gmail.com', N'123')
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET IDENTITY_INSERT [dbo].[Subjects] ON 

INSERT [dbo].[Subjects] ([SubjectID], [SubjectName]) VALUES (1, N'SWP391')
INSERT [dbo].[Subjects] ([SubjectID], [SubjectName]) VALUES (2, N'PRN211')
INSERT [dbo].[Subjects] ([SubjectID], [SubjectName]) VALUES (3, N'SWR302')
INSERT [dbo].[Subjects] ([SubjectID], [SubjectName]) VALUES (4, N'SWT301')
SET IDENTITY_INSERT [dbo].[Subjects] OFF
GO
SET IDENTITY_INSERT [dbo].[Timetable] ON 

INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (1, 1, 1, 1, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (3, 1, 3, 2, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (4, 2, 1, 2, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (5, 2, 3, 1, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (9, 3, 2, 1, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (10, 3, 4, 2, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (11, 4, 2, 2, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (12, 4, 4, 1, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (13, 5, 1, 3, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (15, 5, 3, 4, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (16, 6, 1, 4, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (17, 6, 3, 3, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (18, 7, 2, 3, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (19, 7, 4, 4, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (20, 8, 2, 4, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (23, 8, 4, 3, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (25, 10, 1, 2, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (26, 10, 3, 1, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (29, 11, 1, 1, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (30, 11, 3, 2, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (31, 12, 2, 2, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (32, 12, 4, 1, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (33, 13, 2, 2, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
INSERT [dbo].[Timetable] ([TimetableID], [ClassSubjectID], [DayOfWeek], [TimeSlot], [StartTime], [EndTime]) VALUES (34, 13, 4, 1, CAST(N'2023-05-08' AS Date), CAST(N'2023-07-24' AS Date))
SET IDENTITY_INSERT [dbo].[Timetable] OFF
GO
ALTER TABLE [dbo].[ClassSubjects]  WITH CHECK ADD FOREIGN KEY([ClassID])
REFERENCES [dbo].[Classes] ([ClassID])
GO
ALTER TABLE [dbo].[ClassSubjects]  WITH CHECK ADD FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subjects] ([SubjectID])
GO
ALTER TABLE [dbo].[StudentEnrollment]  WITH CHECK ADD FOREIGN KEY([ClassSubjectID])
REFERENCES [dbo].[ClassSubjects] ([ClassSubjectID])
GO
ALTER TABLE [dbo].[StudentEnrollment]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Students] ([StudentID])
GO
ALTER TABLE [dbo].[Timetable]  WITH CHECK ADD FOREIGN KEY([ClassSubjectID])
REFERENCES [dbo].[ClassSubjects] ([ClassSubjectID])
GO
USE [master]
GO
ALTER DATABASE [prn_as] SET  READ_WRITE 
GO
