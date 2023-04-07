---Cau1---
CREATE PROCEDURE sp_InsertHangsx
    @mahangsx nvarchar(10),
    @tenhang nvarchar(50),
    @diachi nvarchar(100),
    @sodt nvarchar(20),
    @email nvarchar(50)
AS
BEGIN
    IF EXISTS(SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        PRINT 'Tên hãng sản xuất đã tồn tại. Vui lòng kiểm tra lại!'
    END
    ELSE
    BEGIN
        INSERT INTO Hangsx(mahangsx, tenhang, diachi, sodt, email)
        VALUES (@mahangsx, @tenhang, @diachi, @sodt, @email)
    END
END

EXEC sp_InsertHangsx 'HSX01', 'Samsung', 'Hàn Quốc', '0123456789', 'contact@samsung.com'

---Câu 2---
CREATE PROCEDURE sp_ThemSuaSanPham
    @masp NVARCHAR(10),
    @mahangsx NVARCHAR(10),
    @tensp NVARCHAR(50),
    @soluong INT,
    @mausac NVARCHAR(20),
    @giaban FLOAT,
    @donvitinh NVARCHAR(20),
    @mota NVARCHAR(200)
AS
BEGIN
    IF EXISTS (SELECT * FROM sanpham WHERE masp = @masp)
    BEGIN
        UPDATE sanpham SET 
            mahangsx = @mahangsx,
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp
    END
    ELSE
    BEGIN
        INSERT INTO sanpham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES (@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
    END
END

---Câu 3---

CREATE PROCEDURE sp_DeleteHangSX
    @tenhang NVARCHAR(50)
AS
BEGIN
    -- Kiểm tra xem hãng có tồn tại trong bảng hay không
    IF NOT EXISTS (SELECT * FROM Hangsx WHERE tenhang = @tenhang)
    BEGIN
        PRINT 'Hãng không tồn tại trong bảng'
        RETURN
    END

    BEGIN TRANSACTION

    -- Xóa tất cả các sản phẩm của hãng
    DELETE FROM Sanpham WHERE mahangsx = (SELECT mahangsx FROM Hangsx WHERE tenhang = @tenhang)

    -- Xóa hãng
    DELETE FROM Hangsx WHERE tenhang = @tenhang

    COMMIT TRANSACTION
END

---Câu 4---
CREATE PROCEDURE sp_NhapNhanVien
    @manv VARCHAR(10),
    @tennv NVARCHAR(50),
    @gioitinh NVARCHAR(3),
    @diachi NVARCHAR(100),
    @sodt VARCHAR(20),
    @email NVARCHAR(50),
    @phong NVARCHAR(50),
    @flag BIT
AS
BEGIN
    IF @flag = 0
    BEGIN
        UPDATE Nhanvien
        SET tennv = @tennv,
            gioitinh = @gioitinh,
            diachi = @diachi,
            sodt = @sodt,
            email = @email,
            phong = @phong
        WHERE manv = @manv;
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
        BEGIN
            RAISERROR('Mã nhân viên đã tồn tại!', 16, 1);
            RETURN;
        END
        INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
        VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong);
    END
END

---Câu 5---

CREATE PROCEDURE ThemNhap(@sohdn varchar(20), @masp varchar(20), @manv varchar(20), @ngaynhap date, @soluongN int, @dongiaN float)
AS
BEGIN
    -- Kiểm tra mã sản phẩm và nhân viên có tồn tại hay không
    IF NOT EXISTS(SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT 'Mã sản phẩm không tồn tại'
        RETURN
    END
    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại'
        RETURN
    END

    -- Kiểm tra nếu mã nhập đã tồn tại thì cập nhật bảng nhập
    IF EXISTS(SELECT * FROM Nhap WHERE sohdn = @sohdn)
    BEGIN
        UPDATE Nhap SET masp = @masp, manv = @manv, ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN
        WHERE sohdn = @sohdn
    END
    ELSE -- Ngược lại thì thêm mới bảng nhập
    BEGIN
        INSERT INTO Nhap(sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
        VALUES(@sohdn, @masp, @manv, @ngaynhap, @soluongN, @dongiaN)
    END

    -- Kiểm tra nếu mã nhập đã tồn tại thì cập nhật bảng xuất
    IF EXISTS(SELECT * FROM Xuat WHERE sohdx = @sohdn)
    BEGIN
        UPDATE Xuat SET masp = @masp, manv = @manv, ngayxuat = @ngaynhap, soluongX = @soluongN
        WHERE sohdx = @sohdn
    END
    ELSE -- Ngược lại thì thêm mới bảng xuất
    BEGIN
        DECLARE @sohdx varchar(20)
        SET @sohdx = 'X' + @sohdn
        INSERT INTO Xuat(sohdx, masp, manv, ngayxuat, soluongX)
        VALUES(@sohdx, @masp, @manv, @ngaynhap, @soluongN)
    END
END

---Câu 6---
CREATE PROCEDURE them_capnhat_Xuat 
(
    @sohdx INT,
    @masp INT,
    @manv INT,
    @ngayxuat DATE,
    @soluongX INT
)
AS
BEGIN
    -- Kiểm tra xem mã sản phẩm có tồn tại trong bảng Sanpham hay không
    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT 'Mã sản phẩm không tồn tại trong bảng Sanpham.'
        RETURN
    END
    
    -- Kiểm tra xem mã nhân viên có tồn tại trong bảng Nhanvien hay không
    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại trong bảng Nhanvien.'
        RETURN
    END
    
    -- Kiểm tra số lượng xuất có nhỏ hơn hoặc bằng số lượng tồn kho
    IF @soluongX > (SELECT soluong FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT 'Số lượng xuất vượt quá số lượng tồn kho.'
        RETURN
    END
    
    -- Kiểm tra xem số hóa đơn xuất đã tồn tại hay chưa
    IF EXISTS (SELECT * FROM Xuat WHERE sohdx = @sohdx)
    BEGIN
        UPDATE Xuat 
        SET masp = @masp, manv = @manv, ngayxuat = @ngayxuat, soluongX = @soluongX 
        WHERE sohdx = @sohdx
        PRINT 'Cập nhật dữ liệu bảng Xuat thành công.'
    END
    ELSE
    BEGIN
        INSERT INTO Xuat(sohdx, masp, manv, ngayxuat, soluongX)
        VALUES (@sohdx, @masp, @manv, @ngayxuat, @soluongX)
        PRINT 'Thêm dữ liệu vào bảng Xuat thành công.'
    END
END

---Câu 7---
CREATE PROCEDURE sp_DeleteNhanvien 
    @manv INT
AS
BEGIN
    -- Kiểm tra manv có tồn tại trong bảng nhanvien hay không
    IF NOT EXISTS(SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        PRINT 'Không tìm thấy nhân viên với mã ' + CAST(@manv AS NVARCHAR)
        RETURN
    END

    -- Xóa các bản ghi liên quan trong bảng Nhap và Xuat
    DELETE FROM Nhap WHERE manv = @manv
    DELETE FROM Xuat WHERE manv = @manv

    -- Xóa nhanvien
    DELETE FROM Nhanvien WHERE manv = @manv

    PRINT 'Đã xóa nhân viên với mã ' + CAST(@manv AS NVARCHAR)
END


---Câu 8---
CREATE PROCEDURE sp_DeleteSanpham
  @masp VARCHAR(10)
AS
BEGIN
  SET NOCOUNT ON;

  IF NOT EXISTS (SELECT 1 FROM Sanpham WHERE masp = @masp)
  BEGIN
    PRINT 'Không tìm thấy sản phẩm để xóa!'
    RETURN;
  END

  BEGIN TRY
    BEGIN TRANSACTION

    -- Xóa các bản ghi trong bảng Nhap liên quan đến sản phẩm cần xóa
    DELETE FROM Nhap WHERE masp = @masp;

    -- Xóa các bản ghi trong bảng Xuat liên quan đến sản phẩm cần xóa
    DELETE FROM Xuat WHERE masp = @masp;

    -- Xóa bản ghi trong bảng Sanpham
    DELETE FROM Sanpham WHERE masp = @masp;

    COMMIT TRANSACTION
    PRINT 'Đã xóa sản phẩm ' + @masp
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Đã xảy ra lỗi trong quá trình xóa sản phẩm!'
  END CATCH
END