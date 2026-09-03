<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Outfit', sans-serif; background-color: #f4f6f9; }
        .hero { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 4rem 0; text-align: center; border-radius: 0 0 50px 50px; margin-bottom: 3rem; }
        .product-card { border: none; border-radius: 15px; overflow: hidden; transition: all 0.3s ease; background: white; }
        .product-card:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }
        .product-card img { height: 200px; object-fit: cover; transition: transform 0.3s; }
        .product-card:hover img { transform: scale(1.05); }
        .price { color: #ff6b6b; font-weight: bold; font-size: 1.25rem; }
    </style>
</head>
<body>    <div class="hero shadow-lg">
        <h1 class="display-4 fw-bold">Khám phá Sản phẩm Mới nhất</h1>
        <p class="lead">Hàng ngàn sản phẩm chất lượng đang chờ đón bạn.</p>
    </div>

    <div class="container">
        <h2 class="fw-bold mb-4 text-center">Top 10 Sản phẩm Mới</h2>
        <div class="row g-4">
            <c:forEach items="${topProducts}" var="p">
                <div class="col-md-3 col-sm-6">
                    <div class="card product-card h-100 shadow-sm">
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>">
                            <c:choose>
                                <c:when test="${p.images != null && p.images.length() >= 5 && p.images.substring(0,5) == 'https'}">
                                    <c:url value="${p.images}" var="imgUrl"></c:url>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${p.images}" var="imgUrl"></c:url>
                                </c:otherwise>
                            </c:choose>
                            <img src="${imgUrl}" class="card-img-top" alt="Product image" onerror="this.src='https://placehold.co/400x300/e9ecef/495057?text=No+Image'">
                        </a>
                        <div class="card-body text-center">
                            <span class="badge bg-secondary mb-2">${p.category.categoryname}</span>
                            <h5 class="card-title text-truncate">
                                <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="text-dark text-decoration-none">${p.productName}</a>
                            </h5>
                            <p class="price">${p.price} VNĐ</p>
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-outline-primary rounded-pill w-100">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
