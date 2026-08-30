<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.productName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Outfit', sans-serif; background-color: #f4f6f9; }
        .product-img { border-radius: 20px; width: 100%; object-fit: cover; max-height: 500px; box-shadow: 0 20px 40px rgba(0,0,0,0.1); }
        .detail-card { background: white; border-radius: 20px; padding: 2rem; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .price-tag { font-size: 2.5rem; font-weight: 700; color: #ff4757; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-5">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<c:url value='/'/>">MyApp</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/'/>">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/product'/>">Sản phẩm</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/'/>">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/product'/>">Sản phẩm</a></li>
                <li class="breadcrumb-item active">${product.productName}</li>
            </ol>
        </nav>

        <div class="row mt-4 detail-card">
            <div class="col-md-6 mb-4">
                <c:choose>
                    <c:when test="${product.images != null && product.images.length() >= 5 && product.images.substring(0,5) == 'https'}">
                        <c:url value="${product.images}" var="imgUrl"></c:url>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${product.images}" var="imgUrl"></c:url>
                    </c:otherwise>
                </c:choose>
                <img src="${imgUrl}" class="product-img" onerror="this.src='https://placehold.co/800x600/e9ecef/495057?text=No+Image'">
            </div>
            <div class="col-md-6">
                <span class="badge bg-primary fs-6 mb-2">${product.category.categoryname}</span>
                <h1 class="fw-bold display-5 mb-3">${product.productName}</h1>
                <p class="price-tag mb-4">${product.price} <small class="fs-4 text-muted">VNĐ</small></p>
                
                <div class="mb-4">
                    <h5>Mô tả sản phẩm:</h5>
                    <p class="text-secondary" style="line-height: 1.8;">
                        ${not empty product.description ? product.description : 'Sản phẩm này chưa có mô tả.'}
                    </p>
                </div>
                
                <div class="d-flex gap-3 align-items-center mb-4">
                    <div class="bg-light p-3 rounded text-center" style="width: 150px;">
                        <span class="d-block text-muted mb-1">Tình trạng</span>
                        <c:if test="${product.status == 1}">
                            <span class="fw-bold text-success"><i class="bi bi-check-circle"></i> Có sẵn (${product.stock})</span>
                        </c:if>
                        <c:if test="${product.status != 1}">
                            <span class="fw-bold text-danger"><i class="bi bi-x-circle"></i> Hết hàng</span>
                        </c:if>
                    </div>
                </div>

                <button class="btn btn-primary btn-lg rounded-pill px-5 py-3 fw-bold w-100" ${product.status != 1 ? 'disabled' : ''}>
                    <i class="bi bi-cart-plus me-2"></i> Thêm vào giỏ hàng
                </button>
            </div>
        </div>
    </div>
</body>
</html>
