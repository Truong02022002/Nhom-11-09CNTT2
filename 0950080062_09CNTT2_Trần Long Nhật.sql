USE [QLHANG]
GO
/****** Object:  Table [dbo].[HangXuat]    Script Date: 12/13/2022 2:53:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangXuat](
	[MaHD] [nvarchar](10) NOT NULL,
	[MaVT] [nvarchar](10) NOT NULL,
	[DonGia] [int] NULL,
	[SLBan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HDBan]    Script Date: 12/13/2022 2:53:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HDBan](
	[MaHD] [nvarchar](10) NOT NULL,
	[NgayXuat] [smalldatetime] NULL,
	[HoTenKhach] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VatTu]    Script Date: 12/13/2022 2:53:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VatTu](
	[MaVT] [nvarchar](10) NOT NULL,
	[TenVT] [nvarchar](30) NULL,
	[DVTinh] [nvarchar](10) NULL,
	[SLCon] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'HD01', N'XM', 300000, 100)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'HD02', N'CT', 20000, 200)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'HD03', N'T1', 500000, 150)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'HD04', N'T2', 300000, 50)
INSERT [dbo].[HangXuat] ([MaHD], [MaVT], [DonGia], [SLBan]) VALUES (N'HD05', N'ST', 450000, 300)
GO
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'HD01', CAST(N'2022-04-04T00:00:00' AS SmallDateTime), N'Trần A')
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'HD02', CAST(N'2022-04-04T00:00:00' AS SmallDateTime), N'Trần B')
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'HD03', CAST(N'2022-04-05T00:00:00' AS SmallDateTime), N'Nguyễn C')
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'HD04', CAST(N'2022-05-04T00:00:00' AS SmallDateTime), N'Đặng D')
INSERT [dbo].[HDBan] ([MaHD], [NgayXuat], [HoTenKhach]) VALUES (N'HD05', CAST(N'2022-05-05T00:00:00' AS SmallDateTime), N'Trần E')
GO
INSERT [dbo].[VatTu] ([MaVT], [TenVT], [DVTinh], [SLCon]) VALUES (N'CT', N'Cát trắng', N'Kg', 400)
INSERT [dbo].[VatTu] ([MaVT], [TenVT], [DVTinh], [SLCon]) VALUES (N'ST', N'Sơn thùng', N'Lít', 500)
INSERT [dbo].[VatTu] ([MaVT], [TenVT], [DVTinh], [SLCon]) VALUES (N'T1', N'Thép', N'Kg', 200)
INSERT [dbo].[VatTu] ([MaVT], [TenVT], [DVTinh], [SLCon]) VALUES (N'T2', N'Tôn', N'Tấm', 100)
INSERT [dbo].[VatTu] ([MaVT], [TenVT], [DVTinh], [SLCon]) VALUES (N'XM', N'Xi măng', N'Kg', 300)
GO
ALTER TABLE [dbo].[HangXuat]  WITH CHECK ADD  CONSTRAINT [FK_HangXuat_HDBan] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HDBan] ([MaHD])
GO
ALTER TABLE [dbo].[HangXuat] CHECK CONSTRAINT [FK_HangXuat_HDBan]
GO
ALTER TABLE [dbo].[HangXuat]  WITH CHECK ADD  CONSTRAINT [FK_HangXuat_VatTu] FOREIGN KEY([MaVT])
REFERENCES [dbo].[VatTu] ([MaVT])
GO
ALTER TABLE [dbo].[HangXuat] CHECK CONSTRAINT [FK_HangXuat_VatTu]
GO

--Câu 3
CREATE FUNCTION fthongtin (@mahd nvarchar(10))
returns table
as
	return (select a.MaHD, b.NgayXuat, c.MaVT, a.DonGia, a.SLBan, DATENAME(WEEKDAY,b.NgayXuat) as N'Ngày thứ'
			from HangXuat a, HDBan b, VatTu c
			where a.MaHD = b.MaHD and a.MaVT = c.MaVT and b.MaHD = @mahd)

select * from fthongtin('HD01')