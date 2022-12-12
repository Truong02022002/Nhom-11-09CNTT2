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
-- Câu 11: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT DISTINCT SOHD FROM CTHD
WHERE MASP ='BB01' OR MASP = 'BB02'
-- Câu 12: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT DISTINCT SOHD FROM CTHD
WHERE ( MASP ='BB01' OR MASP = 'BB02' ) AND SL BETWEEN 10 AND 20
-- Câu 13: Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD FROM CTHD 
WHERE MASP = 'BB02' AND CTHD.SL BETWEEN 10 AND 20 AND EXISTS (
SELECT SOHD FROM CTHD
WHERE MASP = 'BB01' AND CTHD.SOHD = CTHD.SOHD AND CTHD.SL BETWEEN 10 AND 20)
--Câu 14: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT SANPHAM.MASP , TENSP FROM SANPHAM 
INNER JOIN (HOADON JOIN CTHD ON HOADON.SOHD = CTHD.SOHD )ON SANPHAM.MASP = CTHD.MASP
WHERE NUOCSX ='Trung Quoc' OR NGAYHD = '1/1/2007'
-- Câu 15: In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT SANPHAM.MASP , TENSP FROM SANPHAM 
WHERE NOT EXISTS (SELECT MASP FROM CTHD 
WHERE SANPHAM.MASP = CTHD.MASP)
--Câu 16: In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT C.MASP , TENSP
FROM SANPHAM C
WHERE NOT EXISTS (
	SELECT MASP
	FROM CTHD JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
	WHERE C.MASP = CTHD.MASP AND YEAR(HOADON.NGHD) = 2006
	) 
--Câu 17: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT C.MASP , TENSP
FROM SANPHAM C
WHERE NUOCSX = 'Trung Quoc' AND NOT EXISTS (
	SELECT MASP
	FROM CTHD JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
	WHERE C.MASP = CTHD.MASP AND YEAR(HOADON.NGHD) = 2006
	) 
--Câu 18: Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
select SOHD
from HOADON 
where not exists ( 
			select MASP
			from SANPHAM
			where nuocsx= 'Singapore' and not exists (
				select SOHD
				from CTHD 
				where HOADON.sohd=CTHD.sohd and CTHD.masp=SANPHAM.masp) )
--Câu 19: Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
SELECT A.SOHD ,SOLAN
FROM HOADON A JOIN (SELECT MIN(SL) SOLAN 
					FROM HOADON HD JOIN (
							SELECT HOADON.SOHD , COUNT(*) SL
							FROM (CTHD JOIN HOADON ON CTHD.SOHD = HOADON.SOHD ) JOIN SANPHAM ON SANPHAM.MASP =CTHD.MASP 
							WHERE NUOCSX = 'Singapore' AND YEAR(NGHD) = 2006 
							GROUP BY HOADON.SOHD) TABLE1 
								ON TABLE1.SOHD = HD.SOHD 
					) TABLE2 
						ON A.SOHD = TABLE2.SOHD
					

SELECT  COUNT (*) AS SOLANMUA 
FROM (CTHD JOIN HOADON ON CTHD.SOHD = HOADON.SOHD ) JOIN SANPHAM ON SANPHAM.MASP = CTHD.MASP
WHERE NUOCSX = 'Singapore'  AND YEAR(NGHD) = 2006
--Câu 20: Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(*) AS SOHOADONKHONGPHAIDOTHANHVIENMUA
FROM HOADON
WHERE MAKH IS NULL
--Câu 21: Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT MASP)
FROM HOADON JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
WHERE YEAR(NGHD) = 2006
--Câu 22: Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MIN(TRIGIA) AS THAPNHAT , MAX (TRIGIA) AS CAONHAT
FROM HOADON
--Câu 23: Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AS TRUNGBINH2006
FROM HOADON
WHERE YEAR(NGHD) ='2006'
--Câu 24: Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(NGHD) = 2006
--Câu 25: Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT SOHD
FROM HOADON
WHERE TRIGIA= (SELECT MAX(TRIGIA) FROM HOADON WHERE YEAR(NGHD) =2006 )
--Câu 26: Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HOTEN
FROM HOADON JOIN KHACHHANG ON HOADON.MAKH = KHACHHANG.MAKH
WHERE TRIGIA = (SELECT MAX(TRIGIA) FROM HOADON WHERE YEAR (NGHD)=2006)

--Câu 27: In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 MAKH , HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
--Câu 28: In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP ,TENSP
FROM SANPHAM
WHERE GIA IN (
	SELECT TOP 3 GIA
	FROM SANPHAM
	ORDER BY GIA DESC)
	 
--Câu 29: In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP , TENSP
FROM SANPHAM
WHERE NUOCSX = 'Thai Lan' AND GIA IN (
						SELECT TOP 3 GIA 
						FROM SANPHAM 
						ORDER BY GIA DESC )
--Câu 30: In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP , TENSP
FROM SANPHAM
WHERE NUOCSX ='Trung Quoc' AND GIA IN (
									SELECT TOP 3 GIA
									FROM SANPHAM
									WHERE NUOCSX ='Trung Quoc'
									ORDER BY GIA DESC )
--31.	* In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
--32.	Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(DISTINCT MASP)
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC'
--33.	Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, COUNT(DISTINCT MASP) AS TONGSOSANPHAM
FROM SANPHAM
GROUP BY NUOCSX
--34.	Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX, MAX(GIA) AS MAX, MIN(GIA) AS MIN, AVG(GIA) AS AVG
FROM SANPHAM
GROUP BY NUOCSX
--35.	Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD, SUM(TRIGIA) AS DOANHTHU
FROM HOADON
GROUP BY NGHD
