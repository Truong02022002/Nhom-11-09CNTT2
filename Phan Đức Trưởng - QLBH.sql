CREATE TABLE KHACHHANG
(
 MAKH  char(4) PRIMARY KEY,
 HOTEN varchar(40),
 DCHI  varchar(50),
 SODT  varchar(20),
 NGSINH smalldatetime,
 NGDK  smalldatetime,
 DOANHSO money
)
GO
CREATE TABLE NHANVIEN
(
 MANV  char(4)PRIMARY KEY,
 HOTEN varchar(40),
 SODT  varchar(20),
 NGVL  smalldatetime
)
GO
CREATE TABLE SANPHAM
(
 MASP  char(4)PRIMARY KEY,
 TENSP varchar(40),
 DVT  varchar(20),
 NUOCSX varchar(40),
 GIA  money
)
GO
CREATE TABLE HOADON
(
 SOHD  int PRIMARY KEY,
 NGHD  smalldatetime,
 MAKH  char(4) FOREIGN KEY REFERENCES KHACHHANG(MAKH),
 MANV  char(4) FOREIGN KEY REFERENCES NHANVIEN(MANV),
 TRIGIA money
)
GO
CREATE TABLE CTHD
(
 SOHD  int FOREIGN KEY REFERENCES HOADON(SOHD),
 MASP  char(4) FOREIGN KEY REFERENCES SANPHAM(MASP),
 SL  int,
 CONSTRAINT PK_CTHD PRIMARY KEY (SOHD,MASP)
)
GO
--I:DINH NGHIA DU LIEU
ALTER TABLE SANPHAM ADD GHICHU VARCHAR(20)
GO
ALTER TABLE KHACHHANG ADD LOAIKH TINYINT 
GO
ALTER TABLE SANPHAM ALTER COLUMN GHICHU VARCHAR(100)
GO
ALTER TABLE SANPHAM DROP COLUMN GHICHU
GO
ALTER TABLE KHACHHANG ALTER COLUMN LOAIKH VARCHAR(50)
GO
ALTER TABLE SANPHAM ADD CONSTRAINT CHECK_DVT CHECK(DVT='cay'OR DVT='cai'OR DVT='hop'OR DVT='quyen'OR DVT='chuc')
GO
ALTER TABLE SANPHAM ADD CONSTRAINT CHECK_GIA CHECK(GIA>=500)
GO
ALTER TABLE KHACHHANG ADD CONSTRAINT CHECK_NGDK CHECK (NGDK>NGSINH)
GO
insert into KHACHHANG values ('KH01','Nguyen Van A','731,Tran Hung Dao, Q 5 ,Tp HCM','08823451','22/10/1960','22/10/2006',13000000)
GO
insert into KHACHHANG values ('KH02','Tran Ngoc Han','23/5, Nguyen Trai, Q 5, Tp HCM','0908256478','03/04/1974','30/07/2006',280000)
GO
insert into KHACHHANG values ('KH03','Tran Ngoc Linh','45, Nguyen Canh Chan, Q 1, Tp HCM','0938776266','12/06/1980','05/08/2006',3860000)
GO
insert into KHACHHANG values ('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q 10, Tp HCM','0917325476','09/03/1965','02/10/2006',250000)
GO
insert into KHACHHANG values ('KH05','Le Nhat Minh','34, Truong Dinh, Q 3, Tp HCM','08246108','10/03/1950','28/10/2006',21000)
GO
insert into KHACHHANG values ('KH06','Le Hoai Thuong','227, Nguyen Van Cu, Q 5, Tp HCM','08631738','31/12/1981','24/11/2006',915000)
GO
insert into KHACHHANG values ('KH07','Nguyen Van Tam','32/3, Tran Binh Trong, Q 5, Tp HCM','0916783565','06/04/1971','01/12/2006',12500)
GO
insert into KHACHHANG values ('KH08','Phan Thi Thanh','45/2, An Duong Vuong, Q 5, Tp HCM','0938435756','10/01/1971','13/12/2006',365000)
GO
insert into KHACHHANG values ('KH09','Le Ha Vinh','873, Le Hong Phong, Q 5, Tp HCM','08654763','03/09/1979','14/01/2007',70000)
GO
insert into KHACHHANG values ('KH10','Ha Duy Lap','34/34B, Nguyen Trai, Q 1, Tp HCM','08768904','02/05/1983','16/01/2007',67500)
GO
insert into NHANVIEN values ('NV01','Nguyen Nhu Nhut','0927345678','13/04/2006')
GO
insert into NHANVIEN values ('NV02','Le Thi Phi Yen','0987567390','21/04/2006')
GO
insert into NHANVIEN values ('NV03','Nguyen Van B','0997047382','27/04/2006')
GO
insert into NHANVIEN values ('NV04','Ngo Thanh Tuan','0913758498','24/06/2006')
GO
insert into NHANVIEN values ('NV05','Nguyen Thi Truc Thanh','0918590387','20/07/2006')
GO
insert into SANPHAM values ('BC01','But chi','cay','Singapore',3000)
GO
insert into SANPHAM values ('BC02','But chi','cay','Singapore',5000)
GO
insert into SANPHAM values ('BC03','But chi','cay','Viet Nam',3500)
GO
insert into SANPHAM values ('BC04','But chi','hop','Viet Nam',30000)
GO
insert into SANPHAM values ('BB01','But bi','cay','Viet Nam',5000)
GO
insert into SANPHAM values ('BB02','But bi','cay','Trung Quoc',7000)
GO
insert into SANPHAM values ('BB03','But bi','hop','Thai Lan',100000)
GO
insert into SANPHAM values ('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
GO
insert into SANPHAM values ('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
GO
insert into SANPHAM values ('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
GO
insert into SANPHAM values ('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
GO
insert into SANPHAM values ('TV05','Tap 100 trang','chuc','Viet Nam',23000)
GO
insert into SANPHAM values ('TV06','Tap 200 trang','chuc','Viet Nam',53000)
GO
insert into SANPHAM values ('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
GO
insert into SANPHAM values ('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
GO
insert into SANPHAM values ('ST02','So tay loai 1','quyen','Viet Nam',55000)
GO
insert into SANPHAM values ('ST03','So tay loai 2','quyen','Viet Nam',51000)
GO
insert into SANPHAM values ('ST04','So tay ','quyen','Thai Lan',55000)
GO
insert into SANPHAM values ('ST05','So tay mong','quyen','Thai Lan',20000)
GO
insert into SANPHAM values ('ST06','Phan viet bang','hop','Viet Nam',5000)
GO
insert into SANPHAM values ('ST07','Phan khong bui','hop','Viet Nam',7000)
GO
insert into SANPHAM values ('ST08','Bong bang','cai','Viet Nam',1000)
GO
insert into SANPHAM values ('ST09','But long','cay','Viet Nam',5000)
GO
insert into SANPHAM values ('ST10','But long','cay','Trung Quoc',7000)
GO
insert into HOADON values (1001,'23/07/2006','KH01','NV01',320000)
GO
insert into HOADON values (1002,'12/08/2006','KH01','NV02',840000)
GO
insert into HOADON values (1003,'23/08/2006','KH02','NV01',100000)
GO
insert into HOADON values (1004,'01/09/2006','KH02','NV01',180000)
GO
insert into HOADON values (1005,'20/10/2006','KH01','NV02',3800000)
GO
insert into HOADON values (1006,'16/10/2006','KH01','NV03',2430000)
GO
insert into HOADON values (1007,'28/10/2006','KH03','NV03',510000)
GO
insert into HOADON values (1008,'28/10/2006','KH01','NV03',440000)
GO
insert into HOADON values (1009,'28/10/2006','KH03','NV04',200000)
GO
insert into HOADON values (1010,'01/11/2006','KH01','NV01',5200000)
GO
insert into HOADON values (1011,'04/11/2006','KH04','NV03',250000)
GO
insert into HOADON values (1012,'30/11/2006','KH05','NV03',21000)
GO
insert into HOADON values (1013,'12/12/2006','KH06','NV01',5000)
GO
insert into HOADON values (1014,'31/12/2006','KH03','NV02',3150000)
GO
insert into HOADON values (1015,'01/01/2007','KH06','NV01',910000)
GO
insert into HOADON values (1016,'01/01/2007','KH07','NV02',12500)
GO
insert into HOADON values (1017,'02/01/2007','KH08','NV03',35000)
GO
insert into HOADON values (1018,'13/01/2007','KH08','NV03',330000)
GO
insert into HOADON values (1019,'13/01/2007','KH01','NV03',30000)
GO
insert into HOADON values (1020,'14/01/2007','KH09','NV04',70000)
GO
insert into HOADON values (1021,'16/01/2007','KH10','NV03',67500)
GO
insert into HOADON values (1022,'16/01/2007',null,'NV03',7000)
GO
insert into HOADON values (1023,'17/01/2007',null,'NV01',330000)
GO
insert into CTHD values (1001,'TV02',10)
GO
insert into CTHD values (1001,'ST01',5)
GO
insert into CTHD values (1001,'BC01',5)
GO
insert into CTHD values (1001,'BC02',10)
GO
insert into CTHD values (1001,'ST08',10)
GO
insert into CTHD values (1002,'BC04',20)
GO
insert into CTHD values (1002,'BB01',20)
GO
insert into CTHD values (1002,'BB02',20)
GO
insert into CTHD values (1003,'BB03',10)
GO
insert into CTHD values (1004,'TV01',20)
GO
insert into CTHD values (1004,'TV02',20)
GO
insert into CTHD values (1004,'TV03',20)
GO
insert into CTHD values (1004,'TV04',20)
GO
insert into CTHD values (1005,'TV05',50)
GO
insert into CTHD values (1005,'TV06',50)
GO
insert into CTHD values (1006,'TV07',20)
GO
insert into CTHD values (1006,'ST01',30)
GO
insert into CTHD values (1006,'ST02',10)
GO
insert into CTHD values (1007,'ST03',10)
GO
insert into CTHD values (1008,'ST04',8)
GO
insert into CTHD values (1009,'ST05',10)
GO
insert into CTHD values (1010,'TV07',50)
GO
insert into CTHD values (1010,'ST07',50)
GO
insert into CTHD values (1010,'ST08',100)
GO
insert into CTHD values (1010,'ST04',50)
GO
insert into CTHD values (1010,'TV03',100)
GO
insert into CTHD values (1011,'ST06',50)
GO
insert into CTHD values (1012,'ST07',3)
GO
insert into CTHD values (1013,'ST08',5)
GO
insert into CTHD values (1014,'BC02',80)
GO
insert into CTHD values (1014,'BB02',100)
GO
insert into CTHD values (1014,'BC04',60)
GO
insert into CTHD values (1014,'BB01',50)
GO
insert into CTHD values (1015,'BB02',30)
GO
insert into CTHD values (1015,'BB03',7)
GO
insert into CTHD values (1016,'TV01',5)
GO
insert into CTHD values (1017,'TV02',1)
GO
insert into CTHD values (1017,'TV03',1)
GO
insert into CTHD values (1017,'TV04',5)
GO
insert into CTHD values (1018,'ST04',6)
GO
insert into CTHD values (1019,'ST05',1)
GO
insert into CTHD values (1019,'ST06',2)
GO
insert into CTHD values (1020,'ST07',10)
GO
insert into CTHD values (1021,'ST08',5)
GO
insert into CTHD values (1021,'TV01',7)
GO
insert into CTHD values (1021,'TV02',10)
GO
insert into CTHD values (1022,'ST07',1)
GO
insert into CTHD values (1023,'ST04',6)
GO