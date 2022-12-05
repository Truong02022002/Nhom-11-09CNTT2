--Bai 1:
/*Create function f_tinhtuoi (@MaNV nvarchar(9))
returns int 
as 
BEGIN
	RETURN (SELECT DATEDIFF(YEAR,NGSINH,GETDATE()) FROM NHANVIEN WHERE MANV LIKE @MaNV)
END

PRINT(N'Tuổi: ' + CAST(dbo.f_tinhtuoi('002') AS nvarchar))*/

/*CREATE FUNCTION f_tongdean(@MaNV nvarchar(9))
RETURNS INT
AS
BEGIN
  RETURN (SELECT COUNT(MADA) FROM PHANCONG WHERE MA_NVIEN LIKE @MaNV)
END

PRINT (N'Số đề án: ' + CAST(dbo.f_tongdean('001') AS nvarchar))*/

/*CREATE FUNCTION f_soluongphai (@Phai nvarchar(5))
RETURNS INT
AS
BEGIN
DECLARE @tong int;
SELECT @tong = count(MANV) from NHANVIEN
WHERE PHAI LIKE @Phai
RETURN @tong
END

PRINT (N'Tổng số người cùng phái: ' + CAST(dbo.f_soluongphai('Nam') AS nvarchar))*/

/*CREATE FUNCTION f_luongtb (@Tenphong nvarchar(15))
RETURNS @hovaten table (hoTen nvarchar(50))
AS
BEGIN
DECLARE @MaPhg int;
SELECT @MaPhg = MAPHG from PHONGBAN
WHERE TENPHG LIKE @Tenphong
INSERT INTO @hovaten
SELECT HONV+ ' ' + TENLOT + ' ' + TENNV FROM NHANVIEN
WHERE LUONG > (SELECT AVG(LUONG) FROM PHONGBAN pb
JOIN NHANVIEN nv on nv.PHG = pb.MAPHG
where MAPHG = @maPHG
group by MAPHG)
and PHG = @maPHG
return
end

select * from f_luongtb(N'Nghiên Cứu')*/

/*CREATE FUNCTION [dbo].[fListPhong] (@Phong int)
RETURNS @ProdList table 
(ten nvarchar(15), ma int, trphg nvarchar(9),ngay date)
AS
BEGIN
IF @Phong IS NULL
BEGIN
	INSERT INTO @ProdList(ten, ma, trphg, ngay)
	SELECT TENPHG,MAPHG,TRPHG,NG_NHANCHUC 
	from PHONGBAN
END
ELSE
BEGIN
	INSERT INTO @ProdList(ten, ma, trphg, ngay)
	SELECT TENPHG,MAPHG,TRPHG,NG_NHANCHUC 
	from PHONGBAN
	WHERE MAPHG=@Phong
END
return
end
select * from dbo.fListPhong(NULL)*/

--Bai 2:
/*create view f_PhongBan
as
select HONV, TENNV, TENPHG, DIADIEM from PHONGBAN
inner join DIADIEM_PHG on DIADIEM_PHG. MAPHG = PHONGBAN.MAPHG
inner join NHANVIEN on NHANVIEN. PHG = PHONGBAN. MAPHG
select * from f_PhongBan*/
                               
/*create view f_TuoiNV
as
select TENNV, LUONG, YEAR (GETDATE ())-YEAR (NGSINH) as 'Tuoi' from NHANVIEN
select * from f_TuoiNV*/

/*create view f_TopSoLuongNV_PB
as
select top (1) TENPHG, TRPHG, B.HONV+' '+B.TENLOT+' '+B.TENNV as 'TenTp' ,COUNT (A.MANV) as 'SoLuongNV'
from NHANVIEN A
inner join PHONGBAN on PHONGBAN. MAPHG = A. PHG
inner join NHANVIEN B on B.MANV = PHONGBAN. TRPHG
group by TENPHG, TRPHG, B. TENNV, B. HONV, B.TENLOT
order by SoLuongNV desc
select * from f_TopSoLuongNV_PB*/



