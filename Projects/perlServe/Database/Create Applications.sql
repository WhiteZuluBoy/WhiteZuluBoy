USE [perl]
GO

/****** Object:  Table [dbo].[ApplicationStates]    Script Date: 2021/07/12 00:43:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER TABLE [dbo].[Functions] DROP CONSTRAINT [FK_Functions_ApplicationStates1]
GO


ALTER TABLE [dbo].[Functions] DROP CONSTRAINT [FK_Functions_ApplicationTasks]
GO

ALTER TABLE [dbo].[ApplicationTasks] DROP CONSTRAINT [FK_ApplicationTasks_Applications]
GO

ALTER TABLE [dbo].[ApplicationTasks] DROP CONSTRAINT [FK_ApplicationTasks_ApplicationStates1]
GO

ALTER TABLE [dbo].[Applications] DROP CONSTRAINT [FK_Applications_ApplicationStates]
GO



/****** Object:  Table [dbo].[ApplicationStates]    Script Date: 2021/07/12 00:45:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ApplicationStates]') AND type in (N'U'))
DROP TABLE [dbo].[ApplicationStates]
GO

/****** Object:  Table [dbo].[Applications]    Script Date: 2021/07/12 00:59:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
DROP TABLE [dbo].[Applications]
GO

/****** Object:  Table [dbo].[Tasks]    Script Date: 2021/07/12 01:01:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tasks]') AND type in (N'U'))
DROP TABLE [dbo].[Tasks]
GO

/****** Object:  Table [dbo].[Functions]    Script Date: 2021/07/12 01:01:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Functions]') AND type in (N'U'))
DROP TABLE [dbo].[Functions]
GO


CREATE TABLE [dbo].[ApplicationStates](
	[ApplicationStateId] [uniqueidentifier] NOT NULL DEFAULT newid(),
	[ApplicationStateName] [nchar](10) NOT NULL,
	[ApplicationStateDescription] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ApplicationStates] PRIMARY KEY CLUSTERED 
(
	[ApplicationStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO





/****** Object:  Table [dbo].[Applications]    Script Date: 2021/07/12 01:03:07 ******/

CREATE TABLE [dbo].[Applications](
	[ApplicationId] [uniqueidentifier] NOT NULL  DEFAULT newid(),
	[ApplicationName] [nvarchar](50) NOT NULL DEFAULT 'new App name',
	[ApplicationDescription] [varchar](200) NOT NULL  DEFAULT 'new App description',
	[pApplicationState] [uniqueidentifier] NOT NULL,
	[Created] [timestamp] NOT NULL,
	[Effective] [datetime] NOT NULL DEFAULT GETDATE(),
	[Deprecated] [datetime] NOT NULL DEFAULT 2050,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [perl]
GO

/****** Object:  Table [dbo].[ApplicationTasks]    Script Date: 2021/07/12 01:16:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tasks](
	[TaskId] [uniqueidentifier] NOT NULL,
	[pApplication] [uniqueidentifier] NOT NULL,
	[pTaskState] [uniqueidentifier] NOT NULL,
	[TaskName] [nchar](10) NOT NULL,
	[TaskDescription] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ApplicationTasks] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO




USE [perl]
GO

/****** Object:  Table [dbo].[Functions]    Script Date: 2021/07/12 01:18:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Functions](
	[FunctionId] [uniqueidentifier] NOT NULL,
	[pTask] [uniqueidentifier] NOT NULL,
	[pFunctionState] [uniqueidentifier] NOT NULL,
	[FunctionName] [nchar](10) NOT NULL,
	[FunctionDescription] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Functions] PRIMARY KEY CLUSTERED 
(
	[FunctionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO





ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_ApplicationStates] FOREIGN KEY([pApplicationState])
REFERENCES [dbo].[ApplicationStates] ([ApplicationStateId])
GO

ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_ApplicationStates]
GO






INSERT INTO [dbo].[ApplicationStates]
           (
           ApplicationStateName,
           ApplicationStateDescription
		   )
     VALUES
           (
		   'Deployed',
           'Indicates that the referenced entity is deployed'
		   )
GO

INSERT INTO [dbo].[ApplicationStates]
           (
           ApplicationStateName,
           ApplicationStateDescription
		   )
     VALUES
           (
		   'Depricated',
           'Indicates that the referenced entity is Depricated'
		   )
GO