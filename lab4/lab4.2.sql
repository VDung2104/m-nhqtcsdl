---lab3----
---Câu 1---
SELECT vw_dshsx.mahangsx, vw_dshsx.tenhang, COUNT(vw_dssp.masp) AS SoLoaiSanPham
FROM vw_dshsx
LEFT JOIN vw_dssp ON vw_dshsx.mahangsx = vw_dssp.mahangsx
GROUP BY vw_dshsx.mahangsx, vw_dshsx.tenhang;
---Câu 2---
SELECT vw_dssp.masp, vw_dssp.tensp, SUM(vw_dsnhap.soluongN * vw_dsnhap.dongiaN) AS TongTienNhap
FROM vw_dssp
INNER JOIN vw_dsnhap ON vw_dssp.masp = vw_dssp.masp
WHERE YEAR(vw_dsnhap.ngaynhap) = 2018
GROUP BY vw_dssp.masp, vw_dssp.tensp;
---Câu 3:----
SELECT vw_dssp.masp, vw_dssp.tensp, SUM(vw_dsxuat.soluongX) AS TongSoLuongXuat
FROM vw_dssp
INNER JOIN vw_dsxuat ON vw_dssp.masp = vw_dsxuat.masp
WHERE YEAR(vw_dsxuat.ngayxuat) = 2018 AND vw_dssp.mahangsx = 'SAMSUNG' 
GROUP BY vw_dssp.masp, vw_dssp.tensp
HAVING SUM(vw_dsxuat.soluongX) > 10000;
----Câu 4---
SELECT vw_dsnv.phong, COUNT(*) AS SoLuongNhanVienNam
FROM vw_dsnv
WHERE vw_dsnv.gioitinh = N'Nam'
GROUP BY vw_dsnv.phong;
---Câu 5:---
SELECT vw_dshsx.tenhang, SUM(vw_dsnhap.soluongN) AS TongSoLuongNhap
FROM vw_dshsx
INNER JOIN vw_dssp ON vw_dshsx.mahangsx = vw_dssp.mahangsx
INNER JOIN vw_dsnhap ON vw_dssp.masp = vw_dsnhap.masp
WHERE YEAR(vw_dsnhap.ngaynhap) = 2018
GROUP BY vw_dshsx.tenhang
---Câu 6:---
SELECT vw_dsnv.tennv, SUM(vw_dsxuat.soluongX * vw_dssp.giaban) AS TongTienXuat
FROM vw_dsnv
INNER JOIN vw_dsxuat ON vw_dsnv.manv = vw_dsxuat.manv
INNER JOIN vw_dssp ON vw_dsxuat.masp = vw_dsxuat.masp
WHERE YEAR(vw_dsxuat.ngayxuat) = 2018
GROUP BY vw_dsnv.tennv
---Câu 7:---
SELECT vw_dsnv.tennv, SUM(vw_dsnhap.soluongN * vw_dsnhap.dongiaN) AS TongTienNhap
FROM vw_dsnv
INNER JOIN vw_dsnhap ON vw_dsnv.manv = vw_dsnhap.manv
WHERE YEAR(vw_dsnhap.ngaynhap) = 2018 AND MONTH(vw_dsnhap.ngaynhap) = 8
GROUP BY vw_dsnv.tennv
HAVING SUM(vw_dsnhap.soluongN * vw_dsnhap.dongiaN) > 100000
---Câu 8:---
SELECT vw_dssp.masp, vw_dssp.tensp, vw_dssp.soluong, vw_dssp.mausac, vw_dssp.giaban, vw_dssp.donvitinh, vw_dssp.mota
FROM vw_dssp
LEFT JOIN vw_dsxuat ON vw_dssp.masp = vw_dsxuat.masp
WHERE vw_dsxuat.masp IS NULL
---Câu 9----
SELECT vw_dssp.masp, vw_dssp.tensp, vw_dssp.soluong, vw_dssp.mausac, vw_dssp.giaban, vw_dssp.donvitinh, vw_dssp.mota
FROM vw_dssp
INNER JOIN vw_dsnhap ON vw_dssp.masp =vw_dsnhap.masp
INNER JOIN vw_dsxuat ON vw_dsxuat.masp = vw_dssp.masp
WHERE YEAR(vw_dsnhap.ngaynhap) = 2018 AND YEAR(vw_dsxuat.ngayxuat) = 2018
---Câu 10----
SELECT vw_dsnv.manv, vw_dsnv.tennv
FROM vw_dsnv
INNER JOIN vw_dsnhap ON vw_dsnv.manv = vw_dsnhap.manv
INNER JOIN vw_dsxuat ON vw_dsnv.manv = vw_dsxuat.manv
-----Câu 11---
SELECT *
FROM vw_dsnv
LEFT JOIN vw_dsnhap ON vw_dsnv.manv = vw_dsnhap.manv
LEFT JOIN vw_dsxuat ON vw_dsnhap.manv = vw_dsnv.manv
WHERE vw_dsnhap.manv IS NULL AND vw_dsxuat.manv IS NULL;
