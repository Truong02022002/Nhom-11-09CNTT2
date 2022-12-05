--1.2
alter table SANPHAM add GHICHU varchar(20)
--1.3
alter table KHACHHANG add LOAIKH tinyint
--1.4
alter table SANPHAM alter column GHICHU varchar(100)
--1.5
alter table SANPHAM drop column GHICHU
--1.6
alter table KHACHHANG alter column LOAIKH varchar(20)
--1.7
alter table SANPHAM add constraint DVT check(DVT='cay' OR DVT='hop' OR DVT='cai' OR DVT='quyen' OR DVT='chuc')
--1.8
alter table CTHD alter column SOHD int NOT NULL
alter table CTHD alter column MASP char(4) NOT NULL
alter table CTHD add constraint CTHD primary key (SOHD,MASP)
alter table SANPHAM add constraint C_GIABAN check(GIA>=500)
--1.9 
alter table CTHD add constraint C_SLMUA check (SL>0)
--1.10
alter table KHACHHANG add constraint C_NGDK_NGSINH check(NGDK>NGSINH)
--3.1
SELECT MASP , TENSP
FROM SANPHAM 
WHERE NUOCSX = 'Trung Quoc'
--3.2 
SELECT MASP , TENSP
FROM SANPHAM
WHERE DVT IN ('cay','quyen')
--3.3
select masp,tensp from SANPHAM where masp like 'B%01'
--3.4
SELECT MASP , TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND GIA BETWEEN 30000 AND 40000
--3.5
SELECT MASP,TENSP
FROM SANPHAM
WHERE (NUOCSX ='Trung Quoc' OR NUOCSX = 'Thai Lan') AND GIA BETWEEN 30000 AND 40000