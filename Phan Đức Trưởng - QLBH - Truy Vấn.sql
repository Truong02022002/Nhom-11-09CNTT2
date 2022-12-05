
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
