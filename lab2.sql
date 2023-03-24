SELECT SUM(giaban*soluongX) as TongTienXuat
FROM Xuat 
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp 
WHERE ngayxuat = '2018-09-02';

# Câu 13:Đưa ra sohdn, ngaynhap có tiền nhập phải trả cao nhất trong năm 2018

SELECT TOP 1 sohdn, ngaynhap
FROM Nhap
WHERE YEAR(ngaynhap) = 2018
ORDER BY soluongN*dongiaN DESC;

# Câu 14:Đưa ra 10 mặt hàng có soluongN nhiều nhất trong năm 2019.

SELECT TOP 10 masp, SUM(soluongN) as TongSoLuongN
FROM Nhap
WHERE YEAR(ngaynhap) = 2019
GROUP BY masp
ORDER BY TongSoLuongN DESC;

# Câu 15:Đưa ra masp,tensp của các sản phẩm do công ty ‘Samsung’ sản xuất do nhân viên có
mã ‘NV01’ nhập.

SELECT Sanpham.masp, tensp
FROM Sanpham 
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE Hangsx.tenhang = 'Samsung' AND Nhap.manv = 'NV01';

# Câu 16:Đưa ra sohdn,masp,soluongN,ngayN của mặt hàng có masp là ‘SP02’, được nhân
viên ‘NV02’ xuất.

SELECT sohdn, Nhap.masp, soluongN, ngaynhap
FROM Nhap
JOIN Xuat ON Nhap.sohdn = Xuat.sohdx
WHERE Nhap.masp = 'SP02' AND Xuat.manv = 'NV02';

# Câu 17:Đưa ra manv,tennv đã xuất mặt hàng có mã ‘SP02’ ngày ’03-02-2020’.

SELECT manv, tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-02-03';
