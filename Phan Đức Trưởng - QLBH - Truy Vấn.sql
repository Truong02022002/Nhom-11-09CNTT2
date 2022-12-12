
--Bài 2.2 Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
SELECT * 
INTO SANPHAM1
FROM  SANPHAM

SELECT * 
INTO KHACHHANG1
FROM  KHACHHANG
--Bài 2.3 Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)
update SANPHAM1 
set GIA=GIA*1.05 
where NUOCSX='Thai Lan'
--Bài 2.4  Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).
update SANPHAM1 
set GIA=GIA*0.95 
where NUOCSX='Trung Quoc' AND GIA<=10000
--Bài 2.5 Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số 
--từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).
update KHACHHANG1 
set LOAIKH = 'Vip' 
where ( NGDK < '1/1/2007' AND DOANHSO >=10000000 ) OR ( NGDK >='1/1/2007' AND DOANHSO >= 2000000 )
-- 3 > NGON NGU TRUY VAN DU LIEU CO CAU TRUC

--Bài 3.1 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP , TENSP
FROM SANPHAM 
WHERE NUOCSX = 'Trung Quoc'
--Bài 3.2 In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP , TENSP
FROM SANPHAM
WHERE DVT IN ('cay','quyen')
--Bài 3.3 In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
select masp,tensp from SANPHAM where masp like 'B%01'
--Bài 3.4 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP , TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND GIA BETWEEN 30000 AND 40000
--Bài 3.5 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP,TENSP
FROM SANPHAM
WHERE (NUOCSX ='Trung Quoc' OR NUOCSX = 'Thai Lan') AND GIA BETWEEN 30000 AND 40000
-- 3.6 In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD,TRIGIA
FROM HOADON
WHERE NGHD IN ('01/01/2007','02/01/2007')
-- 3.7 In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD,TRIGIA , NGHD
FROM HOADON
WHERE YEAR(NGHD) = '2007' AND MONTH(NGHD) = '01'
ORDER BY NGHD ASC , TRIGIA DESC
--3.8 In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT A.MAKH , HOTEN 
FROM KHACHHANG A, HOADON B
WHERE A.MAKH = B.MAKH AND NGHD = '1/1/2007'
-- 3.9 In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT SOHD , TRIGIA 
FROM HOADON A , NHANVIEN B
WHERE A.MANV = B.MANV AND HOTEN = 'Nguyen Van B' AND NGHD = '10/28/2006'
-- 3.10 In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT SANPHAM.MASP , TENSP
FROM (KHACHHANG JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH) JOIN ( SANPHAM JOIN CTHD ON SANPHAM.MASP = CTHD.MASP ) ON HOADON.SOHD = CTHD.SOHD
WHERE HOTEN = 'Nguyen Van A' AND MONTH(NGHD)= 10 AND YEAR(NGHD) = 2006
-- 3.11: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT DISTINCT SOHD FROM CTHD
WHERE MASP ='BB01' OR MASP = 'BB02'
-- 3.12: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT DISTINCT SOHD FROM CTHD
WHERE ( MASP ='BB01' OR MASP = 'BB02' ) AND SL BETWEEN 10 AND 20
-- 3.13: Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD FROM CTHD 
WHERE MASP = 'BB02' AND CTHD.SL BETWEEN 10 AND 20 AND EXISTS (
SELECT SOHD FROM CTHD
WHERE MASP = 'BB01' AND CTHD.SOHD = CTHD.SOHD AND CTHD.SL BETWEEN 10 AND 20)
--3.14: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT SANPHAM.MASP , TENSP FROM SANPHAM 
INNER JOIN (HOADON JOIN CTHD ON HOADON.SOHD = CTHD.SOHD )ON SANPHAM.MASP = CTHD.MASP
WHERE NUOCSX ='Trung Quoc' OR NGAYHD = '1/1/2007'
-- 3.15: In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT SANPHAM.MASP , TENSP FROM SANPHAM 
WHERE NOT EXISTS (SELECT MASP FROM CTHD 
WHERE SANPHAM.MASP = CTHD.MASP)
-- 3.16: In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT C.MASP , TENSP
FROM SANPHAM C
WHERE NOT EXISTS (
	SELECT MASP
	FROM CTHD JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
	WHERE C.MASP = CTHD.MASP AND YEAR(HOADON.NGHD) = 2006
	) 
-- 3.17: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT C.MASP , TENSP
FROM SANPHAM C
WHERE NUOCSX = 'Trung Quoc' AND NOT EXISTS (
	SELECT MASP
	FROM CTHD JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
	WHERE C.MASP = CTHD.MASP AND YEAR(HOADON.NGHD) = 2006
	) 
-- 3.18: Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
select SOHD
from HOADON 
where not exists ( 
			select MASP
			from SANPHAM
			where nuocsx= 'Singapore' and not exists (
				select SOHD
				from CTHD 
				where HOADON.sohd=CTHD.sohd and CTHD.masp=SANPHAM.masp) )
-- 3.19: Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
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
-- 3.20: Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(*) AS SOHOADONKHONGPHAIDOTHANHVIENMUA
FROM HOADON
WHERE MAKH IS NULL
-- 3.21: Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT MASP)
FROM HOADON JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
WHERE YEAR(NGHD) = 2006
-- 3.22: Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MIN(TRIGIA) AS THAPNHAT , MAX (TRIGIA) AS CAONHAT
FROM HOADON
-- 3.23: Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AS TRUNGBINH2006
FROM HOADON
WHERE YEAR(NGHD) ='2006'
-- 3.24: Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(NGHD) = 2006
-- 3.25: Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT SOHD
FROM HOADON
WHERE TRIGIA= (SELECT MAX(TRIGIA) FROM HOADON WHERE YEAR(NGHD) =2006 )
-- 3.26: Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HOTEN
FROM HOADON JOIN KHACHHANG ON HOADON.MAKH = KHACHHANG.MAKH
WHERE TRIGIA = (SELECT MAX(TRIGIA) FROM HOADON WHERE YEAR (NGHD)=2006)
-- 3.27: In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 MAKH , HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC
-- 3.28: In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP ,TENSP
FROM SANPHAM
WHERE GIA IN (
	SELECT TOP 3 GIA
	FROM SANPHAM
	ORDER BY GIA DESC)
-- 3.29: In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP , TENSP
FROM SANPHAM
WHERE NUOCSX = 'Thai Lan' AND GIA IN (
						SELECT TOP 3 GIA 
						FROM SANPHAM 
						ORDER BY GIA DESC )
-- 3.30: In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP , TENSP
FROM SANPHAM
WHERE NUOCSX ='Trung Quoc' AND GIA IN (
									SELECT TOP 3 GIA
									FROM SANPHAM
									WHERE NUOCSX ='Trung Quoc'
									ORDER BY GIA DESC )
