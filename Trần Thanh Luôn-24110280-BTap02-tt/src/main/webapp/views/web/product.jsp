<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tất cả Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; background-color: #f4f6f9; }
        .product-card { border: none; border-radius: 15px; overflow: hidden; transition: all 0.3s ease; background: white; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .product-card img { height: 220px; object-fit: cover; }
        .price { color: #ff6b6b; font-weight: bold; font-size: 1.25rem; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="<c:url value='/'/>">MyApp</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/'/>">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link active" href="<c:url value='/product'/>">Sản phẩm</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h2 class="fw-bold mb-4">Tất cả Sản phẩm</h2>
        
        <div class="row g-4">
            <c:forEach items="${listProducts}" var="p">
                <div class="col-md-4 col-sm-6">
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
                            <img src="${imgUrl}" class="card-img-top" alt="img" onerror="this.src='https://placehold.co/400x300/e9ecef/495057?text=No+Image'">
                        </a>
                        <div class="card-body d-flex flex-column">
                            <span class="badge bg-info text-dark w-auto mb-2 align-self-start">${p.category.categoryname}</span>
                            <h5 class="card-title text-truncate">${p.productName}</h5>
                            <p class="price mt-auto">${p.price} VNĐ</p>
                            <a href="<c:url value='/product/detail?id=${p.productId}'/>" class="btn btn-primary rounded-pill w-100">Chi tiết</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Phân trang -->
        <nav class="mt-5">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item"><a class="page-link" href="<c:url value='/product?page=${currentPage - 1}'/>">Trang trước</a></li>
                </c:if>
                <c:forEach begin="1" end="${totalPage}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/product?page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${currentPage < totalPage}">
                    <li class="page-item"><a class="page-link" href="<c:url value='/product?page=${currentPage + 1}'/>">Trang sau</a></li>
                </c:if>
            </ul>
        </nav>
    </div>
</body>
</html>
