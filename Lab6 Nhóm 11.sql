/*Bài 1:*/

/*create trigger addNhanVien on NhanVien
for insert
as
if exists(select * from NHANVIEN where Luong <= 15000)
begin
print 'luong phải >15000'
rollback tran
end*/



/*CREATE TRIGGER insertNhanVien2 on NhanVien
for INSERT 
AS
    DECLARE @age int 
    SET @age = YEAR(GETDATE()) - (select YEAR(NGSINH) from inserted)
    IF (@age <18 or @age >65)
    BEGIN 
        PRINT N'Tuổi không hợp lệ'
        ROLLBACK TRANSACTION
    END */


/*create trigger updateTP on NhanVien
for update
as
if exists(select * from inserted where DCHI like '%tp HCM%')
begin 
print 'no update'
rollback tran
end*/

/*Bài 2:*/
/*create trigger ThongKe1 on NhanVien
after insert
as
begin
declare @Nam int, @nu int;
select @nam = count(*)  from NhanVien where Phai like 'nam'
select @nu = count(*)   from NhanVien where Phai like N'nữ'
print 'tong so nhan vien nam la: ' + cast(@nam as varchar)
print 'tong so nhan vien nu la: ' + cast(@nu as varchar)
end*/

/*create trigger ThongKe2 on NhanVien
after update 
as
begin
declare @Nam int, @nu int;
select @nam = count(*)  from NhanVien where Phai like 'nam'
select @nu = count(*)   from NhanVien where Phai like N'nữ'
print 'tong so nhan vien nam la: ' + cast(@nam as varchar)
print 'tong so nhan vien nu la: ' + cast(@nu as varchar)
end */

/*create trigger thongke3 on DEAN
after delete
as
begin
declare @thongKe table(maNV nvarchar(9), tong int)
insert  @thongKe
select MA_NVIEN, count(MADA) from PHANCONG
group by MA_NVIEN
end*/

/*Bài 3*/

/*create trigger deleteNhanVien on NhanVien
instead of delete 
as
begin
  delete THANNHAN where MA_NVIEN in (select MA_NVIEN from deleted)
  delete NHANVIEN where MANV in(select MANV from deleted);
end*/

/*select * from NHANVIEN
create trigger dean on NhanVien
instead of insert
as
begin
update PHANCONG
set MADA = 1
where MA_NVIEN in(select MANV from inserted)
end*/

/*Bài 4:*/

/*create trigger demSoNhV on NHANVIEN
after delete as
begin

	select count(MANV) as N'Số nhân viên đã xóa' from deleted d
	where Lower(SUBSTRING(d.DCHI,CHARINDEX('%[tT][pP]_[hH][cC][mM]%', d.DCHI),LEN(d.DCHI))) = 'tp hcm' 
	or Lower(SUBSTRING(d.DCHI,CHARINDEX(N'%[hH]ồ%[cC]hí%[mM]inh', d.DCHI),LEN(d.DCHI))) = N'tp hồ chí minh'
	
end*/

/*create trigger xoaNHANTHAN on NHANVIEN
after delete as
begin
	delete from THANNHAN where THANNHAN.MA_NVIEN in (select manv from deleted)
end*/
