---Câu 1----
CREATE FUNCTION dbo.fn_getTenHangSX (@masp VARCHAR(10))
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @tenhang VARCHAR(50)
    SELECT @tenhang = tenhang
    FROM Hangsx
    WHERE mahangsx = (
        SELECT mahangsx
        FROM Sanpham
        WHERE masp = @masp
    )
    RETURN @tenhang
END

---câu 2----
CREATE FUNCTION dbo.fn_getTongGiaTriNhap (@x INT, @y INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @tongGiaTriNhap MONEY
    SELECT @tongGiaTriNhap = SUM(soluongN * dongiaN)
    FROM Nhap
    WHERE YEAR(ngaynhap) BETWEEN @x AND @y
    RETURN @tongGiaTriNhap
END

----Câu 3-----
CREATE FUNCTION dbo.fn_getTongSLNhapXuat (@x VARCHAR(10), @y INT)
RETURNS INT
AS
BEGIN
    DECLARE @tongSLNhapXuat INT
    SELECT @tongSLNhapXuat = SUM(soluongN) - SUM(soluongX)
    FROM (
        SELECT masp, soluongN, 0 AS soluongX
        FROM Nhap
        WHERE masp = @x AND YEAR(ngaynhap) = @y
        UNION ALL
        SELECT masp, 0 AS soluongN, soluongX
        FROM Xuat
        WHERE masp = @x AND YEAR(ngayxuat) = @y
    ) AS NhapXuat
    RETURN @tongSLNhapXuat
END

--Câu 4---
CREATE FUNCTION TinhTongGiaTriNhapNgay(@ngayX DATE, @ngayY DATE)
RETURNS MONEY
AS
BEGIN
    DECLARE @tongGiaTriNhap MONEY

    SELECT @tongGiaTriNhap = SUM(dongiaN * soluongN)
    FROM Nhap
    WHERE ngaynhap >= @ngayX AND ngaynhap <= @ngayY

    RETURN @tongGiaTriNhap
END
SELECT dbo.TinhTongGiaTriNhapNgay('2022-01-01', '2022-12-31') AS TongGiaTriNhap
	---Câu 5----
CREATE FUNCTION fn_TongGiaTriXuat(@tenHang NVARCHAR(20), @nam INT)
RETURNS MONEY
AS
BEGIN
  DECLARE @tongGiaTriXuat MONEY;
  SELECT @tongGiaTriXuat = SUM(S.giaban * X.soluongX)
  FROM Xuat X
  JOIN Sanpham S ON X.masp = S.masp
  JOIN Hangsx H ON S.mahangsx = H.mahangsx
  WHERE H.tenhang = @tenHang AND YEAR(X.ngayxuat) = @nam;
  RETURN @tongGiaTriXuat;
END;
SELECT dbo.fn_TongGiaTriXuat('Samsung', 2022) AS 'TongGiaTriXuat';	
	---câu 6---
CREATE FUNCTION fn_ThongKeNhanVienTheoPhong (@tenPhong NVARCHAR(30))
RETURNS TABLE
AS
RETURN
    SELECT phong, COUNT(manv) AS soLuongNhanVien
    FROM Nhanvien
    WHERE phong = @tenPhong
    GROUP BY phong;
SELECT * FROM fn_ThongKeNhanVienTheoPhong('Kế toán')	
 
	---câu 7----
CREATE FUNCTION sp_xuat_trong_ngay(@ten_sp NVARCHAR(20), @ngay_xuat DATE)
RETURNS INT
AS
BEGIN
  DECLARE @so_luong_xuat INT
  SELECT @so_luong_xuat = SUM(soluongX)
  FROM Xuat x JOIN Sanpham sp ON x.masp = sp.masp
  WHERE sp.tensp = @ten_sp AND x.ngayxuat = @ngay_xuat
  RETURN @so_luong_xuat
END
SELECT dbo.sp_xuat_trong_ngay('Samsung', '12-12-2020') as 'sản phẩm sản xuất trong ngày'	
	---câu 8----
CREATE FUNCTION SoDienThoaiNV (@InvoiceNumber NCHAR(10))
RETURNS NVARCHAR(20)
AS
BEGIN
  DECLARE @EmployeePhone NVARCHAR(20)
  SELECT @EmployeePhone = Nhanvien.sodt
  FROM Nhanvien
  INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
  WHERE Xuat.sohdx = @InvoiceNumber
  RETURN @EmployeePhone
END
SELECT dbo.SoDienThoaiNV('X01')
	---câu 9----
CREATE FUNCTION ThongKeSoLuongThayDoi(@tenSP NVARCHAR(20), @nam INT)
RETURNS INT
AS
BEGIN
  DECLARE @tongNhapXuat INT;
  SET @tongNhapXuat = (SELECT COALESCE(SUM(nhap.soluongN), 0) + COALESCE(SUM(xuat.soluongX), 0) AS tongSoLuong
    FROM Sanpham sp
    LEFT JOIN Nhap nhap ON sp.masp = nhap.masp
    LEFT JOIN Xuat xuat ON sp.masp = xuat.masp
    WHERE sp.tensp = @tenSP AND YEAR(nhap.ngaynhap) = @nam AND YEAR(xuat.ngayxuat) = @nam
  );
  RETURN @tongNhapXuat;
END;
SELECT dbo.ThongKeSoLuongThayDoi('Galaxy Note11', 2020) AS TongNhapXuat;
	
	---câu 10---
SELECT COALESCE(SUM(nhap.soluongN), 0) + COALESCE(SUM(xuat.soluongX), 0) AS tongSoLuong
    FROM Sanpham sp
    LEFT JOIN Nhap nhap ON sp.masp = nhap.masp
    LEFT JOIN Xuat xuat ON sp.masp = xuat.masp
    WHERE sp.tensp = @tenSP AND YEAR(nhap.ngaynhap) = @nam AND YEAR(xuat.ngayxuat) = @nam
  );
  RETURN @tongNhapXuat;
END;
SELECT dbo.ThongKeSoLuongThayDoi('Galaxy Note11', 2020) AS TongNhapXuat;