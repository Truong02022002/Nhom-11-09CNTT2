use master
go
if(exists(select * from sysdatabases where name='QLHANG'))
	drop database QLHANG
go

/* Cau 1 */
-- create database
use master
go
create database QLHANG
go
use QLHANG
go

-- create table
create table VatTu(
	MaVT nvarchar(10) not null primary key,
	TenVT nvarchar(50),
	DVTinh nvarchar(20),
	SLcon int default 0
)
create table HDBan(
	MaHD nvarchar(10) not null primary key,
	NgayXuat date,
	HoTenKhach nvarchar(50),
)
create table HangXuat(
	MaHD nvarchar(10) not null,
	MaVT nvarchar(10) not null,
	DonGia int default 0,
	SLBan int default 0,
	primary key (MaHD, MaVT),
	foreign key (MaHD) references HDBan(MaHD),
	foreign key (MaVT) references VatTu(MaVT)
)

go
insert into VatTu values('VT1',N'Sắt',N'Cây',20),
						('VT2',N'Nhôm',N'Kg',25),
						('VT3',N'Kẽm',N'Cái',24)
insert into HDBan values('HD1','12/12/2022',N'Nguyễn Bá Quyền'),
						('HD2','12/12/2022',N'Hồ Trọng Thủy'),
						('HD3','12/12/2022',N'Cù Trọng Xoay')
insert into HangXuat values('HD1','VT1',30000,5),
						('HD2','VT2',50000,6),
						('HD2','VT3',40000,8),
						('HD3','VT1',30000,4),
						('HD3','VT3',50000,2)
go
/*Câu 2:*/
declare @TongMax as table(
	MaHD char(9),
	TongTien int	
)
declare @TinhTong float;
select @TinhTong = (select SLBan from HangXuat)
insert into @TongMax 
	select MaHD, MAX(DonGia*@TinhTong) from HangXuat
/*Câu 3:*/
create function findbyMaHD(@MaHD nvarchar(10))
returns table
as
	return (SELECT z.MaHD, z.MaVT, y.NgayXuat, z.DonGia, z.SLBan, DATEPART(WEEKDAY, y.NgayXuat) as 'Ngay Thu'
			FROM VatTu x, HDBan y, HangXuat z
			WHERE x.MaVT=z.MaVT and y.MaHD = z.MaHD and y.MaHD = @MaHD)

SELECT * FROM findbyMaHD('HD1')

go

/*Câu 4:*/
create proc proc_tongtienvattu(@mahd nvarchar(10)) as
begin
	return (select sum(DonGia*SLBan) from HangXuat where MaVT=@mahd)
end

go

--test
declare @tongtien money
declare @hd nvarchar(10)
set @hd = 'HD1'
exec @tongtien = proc_tongtienvattu @mahd=@hd
print N'Tổng tiền vat tu theo thang va nam '+@hd+' là: '+convert(nvarchar(20), @tongtien)

go