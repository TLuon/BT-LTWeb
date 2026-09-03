-- 1. Khởi tạo Database (Nếu chưa có)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'jakartaJPA')
BEGIN
    CREATE DATABASE jakartaJPA;
END
GO

USE jakartaJPA;
GO

-- 2. Xóa các bảng nếu đã tồn tại 
-- (Lưu ý: Phải xóa bảng con có chứa khóa ngoại trước, rồi mới xóa bảng cha)
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;
GO

-- 3. Tạo bảng categories
CREATE TABLE categories (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryname NVARCHAR(255) NULL,
    images NVARCHAR(255) NULL,
    status INT NOT NULL
);
GO

-- 4. Tạo bảng videos
CREATE TABLE videos (
    videoId VARCHAR(255) PRIMARY KEY,
    active BIT NOT NULL,
    description NVARCHAR(MAX) NULL,
    poster NVARCHAR(255) NULL,
    title NVARCHAR(255) NULL,
    views INT NOT NULL,
    categoryId INT,
    CONSTRAINT FK_Videos_Categories FOREIGN KEY (categoryId) REFERENCES categories(categoryId)
);
GO

-- 5. Tạo bảng users
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    fullname NVARCHAR(255),
    phone NVARCHAR(20),
    images NVARCHAR(255),
    role INT DEFAULT 0, -- 0: user, 1: admin
    status INT DEFAULT 0, -- 0: inactive (chưa xác thực OTP), 1: active
    otp_code VARCHAR(10),
    otp_expiry DATETIME
);
GO

-- 6. Tạo bảng products
CREATE TABLE products (
    productId INT IDENTITY(1,1) PRIMARY KEY,
    productName NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(18,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    images NVARCHAR(255),
    categoryId INT,
    status INT DEFAULT 1,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (categoryId) REFERENCES categories(categoryId)
);
GO

-- 7. Thêm dữ liệu mẫu (Dummy Data) để test giao diện
INSERT INTO categories (categoryname, images, status) VALUES 
(N'Điện thoại', 'https://placehold.co/100x100/ff7675/fff?text=DT', 1),
(N'Laptop', 'https://placehold.co/100x100/74b9ff/fff?text=LT', 1),
(N'Phụ kiện', 'https://placehold.co/100x100/55efc4/000?text=PK', 1);
GO

INSERT INTO products (productName, description, price, stock, images, categoryId, status) VALUES 
(N'iPhone 15 Pro Max', N'Siêu phẩm Apple mới nhất', 34900000, 50, 'https://placehold.co/400x300/ff7675/fff?text=iPhone+15', 1, 1),
(N'Samsung Galaxy S24 Ultra', N'Trí tuệ nhân tạo Galaxy AI', 31900000, 40, 'https://placehold.co/400x300/74b9ff/fff?text=S24+Ultra', 1, 1),
(N'MacBook Pro 14 M3', N'Hiệu năng cực đỉnh cho lập trình', 39900000, 20, 'https://placehold.co/400x300/55efc4/000?text=MacBook+M3', 2, 1),
(N'Dell XPS 15', N'Màn hình OLED 4K tuyệt đẹp', 45000000, 15, 'https://placehold.co/400x300/ffeaa7/000?text=Dell+XPS', 2, 1),
(N'Tai nghe AirPods Pro 2', N'Chống ồn chủ động xuất sắc', 5900000, 100, 'https://placehold.co/400x300/a29bfe/fff?text=AirPods', 3, 1),
(N'Chuột MX Master 3S', N'Chuột công thái học tốt nhất', 2500000, 60, 'https://placehold.co/400x300/fdcb6e/000?text=MX+Master', 3, 1),
(N'Bàn phím Keychron Q1', N'Gõ cực êm, custom dễ dàng', 3500000, 30, 'https://placehold.co/400x300/81ecec/000?text=Keychron', 3, 1);
GO
