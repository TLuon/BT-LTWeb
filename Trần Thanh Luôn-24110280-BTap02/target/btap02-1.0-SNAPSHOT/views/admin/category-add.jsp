<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: #fff;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .glass-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
        }
        .form-control, .form-control:focus {
            background: rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(255,255,255,0.1);
            color: #fff;
            border-radius: 10px;
            padding: 0.75rem 1rem;
        }
        .form-control::placeholder { color: rgba(255,255,255,0.4); }
        .form-label { font-weight: 600; color: #a8b2d1; font-size: 0.85rem; letter-spacing: 0.5px; }
        .btn-custom {
            border-radius: 50px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-custom:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .form-check-input:checked { background-color: #2ed573; border-color: #2ed573; }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="glass-card">
                    <div class="d-flex align-items-center mb-4 pb-3 border-bottom border-secondary">
                        <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-light rounded-circle me-3">
                            <i class="bi bi-arrow-left"></i>
                        </a>
                        <h3 class="mb-0 fw-bold">Thêm mới Category</h3>
                    </div>

                    <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
                        <div class="mb-4">
                            <label for="categoryname" class="form-label">TÊN CATEGORY</label>
                            <input type="text" class="form-control" id="categoryname" name="categoryname" placeholder="Nhập tên danh mục..." required>
                        </div>
                        
                        <div class="mb-4">
                            <label for="images" class="form-label">LINK HÌNH ẢNH (Tuỳ chọn)</label>
                            <input type="text" class="form-control" id="images" name="images" placeholder="https://...">
                        </div>

                        <div class="mb-4">
                            <label for="images1" class="form-label">UPLOAD HÌNH ẢNH (Tuỳ chọn)</label>
                            <input type="file" class="form-control" id="images1" name="images1" accept="image/*">
                        </div>

                        <div class="mb-5">
                            <label class="form-label d-block">TRẠNG THÁI</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="ston" name="status" value="1" checked>
                                <label class="form-check-label" for="ston">Hoạt động</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="stoff" name="status" value="0">
                                <label class="form-check-label" for="stoff">Khóa</label>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-info text-white btn-custom w-100 fs-5">
                            <i class="bi bi-cloud-arrow-up me-2"></i> Lưu Category
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
