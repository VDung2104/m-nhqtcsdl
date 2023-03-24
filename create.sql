INSERT INTO Hangsx (mahangsx, tenhang, diachi, sodt, email)
VALUES
('H01', 'Samsung', 'Korea', '011-08271717', 'ss@gmail.com.kr'),
('H02', 'OPPO', 'China', '081-08626262', 'oppo@gmail.com.cn'),
('H03', 'Vinfone', 'Vi?t nam', '084-098262626', 'vf@gmail.com.vn');

INSERT INTO Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES
('NV01', 'Nguy?n Th? Thu', 'N?', 'H� N?i', '0982626521', 'thu@gmail.com', 'K? to�n'),
('NV02', 'L� V?n Nam', 'Nam', 'B?c Ninh', '0972525252', 'nam@gmail.com', 'V?t t?'),
('NV03', 'Tr?n H�a B�nh', 'N?', 'H� N?i', '0328388388', 'hb@gmail.com', 'K? to�n');

INSERT INTO Sanpham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
VALUES
('SP01', 'H02', 'Galaxy Note11', 50, '??', 1900000, 'Chi?c', 'H�ng c?n c?o c?p'),
('SP02', 'H01', 'F1 Plus', 100, 'X�m', 7000000, 'Chi?c', 'H�ng c?n c?o c?p'),
('SP03', 'H02', 'F3 lite', 200, 'N�u', 3000000, 'Chi?c', 'H�ng ph? th�ng'),
('SP04', 'H03', 'Vjoy3', 200, 'X�m', 1500000, 'Chi?c', 'H�ng ph? th�ng'),
('SP05', 'H01', 'Galaxy V21', 500, 'N�u', 8000000, 'Chi?c', 'H�ng c?n c?o c?p');

INSERT INTO Nhap (sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
VALUES
('N01', 'SP02', 'NV01', '2019-05-02', 10, 17000000),
('N02', 'SP01', 'NV02', '2020-07-04', 30, 6000000),
('N03', 'SP04', 'NV02', '2020-05-17', 20, 1200000),
('N04', 'SP01', 'NV03', '2020-03-22', 10, 6200000),
('N05', 'SP05', 'NV01', '2020-07-07', 20, 7000000);


INSERT INTO Xuat (sohdx, masp, manv, ngayxuat, soluongX) VALUES 
('X01', 'SP03', 'NV02', '06-14-2020', 5),
('X02', 'SP01', 'NV03', '03-05-2019', 3),
('X03', 'SP02', 'NV01', '12-12-2020', 1),
('X04', 'SP03', 'NV02', '06-02-2020', 2),
('X05', 'SP05', 'NV01', '05-18-2020', 1);