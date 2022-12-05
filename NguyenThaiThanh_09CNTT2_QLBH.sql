use QLBANHANG
--Câu 8: Ngôn ngữ định nghĩa dữ liệu
alter table SANPHAM add constraint check_gia check (GIA>=500)
--Câu 9:
alter table KHACHHANG add constraint check_mua check (select MAKH from HOADON)
--Câu 10:
alter table KHACHHANG add constraint check_ngdk check (NGDK>NGSINH)
-------------------------------------
--Câu 1: Ngôn ngữ truy vấn có cấu trúc
select MASP, TENSP from SANPHAM 
where NUOCSX = N'Trung Quốc'
----------------------------------
--Câu 2
select MASP, TENSP from SANPHAM 
where DVT = 'cay' or  DVT = 'quyen' 
----------------------------------
--Câu 3
select MASP, TENSP from SANPHAM 
where MASP = 'B_01'
----------------------------------
--Câu 4
select MASP, TENSP from SANPHAM 
where NUOCSX = N'Trung Quốc' and GIA >= 30000 and GIA <= 40000
----------------------------------
--Câu 5
select MASP, TENSP from SANPHAM 
where NUOCSX = N'Trung Quốc' or NUOCSX =  N'Thái Lan' and 30000 <= GIA and GIA <= 40000