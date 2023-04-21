--câu 1
CREATE TABLE Ton (
MaVT VARCHAR(50) PRIMARY KEY,
TenVT VARCHAR(255),
SoLuongT INT
);

CREATE TABLE Nhap (
SoHDN INT PRIMARY KEY,
MaVT VARCHAR(50),
SoLuongN INT,
DonGiaN FLOAT,
NgayN DATE,
FOREIGN KEY (MaVT) REFERENCES Ton(MaVT)
);

CREATE TABLE Xuat (
SoHDX INT PRIMARY KEY,
MaVT VARCHAR(50),
SoLuongX INT,
DonGiaX FLOAT,
NgayX DATE,
FOREIGN KEY (MaVT) REFERENCES Ton(MaVT)
);

INSERT INTO Ton (MaVT, TenVT, SoLuongT)
VALUES ('VT001', 'Cát', 100),
('VT002', 'Đá', 200),
('VT003', 'Xi măng', 300);

INSERT INTO Nhap (SoHDN, MaVT, SoLuongN, DonGiaN, NgayN)
VALUES (1, 'VT001', 50, 10000, '2023-04-20'),
(2, 'VT002', 100, 20000, '2023-04-19'),
(3, 'VT003', 150, 30000, '2023-04-18');

INSERT INTO Xuat (SoHDX, MaVT, SoLuongX, DonGiaX, NgayX)
VALUES (101, 'VT001', 20, 15000, '2023-04-17'),
(102, 'VT002', 30, 25000, '2023-04-16'),
(103, 'VT003', 40, 35000, '2023-04-15');

--Câu 2
CREATE FUNCTION ThongKeTienBan (@mavt VARCHAR(50))
RETURNS TABLE
AS
RETURN
  SELECT X.MaVT, T.TenVT, SUM(X.SoLuongX * X.DonGiaX) AS TienBan
  FROM Xuat X
  INNER JOIN Ton T ON X.MaVT = T.MaVT
  WHERE X.MaVT = @mavt
  GROUP BY X.MaVT, T.TenVT, X.NgayX;

SELECT * FROM ThongKeTienBan('VT001');
--Câu 3
CREATE FUNCTION ThongKeTienNhap (@mavt VARCHAR(50), @ngaynhap DATE)
RETURNS TABLE
AS
RETURN
  SELECT MaVT, SUM(SoLuongN * DonGiaN) AS TienNhap
  FROM Nhap
  WHERE MaVT = @mavt AND NgayN = @ngaynhap
  GROUP BY MaVT;

SELECT * FROM ThongKeTienNhap('VT002', '2023-04-19');
--Câu 4
CREATE TRIGGER UpdateTonAfterInsertNhap
ON Nhap
AFTER INSERT
AS
BEGIN
  IF EXISTS (SELECT 1 FROM Ton WHERE Ton.MaVT = (SELECT MaVT FROM inserted))
  BEGIN
    UPDATE Ton
    SET SoLuongT = SoLuongT + (SELECT SoLuongN FROM inserted WHERE inserted.MaVT = Ton.MaVT)
    WHERE Ton.MaVT = (SELECT MaVT FROM inserted);
  END
  ELSE
  BEGIN
    RAISERROR('Mã VT chưa có mặt trong bảng Ton', 16, 1);
    ROLLBACK TRANSACTION;
  END
END;

INSERT INTO Nhap (SoHDN, MaVT, SoLuongN, DonGiaN, NgayN)
VALUES (4, 'VT001', 30, 12000, '2023-04-21');

SELECT * FROM Ton;