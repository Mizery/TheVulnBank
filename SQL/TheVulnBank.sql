USE [TheVulnBank]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Amount] [float] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Text] [text] NOT NULL,
	[Internal] [bit] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[AgentId] [int] NULL,
	[Question] [nvarchar](1024) NULL,
	[Answer] [nvarchar](1024) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transfers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromAccountId] [int] NOT NULL,
	[ToAccountId] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[Message] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Username] [nvarchar](25) NOT NULL,
	[Password] [nvarchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([Id], [UserId], [Name], [Amount]) VALUES (1, 1, N'Private', 10000)
INSERT [dbo].[Accounts] ([Id], [UserId], [Name], [Amount]) VALUES (2, 1, N'Savings', 300000)
INSERT [dbo].[Accounts] ([Id], [UserId], [Name], [Amount]) VALUES (3, 2, N'Private', 250)
INSERT [dbo].[Accounts] ([Id], [UserId], [Name], [Amount]) VALUES (5, 2, N'Savings', 13373)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
SET IDENTITY_INSERT [dbo].[Articles] ON 

INSERT [dbo].[Articles] ([Id], [Title], [Text], [Internal]) VALUES (1, N'Start', N'Welcome to your totally trustworthy bank site!', 0)
INSERT [dbo].[Articles] ([Id], [Title], [Text], [Internal]) VALUES (2, N'Loans', N'Oh, your looking for money don''t you?!<br /><br />Ha ha ha', 0)
INSERT [dbo].[Articles] ([Id], [Title], [Text], [Internal]) VALUES (3, N'Savings', N'Yes yes, give me your money <img src="/Show/Img/?file=206578_5479.jpg" style="float: right;" />
<div style="clear: both;"></div>', 0)
INSERT [dbo].[Articles] ([Id], [Title], [Text], [Internal]) VALUES (4, N'Report', N'The year 2015 was a wonderful year', 1)
INSERT [dbo].[Articles] ([Id], [Title], [Text], [Internal]) VALUES (5, N'Pension', N'Hah, so you think you can mooch on the working force??', 0)
INSERT [dbo].[Articles] ([Id], [Title], [Text], [Internal]) VALUES (6, N'Forecast', N'We think that 2016 will be an even better year than 2015.', 1)
INSERT [dbo].[Articles] ([Id], [Title], [Text], [Internal]) VALUES (7, N'Insurance', N'Hah! You screwed up didn''t ya?', 0)
INSERT [dbo].[Articles] ([Id], [Title], [Text], [Internal]) VALUES (8, N'Customer service', N'lol u funny', 0)
SET IDENTITY_INSERT [dbo].[Articles] OFF
SET IDENTITY_INSERT [dbo].[Transfers] ON 

INSERT [dbo].[Transfers] ([Id], [FromAccountId], [ToAccountId], [Amount], [Message]) VALUES (1, 5, 3, 123, N'Test')
SET IDENTITY_INSERT [dbo].[Transfers] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Username], [Password]) VALUES (1, N'Admin', N'Adminson', N'admin', N'21232f297a57a5a743894a0e4a801fc3')
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Username], [Password]) VALUES (2, N'User', N'Userson', N'user', N'482C811DA5D5B4BC6D497FFA98491E38')
SET IDENTITY_INSERT [dbo].[Users] OFF
