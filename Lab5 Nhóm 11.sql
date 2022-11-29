/*Bài 1:*/
/*create proc sp_ten
@ten nvarchar(20)
as
begin
print('Xin chào'+ @ten)
end

exec sp_ten N' Nhóm 11'*/
/**********************************************************/
/*create proc sp_tong
@so1 int, @so2 int
as
begin
declare @tg int
set @tg=@so1+@so2
print N'Tổng là: ' + cast(@tg as varchar(4))
end

exec sp_tong 61,39;*/
/************************************************************************/
/*create proc sp_tongchan
	@n int
as
begin
	declare @tong int, @dem int
		set @tong = 0
		set @dem = 1
	while @dem<=@n
	begin 
		if (@dem%2=0)
			begin
				set @tong=@tong+@dem
			end
		set @dem+=1
	end
		print(N'Tổng số chẵn là: '+cast(@tong as varchar))
end
	

exec sp_tongchan 10;*/
/**********************************************************************/
/*create proc sp_ucln
@a int, @b int
as
while (@a!=@b)
if(@a>@b)
set @a=@a-@b
else
set @b=@b-@a
return @a

declare @uc int 
exec @uc = sp_ucln 20,20;
print(N'Ước chung lớn nhất là: ' +cast(@uc as varchar))*/
/************************************************************************/
/*Bài 2:*/
/************************************************************************/
/*Create Proc timNVtheoMaNV @MaNV nvarchar(10)
as
begin
	select * from NHANVIEN where MANV = @MaNV;
end

exec timNVtheoMaNV '004';*/
/***********************************************************************/
/*Create Proc NVthamgiaDA @MaDA int
as
begin
	select COUNT(MA_NVIEN) from PHANCONG where MADA = @MaDA;
end

exec [dbo].[NVthamgiaDA] 10;*/
/**********************************************************************/
/*Create Proc Thongke @MaDA int, @DiaDiemDA nvarchar(30)
as
begin
	select COUNT(b.MA_NVIEN) 
	from DEAN a inner join PHANCONG b on a.MADA = b.MADA
	where a.MADA = @MaDA and a.DDIEM_DA = @DiaDiemDA;
end

exec [dbo].[Thongke] 10, N'Hà Nội';*/
/*******************************************************************/
/*Create Proc TimNV @TrPhg nvarchar(10)
as
begin
	select b.*  
	from PHONGBAN a inner join NHANVIEN b on a.MAPHG = b.PHG
	where a.TRPHG = @TrPhg and not exists(select * From THANNHAN
											Where MANV = b.MANV)
end

exec [dbo].[TimNV] '005';*/

/******************************************************************/
/*create proc kiemTraNhanVien 
	@Manv nvarchar(20), @Mapb nvarchar(20)
as begin
	if (select PHG from NHANVIEN where @Manv = MANV) = @Mapb
		print('Cùng phòng')
	else 
		print('Không cùng phòng')
end

exec kiemTraNhanVien '001', '4';*/
/*************************************************************************/
/*Bài 3:*/
/*create proc ThemPhongBanMoi  
	@TenPhg nvarchar(20), @MaPhg int, @TrPhg nvarchar(10), @Ng_NhanChuc date
as 
begin
	if exists(select * from PHONGBAN where MAPHG = @MaPhg) 
	begin
		print('Mã phòng ban đã tồn tại');
		return;
	end
	
	Insert into [dbo].[PHONGBAN]
		([TENPHG],[MAPHG],[TRPHG],[NG_NHANCHUC])
	Values
		(@TenPhg, @MaPhg, @TrPhg, @Ng_NhanChuc);
end

exec ThemPhongBanMoi 'IT', 11, '005', '2022-11-29';*/
/**************************************************************/
/*create proc sp_CapNhatPhongBan
    @OldTenPHG nvarchar (15),
    @TENPHG nvarchar (15),
    @MaPHG int,
    @TRPHG nvarchar (10) ,
    @NG_NHANCHUC date
 as
begin
    UPDATE [dbo].[PHONGBAN]
        SET
            [TENPHG] = @TENPHG, [MAPHG] = @MAPHG,[TRPHG] = @TRPHG, [NG_NHANCHUC] = @NG_NHANCHUC
        WHERE TENPHG = @OldTenPHG;
 end;
 exec [dbo].[sp_CapNhatPhongBan] 'CNTT', 'IT', 10, '005', '1-1-2020';*/
 /*********************************************************************/
/*create proc sp_insertNV @Ho nvarchar(15), @tenLot nvarchar(15), @tenNV nvarchar(15),@MaNV nvarchar(9), @ngaySinh dateTime, 
@diaChi nvarchar(30), @phai nvarchar(3), @luong float,@Ma_NQL nvarchar(9), @PHG int
as
begin
if not exists(select * from PHONGBAN where TENPHG like 'IT')
begin
print 'nhan vien phai la phong it'
return
end
if @luong <25000 
set @Ma_NQL = '009'
else
begin
set @Ma_NQL= '005'
end
declare @age int = datediff(YEAR,@ngaySinh,getdate())
if(@phai like 'nam' and @age > 65 and @age < 18)
begin
print 'nam phai tu 18 -65'
return
end
else if(@phai like N'nữ' and @age > 60 and @age < 18)
begin
print 'nu phai tu 18-60'
return 
end
insert into NHANVIEN(HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG)
values (@Ho,@tenLot,@tenNV,@MaNV,@ngaySinh,@diaChi,@phai,@luong,@Ma_NQL,@PHG)
end*/
