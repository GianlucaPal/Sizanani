
/****** Object:  Table [dbo].[Users]    Script Date: 2023/11/03 00:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[FirstName] [nvarchar](128) NULL,
	[LastName] [nvarchar](128) NULL,
	[Email] [nvarchar](250) NULL,
	[Phone] [nvarchar](10) NULL,
	[UserName] [nvarchar](128) NULL,
	[Password] [nvarchar](250) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicles]    Script Date: 2023/11/03 00:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicles](
	[VehicleID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationNumber] [nvarchar](10) NULL,
	[Model] [nvarchar](50) NULL,
	[Weight] [decimal](8, 2) NULL,
	[TypeID] [int] NULL,
	[UserID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Vehicles] PRIMARY KEY CLUSTERED 
(
	[VehicleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VehicleTypes]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleTypes](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_VehicleTypes] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

GO
SET IDENTITY_INSERT [dbo].[VehicleTypes] ON 
GO
INSERT [dbo].[VehicleTypes] ([TypeID], [Type]) VALUES (1, N'Sedan')
GO
INSERT [dbo].[VehicleTypes] ([TypeID], [Type]) VALUES (2, N'Bakkie')
GO
INSERT [dbo].[VehicleTypes] ([TypeID], [Type]) VALUES (3, N'Truck')
GO
INSERT [dbo].[VehicleTypes] ([TypeID], [Type]) VALUES (4, N'SUV')
GO
INSERT [dbo].[VehicleTypes] ([TypeID], [Type]) VALUES (5, N'Van')
GO
SET IDENTITY_INSERT [dbo].[VehicleTypes] OFF
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_UserID]  DEFAULT (newid()) FOR [UserID]
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Vehicles] CHECK CONSTRAINT [FK_Vehicles_Users]
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_VehicleTypes] FOREIGN KEY([TypeID])
REFERENCES [dbo].[VehicleTypes] ([TypeID])
GO
ALTER TABLE [dbo].[Vehicles] CHECK CONSTRAINT [FK_Vehicles_VehicleTypes]
GO
/****** Object:  StoredProcedure [dbo].[spGetUserLogins]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spGetUserLogins]
(@UserName AS NVARCHAR(128)
,@Password AS NVARCHAR(250))
AS
BEGIN
SELECT U.[UserID]
      ,U.[FirstName]
      ,U.[LastName]
      ,U.[Email]
      ,U.[Phone]
      ,U.[UserName]
      ,U.[Password]
      ,CONCAT(U.[FirstName], ' ', U.[LastName]) AS [FullName]
  FROM [dbo].[Users] AS U 
  WHERE (U.[UserName] LIKE CONCAT('%',@UserName,'%'))
  AND (U.[Password] LIKE CONCAT('%',@Password,'%'))
END

GO
/****** Object:  StoredProcedure [dbo].[spType_List]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spType_List]
AS
BEGIN
SELECT[TypeID]
      ,[Type]
  FROM [dbo].[VehicleTypes]
END 
GO
/****** Object:  StoredProcedure [dbo].[spUser_Insert]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[spUser_Insert]
(@UserID AS UNIQUEIDENTIFIER OUTPUT
,@FirstName AS NVARCHAR(128)
,@LastName AS NVARCHAR(128)
,@Email AS NVARCHAR(250)
,@Phone AS NVARCHAR(10)
,@UserName AS NVARCHAR(128)
,@Password AS NVARCHAR(250))
AS
BEGIN
SET @UserID = NEWID()

INSERT INTO [dbo].[Users]
           ([UserID]
           ,[FirstName]
           ,[LastName]
           ,[Email]
           ,[Phone]
           ,[UserName]
           ,[Password])
     VALUES
           (@UserID
			,@FirstName
			,@LastName
			,@Email
			,@Phone
			,@UserName
			,@Password)
END

GO
/****** Object:  StoredProcedure [dbo].[spUser_List]    Script Date: 2023/11/03 00:47:02 ******/

CREATE   PROCEDURE [dbo].[spUser_List]
(@UserID AS UNIQUEIDENTIFIER)
AS 
BEGIN 
SELECT U.[UserID]
      ,U.[FirstName]
      ,U.[LastName]
      ,U.[Email]
      ,U.[Phone]
      ,U.[UserName]
      ,U.[Password]
      ,CONCAT(U.[FirstName], ' ', U.[LastName]) AS [FullName]
  FROM [dbo].[Users] AS U 
  WHERE (@UserID = U.[UserID])
END

GO
/****** Object:  StoredProcedure [dbo].[spUser_Update]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spUser_Update]
(@UserID AS UNIQUEIDENTIFIER
,@FirstName AS NVARCHAR(128)
,@LastName AS NVARCHAR(128)
,@Email AS NVARCHAR(250)
,@Phone AS NVARCHAR(10)
,@UserName AS NVARCHAR(128)
,@Password AS NVARCHAR(250))
AS
BEGIN
UPDATE [dbo].[Users]
SET [FirstName] = @FirstName
    ,[LastName] = @LastName
    ,[Email] = @Email
    ,[Phone] = @Phone
    ,[UserName] = @UserName
    ,[Password] = @Password
WHERE [UserID] = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[spVehicles_Delete]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spVehicles_Delete]
(@VehicleID AS INT)
AS 
BEGIN
DELETE FROM  [dbo].[Vehicles]
WHERE (@VehicleID = [VehicleID])
END
GO
/****** Object:  StoredProcedure [dbo].[spVehicles_Insert]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spVehicles_Insert]
(@VehicleID AS INT OUTPUT
,@RegistrationNumber AS NVARCHAR(10)
,@Model AS NVARCHAR(50)
,@Weight AS DECIMAL(8,2)
,@TypeID AS INT
,@UserID AS UNIQUEIDENTIFIER)
AS 
BEGIN
INSERT INTO [dbo].[Vehicles]
           ([RegistrationNumber]
           ,[Model]
           ,[Weight]
           ,[TypeID]
           ,[UserID])
     VALUES
           (@RegistrationNumber
			,@Model
			,@Weight
			,@TypeID
			,@UserID)
END
GO
/****** Object:  StoredProcedure [dbo].[spVehicles_ListByUser]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spVehicles_ListByUser]
(@UserID AS UNIQUEIDENTIFIER = null)
AS
BEGIN
SELECT V.[VehicleID]
      ,V.[RegistrationNumber]
      ,V.[Model]
      ,V.[Weight]
      ,V.[TypeID]
      ,V.[UserID]
	  ,VT.[Type]
	  ,CONCAT(U.[FirstName], ' ', U.[LastName]) AS [FullName]
  FROM [dbo].[Vehicles] AS V
LEFT OUTER JOIN [VehicleTypes] AS VT ON VT.[TypeID] = V.[TypeID]
LEFT OUTER JOIN [Users] AS U ON U.[UserID] = V.[UserID]
WHERE(@UserID = V.[UserID])
END

GO
/****** Object:  StoredProcedure [dbo].[spVehicles_Update]    Script Date: 2023/11/03 00:47:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[spVehicles_Update]
(@VehicleID AS INT
,@RegistrationNumber AS NVARCHAR(10)
,@Model AS NVARCHAR(50)
,@Weight AS DECIMAL(8,2)
,@TypeID AS INT
,@UserID AS UNIQUEIDENTIFIER)
AS 
BEGIN
UPDATE [dbo].[Vehicles]
SET [RegistrationNumber] = @RegistrationNumber
,[Model] = @Model
,[Weight] = @Weight
,[TypeID] = @TypeID
,[UserID] = @UserID
WHERE (@VehicleID = [VehicleID])
END
GO
