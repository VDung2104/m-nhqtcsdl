---lab 2---
---câu1---
create view vw_dssp 
as
select * from Sanpham
select * from vw_dssp
------
create view vw_dsnv 
as
select * from Nhanvien
select * from vw_dsnv
----
create view vw_dsnhap 
as
select * from Nhap
select * from vw_dsnhap
-----
create view vw_dshsx 
as
select * from Hangsx
select * from vw_dshsx
------
create view vw_dsxuat 
as
select * from Xuat
select * from vw_dsxuat
---- 
---câu 2--
select masp, tensp, tenhang,soluong, mausac, giaban, donvitinh, mota from vw_dssp
inner join vw_dshsx on  vw_dssp.mahangsx=vw_dshsx.mahangsx
order by  giaban desc
---câu3---
select * from vw_dssp
inner join vw_dshsx on vw_dssp.mahangsx=vw_dshsx.mahangsx
where tenhang='samsung'
---câu4---
select * from vw_dsnv
where gioitinh='Nữ'
---câu5--
select *,(soluongN*dongiaN)as tiennhap  from vw_dsnhap
order by sohdn asc
---câu6--
select * from vw_dsxuat
inner join vw_dssp on vw_dsxuat.masp=vw_dssp.masp
inner join vw_dsnv on vw_dsxuat.manv=vw_dsnv.manv
order by sohdx asc
---câu 7---
SELECT sohdn, vw_dssp.masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong
FROM vw_dsnhap 
inner JOIN vw_dssp ON vw_dsnhap.masp = vw_dssp.masp 
inner JOIN vw_dshsx ON vw_dssp.mahangsx = vw_dshsx.mahangsx
inner JOIN vw_dsnv ON vw_dsnhap.manv = vw_dsnv.manv
WHERE vw_dshsx.tenhang = 'Samsung' AND YEAR(ngaynhap) = 2017;
--câu 8---
SELECT TOP 10 vw_dsxuat.sohdx, vw_dssp.tensp, vw_dsxuat.soluongX
FROM vw_dsxuat 
INNER JOIN vw_dssp ON vw_dsxuat.masp = vw_dssp.masp
WHERE YEAR(vw_dsxuat.ngayxuat) = '2023' 
ORDER BY vw_dsxuat.soluongX DESC;
---câu 9---
select top 10  tensp,giaban  from vw_dssp
order by giaban desc
--câu 10--
select * from vw_dssp
inner join vw_dshsx on vw_dshsx.tenhang=vw_dssp.mahangsx
where (100000< giaban and giaban < 500000 )and tenhang='samsung '
--câu 11--
select sum((soluongN * dongiaN)) as tongtien from vw_dsnhap
inner join vw_dssp on vw_dssp.masp= vw_dsnhap.masp
inner join vw_dshsx on vw_dssp.mahangsx=vw_dshsx.mahangsx
where tenhang='samsung' and year(ngaynhap)=2018
---câu12--
select sum((soluongX* giaban )) as tongtien from vw_dsxuat
inner join vw_dssp on vw_dssp.masp=vw_dsxuat.masp
where ngayxuat='2018-09-02'
--câu 13--
SELECT TOP 1 sohdn, ngaynhap, dongiaN
FROM vw_dsnhap
where year(ngaynhap)=2018
ORDER BY dongiaN DESC
---câu 14--
select top 10 tensp from vw_dsnhap
inner join vw_dssp on vw_dsnhap.masp=vw_dsnhap.masp
where YEAR(ngaynhap)=2019
order by soluongN desc
--câu 15--
SELECT vw_dssp.masp, vw_dssp.tensp
FROM vw_dssp
INNER JOIN vw_dshsx ON vw_dssp.mahangsx = vw_dshsx.mahangsx
INNER JOIN vw_dsnhap ON vw_dssp.masp = vw_dsnhap.masp
INNER JOIN vw_dsnv ON vw_dsnhap.manv = vw_dsnhap.manv
WHERE vw_dshsx.tenhang = 'Samsung' AND vw_dsnv.manv = 'NV01';
--câu 16--
select sohdn,vw_dsnhap.masp,soluongN,ngaynhap from vw_dsnhap
inner join vw_dssp on  vw_dssp.masp=vw_dsnhap.masp
inner join vw_dsxuat on vw_dssp.masp=vw_dsxuat.masp
inner join vw_dsnv on vw_dsxuat.manv=vw_dsnv.manv
where vw_dsnhap.masp='SP02' and vw_dsxuat.manv='NV02'
--câu 17--
select vw_dsnv.manv,tennv from vw_dsnv
join vw_dsxuat on vw_dsnv.manv=vw_dsxuat.manv
WHERE vw_dsxuat.masp = 'SP02' AND vw_dsxuat.ngayxuat = '2020-03-02'