USE [OscarDB]
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (1, N'Action')
GO
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (2, N'Drama')
GO
INSERT [dbo].[RentalModes] ([RentalModeID], [MaximumDays], [ModeName]) VALUES (1, 3, N'Normal')
GO
INSERT [dbo].[RentalModes] ([RentalModeID], [MaximumDays], [ModeName]) VALUES (2, 1, N'Novelty')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (1, N'The Dark Knight', 2008, 1, 1)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (2, N'Iron Man', 2008, 1, 1)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (3, N'The Dark Knight Rises', 2012, 1, 1)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (4, N'The Avengers', 2012, 1, 1)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (5, N'Spider-Man 2', 2004, 1, 1)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (6, N'X-Men 2', 2003, 1, 1)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (7, N'Batman Begins', 2005, 1, 1)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (8, N'Deadpool', 2016, 1, 2)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [ReleaseYear], [CategoryID], [RentalModeID]) VALUES (9, N'Avengers: Age of Ultron', 2015, 1, 2)
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (1, N'Sara', N'Morgan', CAST(N'1985-06-18 16:25:13.000' AS DateTime), N'Let me in!')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (2, N'Debra', N'Long', CAST(N'1983-02-19 15:33:09.000' AS DateTime), N'-')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (3, N'Catherine', N'Ellis', CAST(N'1989-06-07 09:18:13.000' AS DateTime), N'-')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (4, N'Brenda', N'Ramirez', CAST(N'1986-11-13 19:36:54.000' AS DateTime), N'-')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (5, N'Rachel', N'Williams', CAST(N'1989-10-01 16:32:39.000' AS DateTime), N'-')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (6, N'Michelle', N'Hunter', CAST(N'1981-04-08 20:49:02.000' AS DateTime), N'-')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (7, N'Christopher', N'Elliott', CAST(N'1985-08-06 19:39:09.000' AS DateTime), N'Always leaves mess.')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (8, N'Sara', N'Morgan', CAST(N'1985-06-18 16:25:13.000' AS DateTime), N'Never returns clean!')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (9, N'Andrew', N'Marshall', CAST(N'1988-12-01 23:14:00.000' AS DateTime), N'-')
GO
INSERT [dbo].[Members] ([MemberID], [FirstName], [LastName], [RegistrationDate], [Notes]) VALUES (10, N'Walter', N'Rice', CAST(N'1981-10-17 08:06:32.000' AS DateTime), N'-')
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (2, 1, CAST(N'2016-01-14 00:00:00.000' AS DateTime), N'102853553', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (3, 1, CAST(N'2016-01-20 00:00:00.000' AS DateTime), N'752336274', 1)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (5, 2, CAST(N'2016-01-17 00:00:00.000' AS DateTime), N'198646008', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (7, 2, CAST(N'2016-01-10 00:00:00.000' AS DateTime), N'996766363', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (8, 2, CAST(N'2016-01-14 00:00:00.000' AS DateTime), N'977408278', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (9, 3, CAST(N'2016-01-15 00:00:00.000' AS DateTime), N'547789190', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (11, 3, CAST(N'2016-01-10 00:00:00.000' AS DateTime), N'296250744', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (13, 4, CAST(N'2016-01-16 00:00:00.000' AS DateTime), N'800114419', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (15, 4, CAST(N'2016-01-19 00:00:00.000' AS DateTime), N'839184599', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (17, 5, CAST(N'2016-01-19 00:00:00.000' AS DateTime), N'601692825', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (18, 5, CAST(N'2016-01-19 00:00:00.000' AS DateTime), N'735959715', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (19, 5, CAST(N'2016-01-13 00:00:00.000' AS DateTime), N'822253912', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (20, 5, CAST(N'2016-01-12 00:00:00.000' AS DateTime), N'157372284', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (21, 6, CAST(N'2016-01-20 00:00:00.000' AS DateTime), N'711999888', 1)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (22, 6, CAST(N'2016-01-11 00:00:00.000' AS DateTime), N'621502332', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (23, 6, CAST(N'2016-01-15 00:00:00.000' AS DateTime), N'939875661', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (24, 6, CAST(N'2016-01-14 00:00:00.000' AS DateTime), N'313763534', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (27, 7, CAST(N'2016-01-13 00:00:00.000' AS DateTime), N'109421137', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (28, 7, CAST(N'2016-01-19 00:00:00.000' AS DateTime), N'534427782', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (29, 8, CAST(N'2016-01-16 00:00:00.000' AS DateTime), N'995535516', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (30, 8, CAST(N'2016-01-20 00:00:00.000' AS DateTime), N'567134987', 1)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (32, 8, CAST(N'2016-01-17 00:00:00.000' AS DateTime), N'552563721', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (33, 9, CAST(N'2016-01-11 00:00:00.000' AS DateTime), N'959215268', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (34, 9, CAST(N'2016-01-18 00:00:00.000' AS DateTime), N'711967693', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (35, 9, CAST(N'2016-01-13 00:00:00.000' AS DateTime), N'256343717', 0)
GO
INSERT [dbo].[Items] ([ItemID], [MovieID], [PurchaseDate], [BarCode], [Withdrawn]) VALUES (36, 9, CAST(N'2016-01-16 00:00:00.000' AS DateTime), N'548998739', 0)
GO
INSERT [dbo].[RentalModePricing] ([RentalModeID], [EffectiveDate], [RentalPrice], [OverduePrice], [Limit]) VALUES (1, CAST(N'2016-01-01' AS Date), CAST(5.00 AS Decimal(12, 2)), CAST(5.00 AS Decimal(12, 2)), 10)
GO
INSERT [dbo].[RentalModePricing] ([RentalModeID], [EffectiveDate], [RentalPrice], [OverduePrice], [Limit]) VALUES (1, CAST(N'2016-06-01' AS Date), CAST(4.50 AS Decimal(12, 2)), CAST(5.00 AS Decimal(12, 2)), 10)
GO
INSERT [dbo].[RentalModePricing] ([RentalModeID], [EffectiveDate], [RentalPrice], [OverduePrice], [Limit]) VALUES (1, CAST(N'2016-11-01' AS Date), CAST(5.50 AS Decimal(12, 2)), CAST(6.00 AS Decimal(12, 2)), 10)
GO
INSERT [dbo].[RentalModePricing] ([RentalModeID], [EffectiveDate], [RentalPrice], [OverduePrice], [Limit]) VALUES (2, CAST(N'2016-01-01' AS Date), CAST(15.00 AS Decimal(12, 2)), CAST(15.00 AS Decimal(12, 2)), 2)
GO
INSERT [dbo].[RentalModePricing] ([RentalModeID], [EffectiveDate], [RentalPrice], [OverduePrice], [Limit]) VALUES (2, CAST(N'2016-10-01' AS Date), CAST(14.00 AS Decimal(12, 2)), CAST(20.00 AS Decimal(12, 2)), 2)
GO
INSERT [dbo].[RentalModePricing] ([RentalModeID], [EffectiveDate], [RentalPrice], [OverduePrice], [Limit]) VALUES (2, CAST(N'2016-12-01' AS Date), CAST(15.00 AS Decimal(12, 2)), CAST(20.00 AS Decimal(12, 2)), 2)
GO
