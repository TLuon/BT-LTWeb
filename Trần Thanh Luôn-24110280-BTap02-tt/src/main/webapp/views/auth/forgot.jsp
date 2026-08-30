<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên mật khẩu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-info text-white text-center">
                    <h4>Quên Mật Khẩu</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <p class="text-muted text-center">Nhập email đăng ký của bạn để nhận mã OTP khôi phục mật khẩu.</p>
                    <form action="${pageContext.request.contextPath}/forgot" method="post">
                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-info w-100 text-white">Gửi mã OTP</button>
                    </form>
                </div>
                <div class="card-footer text-center">
                    <a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
