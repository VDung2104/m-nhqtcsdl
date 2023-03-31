----câu 1------
create function ThongTinSanPhamTheoHangSX(@tenhangsx nvarchar(50))
returns @sanpham table(
masp nvarchar(10),
mahangsx nvarchar(10),
tensp nvarchar(50),
soluong int,
mausac nvarchar(20),
giaban float,
donvitinh nvarchar(20),
mota nvarchar(max)
)
as
begin
insert into @sanpham
select masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota
from Sanpham
where mahangsx = (select mahangsx from Hangsx where tenhang = @tenhangsx)
return
end
---câu 2---
create function DanhSachSanPhamHangSXNhap(@ngaybatdau datetime, @ngayketthuc datetime)
returns @sanphamhangsx table(
tensp nvarchar(50),
tenhangsx nvarchar(50),
soluongN int,
dongiaN float
)
as
begin
insert into @sanphamhangsx
select sp.tensp, hsx.tenhang, np.soluongN, np.dongiaN
from Sanpham sp
inner join Hangsx hsx on sp.mahangsx = hsx.mahangsx
inner join Nhap np on sp.masp = np.masp
where np.ngaynhap between @ngaybatdau and @ngayketthuc
return
end

---câu 3 ---
CREATE FUNCTION sp_by_hangsx_soluong(@tenhangsx NVARCHAR(50), @luachon INT)
RETURNS @sanpham TABLE (
    masp INT,
    mahangsx INT,
    tensp NVARCHAR(50),
    soluong INT,
    mausac NVARCHAR(20),
    giaban FLOAT,
    donvitinh NVARCHAR(10),
    mota NVARCHAR(MAX)
)
AS
BEGIN
    IF @luachon = 0
    BEGIN
        INSERT INTO @sanpham
        SELECT masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota
        FROM Sanpham
        WHERE mahangsx = (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhangsx) AND soluong = 0
    END
    ELSE
    BEGIN
        INSERT INTO @sanpham
        SELECT masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota
        FROM Sanpham
        WHERE mahangsx = (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhangsx) AND soluong > 0
    END
    RETURN
END
----câu 4------
CREATE FUNCTION nv_by_phong(@tenphong NVARCHAR(50))
RETURNS @nhanvien TABLE (
    manv INT,
    tennv NVARCHAR(50),
    gioitinh NVARCHAR(10),
    diachi NVARCHAR(100),
    sodt NVARCHAR(20),
    email NVARCHAR(50),
    phong NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @nhanvien
    SELECT manv, tennv, gioitinh, diachi, sodt, email, phong
    FROM Nhanvien
    WHERE phong = @tenphong
    RETURN
END

--- câu 5---
CREATE FUNCTION DanhSachHangSXTheoDiaChi(@diaChi NVARCHAR(50))
RETURNS @hangSX TABLE (
    mahangsx INT,
    tenhang NVARCHAR(50),
    diachi NVARCHAR(50),
    sodt NVARCHAR(20),
    email NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @hangSX
    SELECT mahangsx, tenhang, diachi, sodt, email
    FROM Hangsx
    WHERE diachi LIKE '%' + @diaChi + '%'

    RETURN
END
---câu 6---
CREATE FUNCTION DanhSachSanPhamVaHangSXDaXuat(@namX INT, @namY INT)
RETURNS @sanPhamHangSX TABLE (
    masp INT,
    tensp NVARCHAR(50),
    tenhang NVARCHAR(50),
    ngayxuat DATE,
    soluongX INT
)
AS
BEGIN
    INSERT INTO @sanPhamHangSX
    SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Xuat.ngayxuat, Xuat.soluongX
    FROM Sanpham
    JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
    JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Xuat.ngayxuat) BETWEEN @namX AND @namY

    RETURN
END

---câu 7---
CREATE FUNCTION dbo.DanhSachSanPhamTheoHangSXVaLuaChon
(
    @mahangsx INT,
    @luaChon INT
)
RETURNS TABLE
AS
RETURN 
(
    SELECT 
        sp.masp, 
        sp.tensp, 
        sp.soluong, 
        sp.giaban, 
        sp.donvitinh, 
        sp.mota
    FROM 
        Sanpham sp
        JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
        LEFT JOIN Nhap n ON sp.masp = n.masp
        LEFT JOIN Xuat x ON sp.masp = x.masp
    WHERE 
        hs.mahangsx = @mahangsx 
        AND (@luaChon = 0 AND n.masp IS NOT NULL OR @luaChon = 1 AND x.masp IS NOT NULL)
)

--- câu 8---
CREATE FUNCTION dbo.DanhSachNhanVienDaNhapHang
(
    @ngayNhap DATE
)
RETURNS TABLE
AS
RETURN 
(
    SELECT 
        nv.manv, 
        nv.tennv, 
        nv.gioitinh, 
        nv.diachi, 
        nv.sodt, 
        nv.email, 
        nv.phong
    FROM 
        Nhanvien nv 
        JOIN Nhap n ON nv.manv = n.manv
    WHERE 
        n.ngaynhap = @ngayNhap
)

---câu 9---
CREATE FUNCTION GetProductsByPriceAndManufacturer
(
    @minPrice FLOAT,
    @maxPrice FLOAT,
    @manufacturer VARCHAR(50)
)
RETURNS @products TABLE
(
    masp VARCHAR(10),
    mahangsx VARCHAR(10),
    tensp NVARCHAR(50),
    soluong INT,
    mausac NVARCHAR(50),
    giaban FLOAT,
    donvitinh NVARCHAR(20),
    mota NVARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO @products
    SELECT s.masp, s.mahangsx, s.tensp, s.soluong, s.mausac, s.giaban, s.donvitinh, s.mota
    FROM Sanpham s
    INNER JOIN Hangsx h ON s.mahangsx = h.mahangsx
    WHERE s.giaban >= @minPrice AND s.giaban <= @maxPrice AND h.tenhang = @manufacturer
    RETURN
END

---câu 10---

CREATE FUNCTION GetProductsAndManufacturers
(
)
RETURNS @productManufacturers TABLE
(
    masp VARCHAR(10),
    mahangsx VARCHAR(10),
    tensp NVARCHAR(50),
    soluong INT,
    mausac NVARCHAR(50),
    giaban FLOAT,
    donvitinh NVARCHAR(20),
    mota NVARCHAR(MAX),
    tenhang NVARCHAR(50),
    diachi NVARCHAR(100),
    sodt VARCHAR(20),
    email VARCHAR(50)
)
AS
BEGIN
