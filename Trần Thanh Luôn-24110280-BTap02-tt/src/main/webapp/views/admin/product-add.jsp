<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-warning text-dark">
                <h4>Thêm Sản Phẩm Mới</h4>
            </div>
            <div class="card-body">
                <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label>Tên Sản Phẩm</label>
                        <input type="text" name="productname" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Mô tả</label>
                        <textarea name="description" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Giá (VNĐ)</label>
                            <input type="number" step="0.01" name="price" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Số lượng</label>
                            <input type="number" name="stock" class="form-control" value="0" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label>Danh mục</label>
                        <select name="categoryId" class="form-select">
                            <c:forEach items="${listcate}" var="c">
                                <option value="${c.categoryId}">${c.categoryname}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label>Hình ảnh</label>
                        <input type="file" name="images1" class="form-control" accept="image/*">
                    </div>
                    <div class="mb-3">
                        <label>Trạng thái</label>
                        <select name="status" class="form-select">
                            <option value="1">Có sẵn</option>
                            <option value="0">Hết hàng</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-warning w-100">Lưu Sản Phẩm</button>
                    <a href="<c:url value='/admin/products'/>" class="btn btn-secondary w-100 mt-2">Quay lại</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
