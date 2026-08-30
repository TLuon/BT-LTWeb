<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #0f2027, #203a43, #2c5364); color: #fff; min-height: 100vh; padding: 2rem 0; }
        .glass-card { background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 15px; padding: 2rem; box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37); }
        .table { color: #fff; --bs-table-bg: transparent; --bs-table-border-color: rgba(255, 255, 255, 0.1); }
        .table-hover tbody tr:hover { background-color: rgba(255, 255, 255, 0.05); color: #fff; }
        .table th { font-weight: 600; text-transform: uppercase; font-size: 0.85rem; letter-spacing: 0.5px; color: #a8b2d1; }
        .btn-custom { border-radius: 50px; padding: 0.5rem 1.5rem; font-weight: 600; transition: all 0.3s ease; }
        .btn-custom:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .img-thumbnail-custom { border-radius: 10px; object-fit: cover; transition: transform 0.3s ease; }
        .img-thumbnail-custom:hover { transform: scale(1.1); }
        .badge-active { background: rgba(46, 213, 115, 0.2); color: #2ed573; border: 1px solid #2ed573; }
        .badge-inactive { background: rgba(255, 71, 87, 0.2); color: #ff4757; border: 1px solid #ff4757; }
    </style>
</head>
<body>
    <div class="container">
        <div class="glass-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0 fw-bold"><i class="bi bi-box-seam me-2 text-warning"></i> Danh sách Sản Phẩm</h2>
                <a href="<c:url value='/admin/product/add'/>" class="btn btn-warning text-dark btn-custom">
                    <i class="bi bi-plus-lg"></i> Thêm mới
                </a>
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th class="text-center">ID</th>
                            <th>Hình ảnh</th>
                            <th>Tên Sản phẩm</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Danh mục</th>
                            <th>Trạng thái</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listpro}" var="pro">
                            <tr>
                                <td class="text-center">${pro.productId}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${pro.images != null && pro.images.length() >= 5 && pro.images.substring(0,5) == 'https'}">
                                            <c:url value="${pro.images}" var="imgUrl"></c:url>
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${pro.images}" var="imgUrl"></c:url>
                                        </c:otherwise>
                                    </c:choose>
                                    <img src="${imgUrl}" class="img-thumbnail-custom" height="60" width="80" alt="img" onerror="this.src='https://placehold.co/80x60/2c3e50/FFF?text=No+Image'"/>
                                </td>
                                <td class="fw-bold">${pro.productName}</td>
                                <td class="text-warning fw-bold">${pro.price} VNĐ</td>
                                <td>${pro.stock}</td>
                                <td><span class="badge bg-secondary">${pro.category.categoryname}</span></td>
                                <td>
                                    <c:if test="${pro.status==1}">
                                        <span class="badge badge-active px-3 py-2 rounded-pill"><i class="bi bi-check-circle me-1"></i> Có sẵn</span>
                                    </c:if>
                                    <c:if test="${pro.status!=1}">
                                        <span class="badge badge-inactive px-3 py-2 rounded-pill"><i class="bi bi-x-circle me-1"></i> Hết hàng</span>
                                    </c:if>
                                </td>
                                <td class="text-end">
                                    <a href="<c:url value='/admin/product/edit?id=${pro.productId}'/>" class="btn btn-sm btn-outline-info rounded-circle me-1" title="Sửa">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="<c:url value='/admin/product/delete?id=${pro.productId}'/>" class="btn btn-sm btn-outline-danger rounded-circle" onclick="return confirm('Xóa sản phẩm này?');" title="Xóa">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
