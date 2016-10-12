USE [OscarDB]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2016-10-12 14:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Items]    Script Date: 2016-10-12 14:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
	[PurchaseDate] [datetime] NOT NULL,
	[BarCode] [nvarchar](32) NOT NULL,
	[Withdrawn] [bit] NOT NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Members]    Script Date: 2016-10-12 14:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[MemberID] [int] NOT NULL,
	[FirstName] [nvarchar](64) NOT NULL,
	[LastName] [nvarchar](64) NOT NULL,
	[RegistrationDate] [datetime] NOT NULL,
	[Notes] [nvarchar](1024) NOT NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movies]    Script Date: 2016-10-12 14:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] NOT NULL,
	[Title] [nvarchar](64) NOT NULL,
	[ReleaseYear] [smallint] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[RentalModeID] [int] NOT NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RentalModePricing]    Script Date: 2016-10-12 14:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentalModePricing](
	[RentalModeID] [int] NOT NULL,
	[EffectiveDate] [date] NOT NULL,
	[RentalPrice] [decimal](12, 2) NOT NULL,
	[OverduePrice] [decimal](12, 2) NOT NULL,
	[Limit] [int] NOT NULL,
 CONSTRAINT [PK_RentalModePricing] PRIMARY KEY CLUSTERED 
(
	[RentalModeID] ASC,
	[EffectiveDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RentalModes]    Script Date: 2016-10-12 14:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentalModes](
	[RentalModeID] [int] NOT NULL,
	[MaximumDays] [tinyint] NOT NULL,
	[ModeName] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_RentalModes] PRIMARY KEY CLUSTERED 
(
	[RentalModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rentals]    Script Date: 2016-10-12 14:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rentals](
	[RentalID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[MemberID] [int] NOT NULL,
	[RentalDate] [datetime] NOT NULL,
	[ReturnDate] [datetime] NULL,
	[RentalState] [tinyint] NOT NULL,
	[ReturnState] [tinyint] NULL,
	[RentalModeID] [int] NOT NULL,
 CONSTRAINT [PK_Rentals] PRIMARY KEY CLUSTERED 
(
	[RentalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[EffectivePricing]    Script Date: 2016-10-12 14:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[EffectivePricing]
(	
	@date date
)
RETURNS TABLE 
AS
RETURN 
(
	with LastPricing as
	(
		select RentalModeID, max(EffectiveDate) as LastEffectiveDate
		from RentalModePricing
		where EffectiveDate < isnull(@date, convert(date, getdate()))
		group by RentalModeID
	)
	select
		LastPricing.RentalModeID, RentalPrice, OverduePrice, Limit
	from LastPricing
		inner join RentalModePricing
		on LastPricing.RentalModeID = RentalModePricing.RentalModeID
		and LastPricing.LastEffectiveDate = RentalModePricing.EffectiveDate
)

GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Movies]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_Movies_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_Movies_Categories]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_Movies_RentalModes] FOREIGN KEY([RentalModeID])
REFERENCES [dbo].[RentalModes] ([RentalModeID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_Movies_RentalModes]
GO
ALTER TABLE [dbo].[Rentals]  WITH CHECK ADD  CONSTRAINT [FK_Rentals_Items] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Items] ([ItemID])
GO
ALTER TABLE [dbo].[Rentals] CHECK CONSTRAINT [FK_Rentals_Items]
GO
ALTER TABLE [dbo].[Rentals]  WITH CHECK ADD  CONSTRAINT [FK_Rentals_Members] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Members] ([MemberID])
GO
ALTER TABLE [dbo].[Rentals] CHECK CONSTRAINT [FK_Rentals_Members]
GO
ALTER TABLE [dbo].[Rentals]  WITH CHECK ADD  CONSTRAINT [FK_Rentals_RentalModes] FOREIGN KEY([RentalModeID])
REFERENCES [dbo].[RentalModes] ([RentalModeID])
GO
ALTER TABLE [dbo].[Rentals] CHECK CONSTRAINT [FK_Rentals_RentalModes]
GO
ALTER TABLE [dbo].[Rentals]  WITH CHECK ADD  CONSTRAINT [CK_Rentals_Returns] CHECK  (([ReturnDate] IS NULL AND [ReturnState] IS NULL OR [ReturnDate]>[RentalDate] AND ([ReturnState]=(5) OR [ReturnState]=(4) OR [ReturnState]=(3) OR [ReturnState]=(2) OR [ReturnState]=(1))))
GO
ALTER TABLE [dbo].[Rentals] CHECK CONSTRAINT [CK_Rentals_Returns]
GO
ALTER TABLE [dbo].[Rentals]  WITH CHECK ADD  CONSTRAINT [CK_Rentals_States] CHECK  (([RentalState]=(5) OR [RentalState]=(4) OR [RentalState]=(3) OR [RentalState]=(2) OR [RentalState]=(1)))
GO
ALTER TABLE [dbo].[Rentals] CHECK CONSTRAINT [CK_Rentals_States]
GO
