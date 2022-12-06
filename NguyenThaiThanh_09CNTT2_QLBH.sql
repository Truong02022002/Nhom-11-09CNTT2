use QLBANHANG
--Một la mã
--Câu 8: Ngôn ngữ định nghĩa dữ liệu --Giá bán của sản phẩm từ 500 đồng trở lên.
alter table SANPHAM add constraint check_gia check (GIA>=500)
--Câu 9: Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
alter table CTHD add constraint check_mua check (SL>0)
--Câu 10: Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
alter table KHACHHANG add constraint check_ngdk check (NGDK>NGSINH)
-------------------------------------
--Ba la mã
--Câu 1: Ngôn ngữ truy vấn có cấu trúc --In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
select MASP, TENSP from SANPHAM 
where NUOCSX = N'Trung Quốc'
----------------------------------
--Câu 2:In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
select MASP, TENSP from SANPHAM 
where DVT = 'cay' or  DVT = 'quyen' 
----------------------------------
--Câu 3: In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
select MASP, TENSP from SANPHAM 
where MASP = 'B_01'
----------------------------------
--Câu 4: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
select MASP, TENSP from SANPHAM 
where NUOCSX = N'Trung Quốc' and GIA >= 30000 and GIA <= 40000
----------------------------------
--Câu 5: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
select MASP, TENSP from SANPHAM 
where NUOCSX = N'Trung Quốc' or NUOCSX =  N'Thái Lan' and 30000 <= GIA and GIA <= 40000
--Câu 6: In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD,TRIGIA
FROM HOADON
WHERE NGAYHD IN ('01/01/2007','02/01/2007')
--Câu 7:In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD,TRIGIA , NGAYHD
FROM HOADON
WHERE YEAR(NGAYHD) = '2007' AND MONTH(NGAYHD) = '01'
ORDER BY NGAYHD ASC , TRIGIA DESC
--Câu 8: In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT KHACHHANG.MAKH , HOTEN 
FROM KHACHHANG , HOADON 
WHERE KHACHHANG.MAKH = HOADON.MAKH AND NGAYHD = '1/1/2007'
--Câu 9:In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT SOHD , TRIGIA 
FROM HOADON , NHANVIEN 
WHERE HOADON.MANV = NHANVIEN.MANV AND HOTEN = 'Nguyen Van B' AND NGAYHD = '10/28/2006'
--Câu 10: In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT SANPHAM.MASP , TENSP
FROM (KHACHHANG INNER JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH)
INNER JOIN ( SANPHAM INNER JOIN CTHD ON SANPHAM.MASP = CTHD.MASP ) ON HOADON.SOHD = CTHD.SOHD
WHERE HOTEN = 'Nguyen Van A' AND MONTH(NGAYHD)= 10 AND YEAR(NGAYHD) = 2006
