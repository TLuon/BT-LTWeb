-- 1. Khởi tạo Database
CREATE DATABASE jakartaJPA;
GO

USE jakartaJPA;
GO
-- 2. Tạo bảng categories
CREATE TABLE categories (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    categoryname NVARCHAR(255) NULL,
    images NVARCHAR(255) NULL,
    status INT NOT NULL
);
GO

-- 3. Tạo bảng videos
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
