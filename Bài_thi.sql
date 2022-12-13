create database QLHANG
go

--Câu 1:
create table VatTu(
	MaVT nvarchar(10) not null primary key,
	TenVT nvarchar(20),
	DVTinh nvarchar(10),
	SLCon int default 0 
)

create table HDBan(
	MaHD nvarchar(10) not null primary key,
	NgayXuat datetime,
	HoTenKhach nvarchar(30)
)

create table HangXuat(
	MaHD nvarchar(10) not null ,
	MaVT nvarchar(10) not null,
	DonGia decimal(10,2) default 0,
	SLBan int default 0,
	primary key(MaHD, MaVT),
	foreign key (MaVT) references VatTu(MaVT),
	foreign key (MaHD) references HDBan(MaHD)
)


insert into VatTu values ('VT01',N'Bánh quy',N'Cái', 45),
						 ('VT02', N'Nước ngọt',N'Chai', 40),
						 ('VT03', N'Nước ép',N'Chai', 55)
insert into HDBan values('HD01', '2022-5-15', 'Trần Khiêm Tốn'),
						('HD02', '2022-7-12', 'Trần Ngọc Minh'),
						('HD03', '2022-1-16', 'Huyền Thanh Loan')
insert into HangXuat values('HD01', 'VT01', 100000, 3),
						   ('HD01', 'VT02', 150000, 10),
						   ('HD02', 'VT02', 60000, 20),
						   ('HD02', 'VT03', 210000, 21),
						   ('HD03', 'VT02', 80000, 7)

--Câu 2:
select top 1 MaHD, (DonGia*SLBan) as Tongtien from HangXuat
order by Tongtien

--Câu 3:
create function bai3 (@mahd nvarchar(10))
returns table
as
	return (select a.MaHD, b.NgayXuat, c.MaVT, a.DonGia, a.SLBan, DATENAME(WEEKDAY,b.NgayXuat) as 'NgayThu'
			from HangXuat a, HDBan b, VatTu c
			where a.MaHD = b.MaHD and a.MaVT = c.MaVT and b.MaHD = @mahd)

select * from bai3('HD01')

--Câu 4: 
create proc TT_VT(@thang nvarchar(6), @nam nvarchar(6))
as
begin
	return (select SUM(a.DonGia) from HangXuat a, HDBan b, VatTu c
			where a.MaHD = b.MaHD and a.MaVT = c.MaVT and DATENAME(MONTH,b.NgayXuat)) = @thang 
			and DATENAME(YEAR,b.NgayXuat)) = @nam)
end

exec TT_VT('3','2022')

